//
//  GenreEntity.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/09.
//

import Foundation

final internal class GenreEntity: NSObject {
    // お店ジャンルコード
    private(set) var code: String?
    // お店ジャンル名
    private(set) var name: String?
    // お店ジャンルキャッチ
    private(set) var catchText: String?
    
    init?(dic: [String: String]?) {
            guard let dic else { return nil }
            code = dic["code"]
            name = dic["name"]
            catchText = dic["catch"]
    }
}
