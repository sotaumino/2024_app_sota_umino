//
//  ListCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/08/29.
//

import UIKit
// import AlamofireImage

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
    //func setShopImageView(imageUrlString: String) {
    //    guard let shopOmageUrl = URL(string: imageUrlString) else {return}
    //    shopImageView.af.setImage(withURL: shopOmageUrl, placeholderImage: UIImage(named: "NoImage"))
    //}
    
    func setup(entity: GourmetSearchShopEntity) {
        // テキストとフォントの設定
        shopNameLabel.text = entity.name
        shopNameLabel.font = UIFont.systemFont(ofSize: 15)

        genreLabel.text = entity.genre?.name
        genreLabel.font = UIFont.systemFont(ofSize: 10)

        addressLabel.text = entity.address
        addressLabel.font = UIFont.systemFont(ofSize: 10)

        setupObsession(privateRoom: entity.privateRoom, card: entity.card, nonSmoking: entity.nonSmoking)

        // すでに制約が適用されているか確認し、重複しないようにする
        if shopNameLabel.constraints.isEmpty {
            NSLayoutConstraint.activate([
                shopNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                shopNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                shopNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

                genreLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
                genreLabel.trailingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor),
                genreLabel.topAnchor.constraint(equalTo: shopNameLabel.bottomAnchor, constant: 8),

                addressLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
                addressLabel.trailingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor),
                addressLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),

                obsessionLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
                obsessionLabel.trailingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor),
                obsessionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
                obsessionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
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
        obsessionLabel.font = UIFont.systemFont(ofSize: 10)
        obsessionLabel.textColor = UIColor.white
        obsessionLabel.backgroundColor = UIColor.red
    }
    
}
