//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 16/06/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var forgetPasswdLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet var viewCorners: [UIView]!
    
    var checkBoxStatus:[Bool] = [true,true,true,true]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        addUnderLine()

    }
    
    func addUnderLine() {
        let text = forgetPasswdLabel.text
        let textRange = NSRange(location: 0, length: (text?.count)!)
        let attributedText = NSMutableAttributedString(string: text!)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        forgetPasswdLabel.attributedText = attributedText
    }
    
    func configUI(){
        emailTextField.layer.borderWidth = 1
        passwordTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.cornerRadius = 4
        continueButton.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
        for corner in viewCorners {
            corner.layer.cornerRadius = 5
        }
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton){
        let currentStatus = checkBoxStatus[sender.tag-1]
        if currentStatus == true {
            sender.setImage(UIImage(named: "checkBox"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "unCheckBox"), for: .normal)
        }
        checkBoxStatus[sender.tag - 1] = !currentStatus
    }

    @IBAction func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
