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
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeTitle: UILabel!
    
    var isMenuOpen: Bool = false
    var menuData: [Menu] = []
    var homeData: [Playlist] = []
    var settingsData: [Setting] = []
    
    var titleText: String = "" {
        willSet {
            print("title text old: ", titleText)
        }
        didSet {
            print("title text new: ", titleText)
            DispatchQueue.main.async {
                self.homeTitle.text = self.titleText
            }
        }
    }
    
    var allHomeData: [String: HomeData] = [:]
    var isSetting: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewWidth.constant = ScreenWidth
        menuWidth.constant = menuViewWidth
        menuLeading.constant = -menuViewWidth
        
        menuTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        menuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        homeTableView.register(UINib(nibName: "CarousalTableViewCell", bundle: nil), forCellReuseIdentifier: "CarousalTableViewCell")
        homeTableView.register(UINib(nibName: "SettingItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingItemTableViewCell")
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        getMenuData()
        createSettingsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuLeading.constant = -menuViewWidth
    }
    
    func createSettingsData() {
        settingsData = []
        
        settingsData.append(Setting(title: "My Account", caption: "Sign in to access all features", settingType: .account))
        
        settingsData.append(Setting(title: "Terms Of Use", caption: "Read all about our terms of use", settingType: .termsofuse))
        settingsData.append(Setting(title: "Contact Us", caption: "Want to contact us?", settingType: .contact))
        settingsData.append(Setting(title: "About Us", caption: "Read useful information about the App", settingType: .aboutus))
        settingsData.append(Setting(title: "My Activity", caption: "Manage all your activity", settingType: .myactivity))
        settingsData.append(Setting(title: "Privacy Policy", caption: "Read all abou our privacy policy", settingType: .privacy))
        settingsData.append(Setting(title: "Langauge", caption: "Change interface language", settingType: .langauge))
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
                
                if let homeId = self.menuData[0].id {
                    self.getHomeData(homeId: String(homeId))
                }
                
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
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
                    self.allHomeData[homeId] = homeModel.response?.data
                    
                    self.homeData = homeModel.response?.data?.playlists ?? []
                    self.titleText = homeModel.response?.data?.title ?? ""
                    
                    
                    DispatchQueue.main.async {
//                        self.homeTitle.text = self.titleText
                        self.homeTableView.reloadData()
                    }
                }else {
                    if let jsondata = try? JSONSerialization.jsonObject(with: data) {
                        print(jsondata)
                    }
                }
            }
        }.resume()
    }
}

extension RootViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == menuTableView {
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            if section == 0 {
                return 1
            }else {
                return menuData.count
            }
        }else {
            if isSetting {
                return settingsData.count
            }else {
                return homeData.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menuTableView {
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
        }else {
            if isSetting {
                if let cell = homeTableView.dequeueReusableCell(withIdentifier: "SettingItemTableViewCell", for: indexPath) as? SettingItemTableViewCell {
                    cell.configureUI(setting: settingsData[indexPath.row])
                    return cell
                }
            }else {
                if let cell = homeTableView.dequeueReusableCell(withIdentifier: "CarousalTableViewCell", for: indexPath) as? CarousalTableViewCell {
                    cell.configureUI(playlist: homeData[indexPath.row])
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == menuTableView {
            if indexPath.section == 0 {
                return 60
            }else {
                return 45
            }
        }else {
            if isSetting {
                return 70
            }else {
                return 220
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuTableView {
            print("Selected menu item: ", menuData[indexPath.row].title)
            if let id = menuData[indexPath.row].id {
                isSetting = false
                menuTapped()
                if let data = allHomeData[String(id)] {
//                    homeTitle.text = data.title
                    titleText = data.title ?? ""
                    homeData = data.playlists ?? []
                    homeTableView.reloadData()
                }else {
                    getHomeData(homeId: String(id))
                }
            }
        }else {
            if isSetting {
                if settingsData[indexPath.row].settingType == .account {
                    SettingType.account.selectedSettingItem()
                    print(SettingType.account.rawValue)
                }else if settingsData[indexPath.row].settingType == .langauge {
                    SettingType.langauge.selectedSettingItem()
                }else if settingsData[indexPath.row].settingType == .termsofuse {
                    SettingType.termsofuse.selectedSettingItem()
                }else if settingsData[indexPath.row].settingType == .contact {
                    SettingType.contact.selectedSettingItem()
                }else if settingsData[indexPath.row].settingType == .aboutus {
                    SettingType.aboutus.selectedSettingItem()
                }else if settingsData[indexPath.row].settingType == .myactivity {
                    SettingType.myactivity.selectedSettingItem()
                }else if settingsData[indexPath.row].settingType == .privacy {
                    SettingType.privacy.selectedSettingItem()
                }
            }
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
        isSetting = true
        menuTapped()
        homeTableView.reloadData()
    }
}


// User selected Account
// User selected Language option
// User selected Terms of Use item
// User selected contact
// User selected about
// User selected activity
// User selected privacy policy

