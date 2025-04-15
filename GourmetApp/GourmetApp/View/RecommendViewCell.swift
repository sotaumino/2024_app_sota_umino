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
    
    @IBOutlet weak var FreeFoodView: UIView!
    @IBOutlet weak var HorigotatsuView: UIView!
    @IBOutlet weak var ZashikiView: UIView!
    @IBOutlet weak var PrivateRoomView: UIView!
    @IBOutlet weak var FreeDrinkView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setUp(freeDrink: String, freeFood: String, privateRoom: String, horigotatu: String, tatami: String)
    {
        if freeDrink.contains("あり")
        {
            FreeDrinkView.isHidden = false
        }
        else {
            FreeDrinkView.isHidden = true
        }
            
        if freeFood.contains("あり") {
            FreeFoodView.isHidden = false
        } 
        else {
            FreeFoodView.isHidden = true
        }
            
        if privateRoom.contains("あり") {
            PrivateRoomView.isHidden = false
        }
        else {
            PrivateRoomView.isHidden = true
        }
        
        if horigotatu.contains("あり") {
            HorigotatsuView.isHidden = false
        }
        else {
            HorigotatsuView.isHidden = true
        }
        
        if tatami.contains("あり") {
             ZashikiView.isHidden = false
        }
        else {
            ZashikiView.isHidden = true
        }
    }

}
