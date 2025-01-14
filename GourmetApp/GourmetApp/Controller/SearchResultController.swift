import UIKit

class SearchResultController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shopEntities = [GourmetSearchShopEntity]()
    
    let sortOptions = ["店名かな順", "ジャンルコード順", "小エリアコード順", "おススメ順"]
    
    var selectedSortOptionIndex: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backButtonTitle = "Back"
        
        // ナビゲーションバーのタイトルを設定
        self.title = "検索結果一覧画面"
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(onTapSortButton))
        self.navigationItem.rightBarButtonItem = sortButton
        
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellName.ListCell, bundle: nil), forCellReuseIdentifier: CellName.ListCell)
        
    }

    // 初期化メソッドでxibをロード
    init() {
        super.init(nibName: "SearchResultController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fetchList(searchText: String){
        guard !searchText.isEmpty else { return }
        
        shopEntities = []
        tableView.reloadData()
        
        let selectedSortIndex = selectedSortOptionIndex
        
        GourmetSearchFetcher().fetchForShopName(searchText, selectedSortIndex: selectedSortIndex) { [weak self] entities in
            guard let self else { return }
            DispatchQueue.main.async {
                print("取得したデータ: \(entities)")
                self.shopEntities = entities
                self.tableView.reloadData()
            }
        } failure: { [weak self] in
            guard let self else { return }
            let alert = AlertUtlity.makeFetchErrorAlert
            {
                self.fetchList(searchText: searchText)
            }
            
            DispatchQueue.main.async
            {
                self.present(alert, animated: true, completion: nil)
            }
        }
            
    }
    
    @objc func onTapSortButton() {
        let alert: UIAlertController = UIAlertController(title: "並び順", message: "赤文字が現在指定している並び順", preferredStyle:  UIAlertController.Style.actionSheet)
        
        for (index, option) in sortOptions.enumerated() {
            let style: UIAlertAction.Style = index == selectedSortOptionIndex ? .destructive : .default
            let action = UIAlertAction(title: option, style: style) { [weak self] action in
                guard let self = self else { return }
                self.selectedSortOptionIndex = index  // 選択されたオプションを更新
                
                guard let searchText = self.searchBar.text, !searchText.isEmpty else { return }
                self.fetchList(searchText: searchText)
            }
            alert.addAction(action)
        }
        
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}

extension SearchResultController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // shopEntities の数を返す
        return shopEntities.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.ListCell, for: indexPath) as? ListCell, shopEntities.count > indexPath.row else{
            return UITableViewCell()
        }
        
        cell.setup(entity: shopEntities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopDetailController = ShopDetailController()
        
        shopDetailController.shopEntity = shopEntities[indexPath.row]
        // TabBarを非表示に設定
        shopDetailController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(shopDetailController, animated: true)
    }
}

extension SearchResultController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)

        guard let searchText = searchBar.text else { return }
        
        fetchList(searchText: searchText)
    }
}
