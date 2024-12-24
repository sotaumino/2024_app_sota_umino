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
        detailLabel.text = detail
    }
}
