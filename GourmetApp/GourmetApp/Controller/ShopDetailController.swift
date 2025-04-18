//
//  ShopDetailController.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/10.
//

import UIKit

enum ShopDetailCellType: Int, CaseIterable {
    case shopImage
    case shopDetailName
    case recommend
    case access
    case adress
    case privateRoom
    case freeDrink
    case freeFood
    case course
    case horigotatu
    case tatami
    case card
    
    func title() -> String {
        switch self {
        case .shopImage: 
            return "店舗画像"
        case .shopDetailName:
            return ""
        case .recommend:
            return ""
        case .access:
            return "交通アクセス"
        case .adress:
            return "住所"
        case .privateRoom:
            return "個室"
        case .freeDrink:
            return "飲み放題"
        case .freeFood:
            return "食べ放題"
        case .course:
            return "コース"
        case .horigotatu:
            return "掘りごたつ"
        case .tatami:
            return "座敷"
        case .card:
            return "カード"
        }
    }
    
    func detail(entity: GourmetSearchShopEntity?) -> String {
        guard let entity else { return "" }
        
        let result: String?
        switch self {
        case .shopImage:
            result = nil
        case .shopDetailName:
            return ""
        case .recommend:
            return ""
        case .access:
            result = entity.access
        case .adress:
            result = entity.address
        case .privateRoom:
            result = entity.privateRoom
        case .freeDrink:
            result = entity.freeDrink
        case .freeFood:
            result = entity.freeFood
        case .course:
            result = entity.course
        case .horigotatu:
            result = entity.horigotatsu
        case .tatami:
            result = entity.tatami
        case .card:
            result = entity.card
        }
        return result ?? ""
    }
}

class ShopDetailController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var couponButton: UIButton!
    
    
    var shopEntity: GourmetSearchShopEntity?
    
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = shopEntity?.shopName
        
        self.couponButton.isHidden = self.isHiddenCouponButton()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup(shopEntity: shopEntity!)
        
        tableView.register(UINib(nibName: CellName.ShopDetailCell, bundle: nil), forCellReuseIdentifier: CellName.ShopDetailCell)
        tableView.register(UINib(nibName: CellName.shopImageCell, bundle: nil), forCellReuseIdentifier: CellName.shopImageCell)
        tableView.register(UINib(nibName: CellName.ShopDetailNameCell, bundle: nil), forCellReuseIdentifier: CellName.ShopDetailNameCell)
        tableView.register(UINib(nibName: CellName.RecommendViewCell, bundle: nil), forCellReuseIdentifier: CellName.RecommendViewCell)
    }
    
    func setup(shopEntity entity: GourmetSearchShopEntity){
        shopEntity = entity
        updateIsFavorite()
    }

    @IBAction func couponButton(_ sender: Any) {
        let couponController = CouponController()
        
        guard let couponUrl = shopEntity?.couponUrls?.sp else { return }
        
        couponController.setup(couponUrl: couponUrl)
        
        self.navigationController?.pushViewController(couponController, animated: true)
    }
    
    func isHiddenCouponButton() -> Bool {
        return shopEntity?.couponUrls?.sp?.isEmpty ?? true
    }
    
    // お気に入り更新
    func updateIsFavorite() {
        guard let shopId = shopEntity?.shopId else { return }
        isFavorite = UserDefaultsManager.isFavorite(shopId)
    }
    
    // 店舗画像Cell作成
    func makeShopImageCell(_ indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.shopImageCell, for: indexPath) as? ShopImageCell
        cell?.setupShopImageView(imageUrlString: (shopEntity?.photo?.mobileSmall)!)
        
        return cell ?? UITableViewCell()
    }
    // 店舗詳細Cell作成
    func makeShopDetailCell(_ indexPath: IndexPath, cellType: ShopDetailCellType) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.ShopDetailCell, for: indexPath) as? ShopDetailCell
        cell?.setup(title: cellType.title(), detail: cellType.detail(entity: shopEntity))
        return cell ?? UITableViewCell()
    }
    
    // 店舗名・ジャンル・キャッチコピーCell作成
    private func makeShopDetailNameCell(_ indexPath: IndexPath) -> UITableViewCell
    {
        let shopDetailNameCell = tableView.dequeueReusableCell(withIdentifier: CellName.ShopDetailNameCell, for: indexPath) as? ShopDetailNameCell
        
        if let shopName = shopEntity?.shopName,
               let genre = shopEntity?.genre?.name,
               let catchCopy = shopEntity?.catchText {
            shopDetailNameCell?.setUp(shopName: shopName, genre: genre, catchCopy: catchCopy, bFavorite: isFavorite, delegate: self)
            }
        
        return shopDetailNameCell ?? UITableViewCell()
    }
    
    // おすすめ情報Cell作成
    private func makeRecommendViewCell(_ indexPath: IndexPath) -> UITableViewCell
    {
        let recommendViewCell = tableView.dequeueReusableCell(withIdentifier: CellName.RecommendViewCell, for: indexPath) as? RecommendViewCell
        
        recommendViewCell?.setUp(freeDrink: (shopEntity?.freeDrink)!, freeFood: shopEntity?.freeDrink ?? "", privateRoom: shopEntity?.privateRoom ?? "", horigotatu: shopEntity?.horigotatsu ?? "", tatami: (shopEntity?.tatami)!)
        
        return recommendViewCell ?? UITableViewCell()
    }
}

extension ShopDetailController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopDetailCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = ShopDetailCellType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell: UITableViewCell
        
        switch type
        {
            case .shopImage:
                cell = makeShopImageCell(indexPath)
            case .shopDetailName:
                cell = makeShopDetailNameCell(indexPath)
            case .recommend:
                cell = makeRecommendViewCell(indexPath)
            default:
                cell = makeShopDetailCell(indexPath, cellType: type)
        }
        
        // セルを選択しても灰色にならないように設定
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ShopDetailController: ShopDetailNameCellDelegate {
    func onTapFavoriteButton(isAdd: Bool) {
        
        guard let shopId = shopEntity?.shopId else { return }
    
        // お気に入りボタンが押されたときの処理
        if isAdd 
        {
            if !UserDefaultsManager.addShopId(shopId) {
                // お気に入りが20件を超えた場合
                DispatchQueue.main.async 
                { [ weak self ] in
                    guard let self else { return }
                    self.present(AlertUtlity.makeFavoriteMaxAlert(), animated: true, completion: nil)
                }
                return
            }
        } else {
            UserDefaultsManager.deleatShopId(shopId)
        }
        updateIsFavorite()
        tableView.reloadData()
    }
}
