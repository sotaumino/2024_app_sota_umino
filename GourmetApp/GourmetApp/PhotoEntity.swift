//
//  PhotoEntity.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/09/23.
//

import Foundation

final internal class PhotoEntity: NSObject {
    // PC向け（大）画像URL
    private(set) var pcLarge: String?
    // PC向け（中）画像URL
    private(set) var pcMedium: String?
    // PC向け（小）画像URL
    private(set) var pcSmall: String?
    // 携帯向け（大）画像URL
    private(set) var mobileLarge: String?
    // 携帯向け（小）画像URL
    private(set) var mobileSmall: String?
    
    init?(dic: [String: Any]?){
        guard let dic else { return nil }
        if let pcDic = dic["pc"] as? [String: String] {
            pcLarge = pcDic["l"]
            pcMedium = pcDic["m"]
            pcSmall = pcDic["s"]
        }
        
        if let mobileDic = dic["mobile"] as? [String: String] {
            mobileLarge = mobileDic["l"]
            mobileSmall = mobileDic["s"]
        }
    }
    
}
