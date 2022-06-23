//
//  MenuTableViewCell.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 17/06/22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureUI(menu: Menu?) {
        menuTitle.text = menu?.title
        
        if menu?.isSelected ?? false {
            menuTitle.textColor = UIColor.orange
        }else {
            menuTitle.textColor = UIColor.white
        }
    }
}
