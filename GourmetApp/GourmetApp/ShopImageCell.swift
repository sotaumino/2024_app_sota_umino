//
//  ShopImageCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/09/24.
//

import UIKit
import Alamofire
import AlamofireImage

protocol shopImageCellDelegate {
    func onTapFavoriteButton(isAdd: Bool)
}

class ShopImageCell: UITableViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var delegate: shopImageCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shopImageView.image = nil
        favoriteButton.isSelected = false
        delegate = nil
    }

    func setupShopImageView(imageUrlString: String, isFavorite: Bool, delegate: shopImageCellDelegate){
        guard let shopImageUrl = URL(string: imageUrlString) else { return }
        shopImageView.af.setImage(withURL: shopImageUrl, placeholderImage: UIImage(named: "NoImage"))
        favoriteButton.isSelected = isFavorite
        updateFavoriteButtonAppearance()
        self.delegate = delegate
    }
    
    func updateFavoriteButtonAppearance(){
        if favoriteButton.isSelected {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func onTapFavoriteButton(_ sender: Any) {
        delegate?.onTapFavoriteButton(isAdd: !(sender as AnyObject).isSelected)
        }
}
