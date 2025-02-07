//
//  FavoriteViewCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/10/10.
//

import UIKit

class FavoriteViewCell: UICollectionViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shopImageView.image = nil
        shopNameLabel.text = ""
    }
    
    func setup(entity: GourmetSearchShopEntity){
        setupShopImageView(imageUrlString: entity.photo?.mobileSmall ?? "")
        shopNameLabel.text = entity.shopName
    }
    
    
    func setupShopImageView(imageUrlString: String){
        guard let shopImageUrl = URL(string: imageUrlString) else { return }
        shopImageView.af.setImage(withURL: shopImageUrl, placeholderImage: UIImage(named: "NoImage"))
    }
}
