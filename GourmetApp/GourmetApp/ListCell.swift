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
        if let imageUrlString = entity.photo?.pcMedium {
            setupShopImageView(imageUrlString: imageUrlString)
        } else {
            // 画像URLがnilの場合の処理
            print("画像URLが存在しません")
        }
        
        shopNameLabel.text = entity.name

        genreLabel.text = entity.genre?.name

        addressLabel.text = entity.address

        setupObsession(privateRoom: entity.privateRoom, card: entity.card, nonSmoking: entity.nonSmoking)
        
        setupConstraints()

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
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Shop Image View Constraints
            shopImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shopImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shopImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            shopImageView.widthAnchor.constraint(equalTo: shopImageView.heightAnchor),

            // Shop Name Label Constraints
            shopNameLabel.leadingAnchor.constraint(equalTo: shopImageView.trailingAnchor, constant: 16),
            shopNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            shopNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            // Genre Label Constraints
            genreLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor),
            genreLabel.topAnchor.constraint(equalTo: shopNameLabel.bottomAnchor, constant: 4),

            // Address Label Constraints
            addressLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor),
            addressLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 4),

            // Obsession Label Constraints
            obsessionLabel.leadingAnchor.constraint(equalTo: shopNameLabel.leadingAnchor),
            obsessionLabel.trailingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor),
            obsessionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            obsessionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
