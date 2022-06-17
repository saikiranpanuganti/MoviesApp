//
//  RegisterViewController.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 16/06/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerStackView:UIStackView!
    @IBOutlet weak var mobileStackView:UIStackView!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var emailPasswordTextField:UITextField!
    @IBOutlet weak var mobileTextField:UITextField!
    @IBOutlet weak var mobilePasswordTextField:UITextField!
    @IBOutlet weak var emailTitleView:UIView!
    @IBOutlet weak var emailComponentsView:UIView!
    @IBOutlet weak var mobileTitleView:UIView!
    @IBOutlet weak var mobileComponentsView:UIView!
    @IBOutlet weak var emailRegisterButton:UIButton!
    @IBOutlet weak var mobileRegisterButton:UIButton!
    @IBOutlet weak var facebookView:UIView!
    @IBOutlet weak var twitterView:UIView!
    @IBOutlet weak var appleView:UIView!
    @IBOutlet var checkBoxImageCollection:[UIButton]!
    
    
    var checkBoxImageStatus:[Bool] = [true, true, true, true, true, true, true, true, true, true, true, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCornerRadius()
        setUpTextFields()
        mobileComponentsView.isHidden = true
        
    }
    func addCornerRadius() {
        registerStackView.layer.cornerRadius = 10.0
        registerStackView.layer.masksToBounds = true
        mobileStackView.layer.cornerRadius = 10.0
        mobileStackView.layer.masksToBounds = true
        facebookView.layer.cornerRadius = 5.0
        twitterView.layer.cornerRadius = 5.0
        appleView.layer.cornerRadius = 5.0
        mobileRegisterButton.layer.cornerRadius = 10.0
        emailRegisterButton.layer.cornerRadius = 10.0
    }
    func setUpTextFields() {
        emailTextField.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        mobileTextField.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        mobileTextField.attributedPlaceholder = NSAttributedString(string: "Mobile", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailPasswordTextField.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        emailPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        mobilePasswordTextField.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        mobilePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    @IBAction func emailTapped() {
        if emailComponentsView.isHidden {
            emailComponentsView.isHidden = false
            emailTitleView.backgroundColor = UIColor(named: "appOrange")
            mobileComponentsView.isHidden = true
            mobileTitleView.backgroundColor = UIColor.darkGray
        }else {
            emailComponentsView.isHidden = true
            emailTitleView.backgroundColor = UIColor.darkGray
        }
    }
    @IBAction func mobileTapped() {
        if mobileComponentsView.isHidden {
            mobileComponentsView.isHidden = false
            mobileTitleView.backgroundColor = UIColor(named: "appOrange")
            emailComponentsView.isHidden = true
            emailTitleView.backgroundColor = UIColor.darkGray
        }else {
            mobileComponentsView.isHidden = true
            mobileTitleView.backgroundColor = UIColor.darkGray
        }
    }
    @IBAction func checkBoxTapped(sender: UIButton) {
        let currentStatus = checkBoxImageStatus[sender.tag - 1]
        if currentStatus == true {
            sender.setImage(UIImage(named: "unCheckBox"), for: .normal)
        }else {
            sender.setImage(UIImage(named: "checkBox"), for: .normal)
        }
        checkBoxImageStatus[sender.tag - 1] = !currentStatus
    }
    
    @IBAction func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
