//
//  RecommendViewCell.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2025/02/01.
//

import UIKit

class RecommendViewCell: UITableViewCell {

    @IBOutlet weak var FreeFoodStackView: UIStackView!
    @IBOutlet weak var FreeDrinkStackView: UIStackView!
    @IBOutlet weak var PrivateRoomStackView: UIStackView!
    @IBOutlet weak var zashikiStackView: UIStackView!
    @IBOutlet weak var HorigotatsuSatackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setUp(freeDrink: String, freeFood: String, privateRoom: String, horigotatu: String, tatami: String)
    {
        if freeDrink.contains("あり") 
        {
            FreeFoodStackView.backgroundColor = UIColor.gray
        }
            
        if freeFood.contains("あり") {
            FreeDrinkStackView.backgroundColor = UIColor.gray
        }
            
        if privateRoom.contains("あり") {
            PrivateRoomStackView.backgroundColor = UIColor.gray
        }
        
        if horigotatu.contains("あり") {
            HorigotatsuSatackView.backgroundColor = UIColor.gray
        }
        
        if tatami.contains("あり") {
            zashikiStackView.backgroundColor = UIColor.gray
        }
    }

}
