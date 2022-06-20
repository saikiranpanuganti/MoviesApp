//
//  ImageCollectionViewCell.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 20/06/22.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureUI(content: Content?) {
        image.backgroundColor = UIColor.red
        
        guard let url = URL(string: content?.imagery?.featuredImg ?? "") else { return }
        
        image.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
    }

}
