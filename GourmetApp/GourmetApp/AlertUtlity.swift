//
//  AlertUtlity.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/11/19.
//

import UIKit

final internal class AlertUtlity: NSObject 
{
    // お気に入り上限時のアラート作成
    class func makeFavoriteMaxAlert() -> UIAlertController
    {
        let msg = "お気に入りの上限(20件)を超えるため追加することができませんでした。\n不要なお気に入りを削除してから再度お試しください。"
        let alert = UIAlertController(title: "お気に入り追加失敗", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
    
    // 通信エラー時のアラート作成
    class func makeFetchErrorAlert(retryAction: @escaping() -> Void) -> UIAlertController
    {
        let msg = "通信失敗しました。\n再度取得しますか？"
        let alert = UIAlertController(title: "通信エラー", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default)
        { _ in
            retryAction()
        })
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        return alert
    }
}

