//
//  GourmetSearchFetcher.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/04.
//

import Foundation

class GourmetSearchFetcher: NSObject {
    private let defaultQueryItems = [URLQueryItem(name: "key", value: Secret.apiKey), URLQueryItem(name: "count", value: "100"), URLQueryItem(name: "format", value: "json")]
    
    func fetchTokyo (success: @escaping ([GourmetSearchShopEntity]) -> Void, failer: @escaping () -> Void) {
        apiFetch(queryItems: makeFetchForTokyoQueryItems(), success: success, failer: failer)
    }
    
    func makeFetchForTokyoQueryItems() -> [URLQueryItem] {
        defaultQueryItems + [URLQueryItem(name: "large_area", value: "Z011")]
    }
    
    func fetchForShopName(_ searchText: String,
                          selectedSortIndex: Int = 3, // デフォルトを「おススメ順」に設定
                          success: @escaping ([GourmetSearchShopEntity]) -> Void,
                          failure: @escaping () -> Void) {
        
        let queryItems = makeShopNameSearchFetchQueryItems(searchText: searchText, selectedSortIndex: selectedSortIndex)
        apiFetch(queryItems: queryItems, success: success, failer: failure)
    }
    
    func fetchForShopIds(_ shopIds: [String], success: @escaping ([GourmetSearchShopEntity]) -> Void, failer: @escaping () -> Void){
        let queryItems = makeFetchQueryItems(shopIds: shopIds)
        
        apiFetch(queryItems: queryItems, success: success, failer: failer)
    }
    
    private func makeShopNameSearchFetchQueryItems(searchText: String, selectedSortIndex: Int) -> [URLQueryItem] {
        let sortValue = "\(selectedSortIndex + 1)"  // インデックスを使って順番を決定
        return defaultQueryItems + [
            URLQueryItem(name: "name_any", value: searchText),
            URLQueryItem(name: "order", value: sortValue)
        ]
    }
    
    private func makeFetchQueryItems(shopIds: [String]) -> [URLQueryItem] {
        let shopIdParameterValue = shopIds.joined(separator: ",")
        return defaultQueryItems + [URLQueryItem(name: "id", value: shopIdParameterValue)]
    }
    
    func apiFetch(queryItems: [URLQueryItem], success: @escaping(([GourmetSearchShopEntity]) -> Void), failer: @escaping () -> Void) {
        guard let url = URL(string : Secret.gourmetSearchApi)?.addQueryItems(queryItems) else {return failer()}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data, error == nil else {return failer()}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let results = json?["results"] as? [String: Any]
                
                guard results?["error"] == nil else { return failer() }
                
                let shops = results?["shop"] as? [[String: Any]] ?? []
                
                
                let shopEntities = shops.compactMap { shop -> GourmetSearchShopEntity? in
                    return GourmetSearchShopEntity(dic: shop)
                }
                
                success(shopEntities)
            } catch {
                failer()
            }
        }.resume()
    }
}
