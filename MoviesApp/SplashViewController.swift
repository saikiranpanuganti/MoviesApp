//
//  SplashViewController.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 23/06/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMenuData()
    }
    
    func getMenuData() {
        guard let url = URL(string: "https://jwxebkwcfj.execute-api.us-east-1.amazonaws.com/dev/menu") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de7d7"
        
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let menuModel = try? JSONDecoder().decode(MenuModel.self, from: data)
                print("Home id: ", menuModel?.body?.data?[0].id)
                AppData.shared.menuData = menuModel?.body?.data ?? []
                
                if let homeId = AppData.shared.menuData[0].id {
                    self.getHomeData(homeId: String(homeId))
                }
            }
        }.resume()
    }
    
    func getHomeData(homeId: String) {
        guard let url = URL(string: "https://n6lih99291.execute-api.ap-south-1.amazonaws.com/dev/home") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de7d7"
        headers["Content-Type"] = "application/json"
        
        urlRequest.allHTTPHeaderFields = headers
        
        let body: [String: Any] = ["homeid" : homeId]
        
        if let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
            urlRequest.httpBody = bodyData
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                if let homeModel = try? JSONDecoder().decode(HomeModel.self, from: data) {
                    print("HomeModel: ", homeModel.response?.data?.playlists?.count)
                    AppData.shared.allHomeData[homeId] = homeModel.response?.data
                    
                    AppData.shared.homeData = homeModel.response?.data?.playlists ?? []
                    
                    AppData.shared.menuData[0].isSelected = true
                    
                    DispatchQueue.main.async {
                        self.navigateToHome()
                    }
                }else {
                    if let jsondata = try? JSONSerialization.jsonObject(with: data) {
                        print(jsondata)
                    }
                }
            }
        }.resume()
    }
    
    func navigateToHome() {
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootViewController {
            navigationController?.viewControllers = [controller]
            navigationController?.popToRootViewController(animated: true)
        }
        
        
//        navigationController?.popViewController(animated: true)
//        navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
//        navigationController?.popToRootViewController(animated: true)
    }

}
