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
    
    private var delegate: shopImageCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shopImageView.image = nil
        delegate = nil
    }

    func setupShopImageView(imageUrlString: String){
        guard let shopImageUrl = URL(string: imageUrlString) else { return }
        shopImageView.af.setImage(withURL: shopImageUrl, placeholderImage: UIImage(named: "NoImage"))
    }
}
