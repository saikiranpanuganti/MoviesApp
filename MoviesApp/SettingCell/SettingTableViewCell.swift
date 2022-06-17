//
//  SettingTableViewCell.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 17/06/22.
//

import UIKit

protocol SettingTableViewCellDelegate {
    func loginTapped()
    func registerTapped()
    func settingsTapped()
}

class SettingTableViewCell: UITableViewCell {
    var delegate: SettingTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func loginTapped() {
        delegate?.loginTapped()
    }
    
    @IBAction func registerTapped() {
        delegate?.registerTapped()
    }
    
    @IBAction func settingsTapped() {
        delegate?.settingsTapped()
    }
    
}
