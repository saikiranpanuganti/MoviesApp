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
    
    var isMenuOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewWidth.constant = ScreenWidth
        menuLeading.constant = -200
    }

    @IBAction func menuTapped() {
        if isMenuOpen {
            menuLeading.constant = -200
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
}
