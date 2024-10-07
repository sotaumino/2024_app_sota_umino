//
//  UserDefaultsManager.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/09/30.
//

import Foundation

internal class UserDefaultsManager : NSObject {
    
    class func addShopId(_ shopId: String) -> Bool {
        let shopIds = favoriteShopIds()
        
        guard shopIds.count < 20 else { return false }
        
        if !shopIds.contains(shopId){
            updateFavoriteShopIds(shopIds + [shopId])
        }
        
         return true
    }
    
    class func deleatShopId (_ shopId: String) {
        var shopIds = favoriteShopIds()
        
        if let deleteIndex = shopIds.firstIndex(of: shopId){
            shopIds.remove(at: deleteIndex)
            updateFavoriteShopIds(shopIds)
        }
    }
    
    class func favoriteShopIds() -> [String] {
        UserDefaults.standard.stringArray(forKey: "FavoriteShopIds") ?? []
    }
    
    class func updateFavoriteShopIds(_ shopId: [String]) {
        UserDefaults.standard.setValue(shopId, forKey: "FavoriteShopIds")
    }
    
    class func isFavorite(_ shopId: String) -> Bool {
        let shopIds = favoriteShopIds()
        return shopIds.contains(shopId)
    }
}
