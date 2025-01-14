//
//  CouponUrlEntity.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/12.
//

import Foundation

final internal class CouponUrlEntity: NSObject {
    // PC用
    private(set) var pc: String?
    // スマートフォン用
    private(set) var sp: String?
    
    init?(dic: [String: String]?) {
        guard let dic else { return nil }
        pc = dic["pc"]
        sp = dic["sp"]
    }
}
