//
//  ListCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/08/29.
//

import UIKit
import AlamofireImage
import Alamofire

class ListCell: UITableViewCell {
    
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var obsessionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shopImageView.image = nil
        shopNameLabel.text = ""
        genreLabel.text = ""
        addressLabel.text = ""
        obsessionLabel.text = ""
        
    }
    
    // 店舗画像
    func setupShopImageView(imageUrlString: String) {
        guard let shopImageUrl = URL(string: imageUrlString) else {return}
        shopImageView.af.setImage(withURL: shopImageUrl, placeholderImage: UIImage(named: "NoImage"))
    }
    
    func setup(entity: GourmetSearchShopEntity) {
        if let imageUrlString = entity.photo?.mobileSmall {
            setupShopImageView(imageUrlString: imageUrlString)
        } else {
            // 画像URLがnilの場合の処理
            print("画像URLが存在しません")
        }
        
        shopNameLabel.text = entity.name
        
        genreLabel.text = entity.genre?.name
        
        addressLabel.text = entity.address
        
        setupObsession(privateRoom: entity.privateRoom, card: entity.card, nonSmoking: entity.nonSmoking)
    }
    
    // こだわり
    func setupObsession(privateRoom: String?, card: String?, nonSmoking: String?){
        
        var obsession = [String]()
        
        if let privateRoom, !privateRoom.isEmpty, privateRoom != "なし" {
            obsession.append("個室あり")
        }
        
        if let card, !card.isEmpty {
            obsession.append("card\(card)")
        }
        
        if let nonSmoking, !nonSmoking.isEmpty {
            obsession.append(nonSmoking)
        }
        
        obsessionLabel.text = obsession.joined(separator: ",")
    }
}
