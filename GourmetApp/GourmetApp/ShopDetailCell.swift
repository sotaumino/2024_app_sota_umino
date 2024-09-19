//
//  ShopDetailCell.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/11.
//

import UIKit

class ShopDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        detailLabel.text = ""
        
    }

    func setup(title: String, detail: String){
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        detailLabel.text = detail
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        detailLabel.textColor = .gray
        detailLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            // titleLabel の制約
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            // detailLabel の制約
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            // titleLabel と detailLabel の間に 8pt の余白
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
