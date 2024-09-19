//
//  ShopDetailController.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/10.
//

import UIKit

class ShopDetailController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var couponButton: UIButton!
    
    
    var shopEntity: GourmetSearchShopEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = shopEntity?.name
        
        self.couponButton.isHidden = self.isHiddenCouponButton()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellName.ShopDetailCell, bundle: nil), forCellReuseIdentifier: CellName.ShopDetailCell)
    }

    @IBAction func couponButton(_ sender: Any) {
        let couponController = CouponController()
        
        guard let couponUrl = shopEntity?.couponUrls?.sp else { return }
        
        couponController.couponUrl = couponUrl
        
        self.navigationController?.pushViewController(couponController, animated: true)
    }
    
    func isHiddenCouponButton() -> Bool {
        return shopEntity?.couponUrls?.sp?.isEmpty ?? true
    }
    
}


extension ShopDetailController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopEntity != nil ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.ShopDetailCell, for: indexPath) as? ShopDetailCell else {
                    return UITableViewCell()
                }
        // shopEntityがある場合、カスタムセルにデータをセット
        if let shopEntity = shopEntity {
            switch indexPath.row {
            // ジャンル
            case 0:
                let genreName = shopEntity.genre?.name ?? "ジャンルなし"
                cell.setup(title: "ジャンル", detail: genreName)
            // 交通アクセス
            case 1:
                cell.setup(title: "交通アクセス", detail: shopEntity.access ?? "")
            // 住所
            case 2:
                cell.setup(title: "住所", detail: shopEntity.address ?? "")
            // コース
            case 3:
                cell.setup(title: "個室", detail: shopEntity.privateRoom ?? "")
            // 飲み放題
            case 4:
                cell.setup(title: "飲み放題", detail: shopEntity.freeDrink ?? "")
            // 食べ放題
            case 5:
                cell.setup(title: "食べ放題", detail: shopEntity.freeFood ?? "")
            // 個室
            case 6:
                cell.setup(title: "個室", detail: shopEntity.privateRoom ?? "")
            // 掘りごたつ
            case 7:
                cell.setup(title: "掘りごたつ", detail: shopEntity.horigotatsu ?? "")
            // 座敷
            case 8:
                cell.setup(title: "座敷", detail: shopEntity.tatami
                           ?? "")
            // カード可
            case 9:
                cell.setup(title: "カード", detail: shopEntity.card ?? "")
                
            default:
                break
            }
        }

        return cell
    }
    
}
