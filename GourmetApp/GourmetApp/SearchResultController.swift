//
//  SearchResultController.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/08/29.
//

import UIKit

class SearchResultController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let items = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    // 初期化メソッドでxibをロード
    init() {
        super.init(nibName: "SearchResultController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SearchResultController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

}
