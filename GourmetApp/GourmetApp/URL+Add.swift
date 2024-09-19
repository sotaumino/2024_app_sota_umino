//
//  URL+Add.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/06.
//

import Foundation

extension URL {
    func addQueryItems(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: baseURL != nil) else { return nil }
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url
    }
}
