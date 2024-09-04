//
//  ListCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/08/29.
//

import UIKit
import AlamofireImage

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
    func setShopImageView(imageUrlString: String) {
        guard let shopOmageUrl = URL(string: imageUrlString) else {return}
        shopImageView.af.setImage(withURL: shopOmageUrl, placeholderImage: UIImage(named: "NoImage"))
    }
    
    // こだわり
    func setupObsession(privateRoom: String?, card: String?, nonSmoking: String?){
        
        var obsession = [String]()
        
        if let privateRoom, !privateRoom.isEmpty, privateRoom != "なし" {
            obsession.append("個室")
        }
        
        if let card, !card.isEmpty {
            obsession.append("card\(card)")
        }
        
        if let nonSmoking, nonSmoking.isEmpty {
            obsession.append(nonSmoking)
        }
        
        obsessionLabel.text = obsession.joined(separator: ",")
    }
    
}
