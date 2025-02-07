//
//  ShopDetailNameCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2025/01/28.
//

import UIKit

protocol ShopDetailNameCellDelegate {
    func onTapFavoriteButton(isAdd: Bool)
}

class ShopDetailNameCell: UITableViewCell {

    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopInfoLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var delegate: ShopDetailNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shopNameLabel.text = ""
        shopInfoLabel.text = ""
        favoriteButton.isSelected = false
        delegate = nil
    }

    public func setUp(shopName: String, genre: String, catchCopy: String, bFavorite: Bool, delegate: ShopDetailNameCellDelegate)
    {
        // 店舗名
        shopNameLabel.text = shopName
        // ジャンル名、キャッチコピー
        shopInfoLabel.text = "\(genre) | \(catchCopy)"
        // お気に入り
        favoriteButton.isSelected = bFavorite
        updateFavoriteButtonAppearance()
        // delegate
        self.delegate = delegate
    }
    
    func updateFavoriteButtonAppearance(){
        if favoriteButton.isSelected 
        {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else
        {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }

    @IBAction func onTapDavoriteButton(_ sender: Any) 
    {
        delegate?.onTapFavoriteButton(isAdd: !(sender as AnyObject).isSelected)
    }
    
}
