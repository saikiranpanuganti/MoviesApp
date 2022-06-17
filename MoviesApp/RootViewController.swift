//
//  RootViewController.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 16/06/22.
//

import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeViewWidth: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuLeading: NSLayoutConstraint!
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    @IBOutlet weak var menuTableView: UITableView!
    
    var isMenuOpen: Bool = false
    var menuData: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewWidth.constant = ScreenWidth
        menuWidth.constant = menuViewWidth
        menuLeading.constant = -menuViewWidth
        
        menuTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        menuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        getMenuData()
    }

    @IBAction func menuTapped() {
        if isMenuOpen {
            menuLeading.constant = -menuViewWidth
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            } completion: { bool in
                self.isMenuOpen = false
            }
        }else {
            menuLeading.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            } completion: { bool in
                self.isMenuOpen = true
            }
        }
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
                self.menuData = menuModel?.body?.data ?? []
                
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                }
                
                print("menu count", menuModel?.body?.data?.count)
            }
        }.resume()
    }
}

extension RootViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return menuData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = menuTableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell {
                cell.delegate = self
                return cell
            }
        }else if indexPath.section == 1 {
            if let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell {
                cell.configureUI(menu: menuData[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }else {
            return 45
        }
    }
}


extension RootViewController: SettingTableViewCellDelegate {
    func loginTapped() {
        print("loginTapped")
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func registerTapped() {
        print("registerTapped")
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func settingsTapped() {
        print("settingsTapped")
    }
}
