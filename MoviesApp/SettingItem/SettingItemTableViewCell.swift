//
//  SettingItemTableViewCell.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 22/06/22.
//

import UIKit

class SettingItemTableViewCell: UITableViewCell {
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var settingCaption: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(setting: Setting) {
        settingTitle.text = setting.title
        settingCaption.text = setting.caption
    }
    
}
