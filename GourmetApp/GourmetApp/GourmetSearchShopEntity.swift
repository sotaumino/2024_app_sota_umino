//
//  GourmetSearchShopEntity.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/04.
//

import Foundation

final internal class GourmetSearchShopEntity: NSObject {
    // 店名
    private(set) var name: String?
    // 住所
    private(set) var address: String?
    // お店ジャンル
    private(set) var genre: GenreEntity?
    // 個室
    private(set) var privateRoom: String?
    // カード可
    private(set) var card: String?
    // 禁煙席
    private(set) var nonSmoking: String?
    // 交通アクセス
    private(set) var access: String?
    // コース
    private(set) var course: String?
    // 飲み放題
    private(set) var freeDrink: String?
    // 食べ放題
    private(set) var freeFood: String?
    // 掘りごたつ
    private(set) var horigotatsu: String?
    // 座敷
    private(set) var tatami: String?
    // クーポン
    private(set) var couponUrls: CouponUrlEntity?
    
    // イニシャライザに辞書データを受け取る
    init?(dic: [String: Any]) {
        // 辞書から店名と住所を抽出し、存在しない場合はnilを返す
        guard let name = dic["name"] as? String,
              let address = dic["address"] as? String,
              let genre = GenreEntity(dic: dic["genre"] as? [String: String]),
              let privateRoom = dic["private_room"] as? String,
              let card = dic["card"] as? String,
              let nonSmoking = dic["non_smoking"] as? String,
              let access = dic["access"] as? String,
              let course = dic["course"] as? String,
              let freeDrink = dic["free_drink"] as? String,
              let freeFood = dic["free_food"] as? String,
              let horigotatsu = dic["horigotatsu"] as? String,
              let tatami = dic["tatami"] as? String,
              let couponUrls = CouponUrlEntity(dic: dic["coupon_urls"] as? [String: String])
        else {
            return nil
        }
        self.name = name
        self.address = address
        self.genre = genre
        self.privateRoom = privateRoom
        self.card = card
        self.nonSmoking = nonSmoking
        self.access = access
        self.course = course
        self.freeDrink = freeDrink
        self.freeFood = freeFood
        self.horigotatsu = horigotatsu
        self.tatami = tatami
        self.couponUrls = couponUrls
    }
}
