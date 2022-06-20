//
//  CarousalTableViewCell.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 20/06/22.
//

import UIKit

class CarousalTableViewCell: UITableViewCell {
    @IBOutlet weak var carousalTitle: UILabel!
    @IBOutlet weak var carousalCollectionView: UICollectionView!
    
    var playlist: Playlist?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        carousalCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        carousalCollectionView.delegate = self
        carousalCollectionView.dataSource = self
    }
    
    func configureUI(playlist: Playlist?) {
        if let playlist = playlist {
            self.playlist = playlist
            
            carousalTitle.text = playlist.title
            
            carousalCollectionView.reloadData()
        }
    }
}

extension CarousalTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist?.content?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = carousalCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            cell.configureUI(content: playlist?.content?[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CarousalTableViewCell: UICollectionViewDelegate {
    
}

extension CarousalTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 210, height: 210)
    }
}
