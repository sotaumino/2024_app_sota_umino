import UIKit

class SearchResultController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var shopEntities = [GourmetSearchShopEntity]()
    
    let sortOptions = ["店名かな順", "ジャンルコード順", "小エリアコード順", "おススメ順"]
    
    var selectedSortOptionIndex: Int = 3

    var loadingOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityIndicator()
        setupLoadingOverlay()
        
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    // 初期化メソッドでxibをロード
    init() {
        super.init(nibName: "SearchResultController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupActivityIndicator()
    {
        // インジケーターの表示・非表示を自動で切り替え
        activityIndicator.hidesWhenStopped = true
        // インジケータを中央に配置
        activityIndicator.center = view.center
        
        activityIndicator.stopAnimating()
    }
    
    func setupLoadingOverlay()
    {
        loadingOverlay = UIView()
        loadingOverlay.backgroundColor = UIColor(white: 0, alpha: 0.5)
        // AutoLayoutの制約を適応しないように設定
        loadingOverlay.translatesAutoresizingMaskIntoConstraints = false
        loadingOverlay.isHidden = true
        
        loadingOverlay.addSubview(activityIndicator)
        view.addSubview(loadingOverlay)
        
        // オーバーレイビューの制約を設定（tableView全体を覆う）
        NSLayoutConstraint.activate([
            loadingOverlay.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            loadingOverlay.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            loadingOverlay.topAnchor.constraint(equalTo: tableView.topAnchor),
            loadingOverlay.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
    }
    
    // インジケーター開始
    func startIndicator()
    {
        DispatchQueue.main.async {
            // オーバーレイビューを表示
            self.loadingOverlay.isHidden = false
            // インジケーターを開始
            self.activityIndicator.startAnimating()
            // 検索バーを無効化
            self.searchBar.isUserInteractionEnabled = false
        }
    }
    
    // インジケーター終了
    func stopIndicator()
    {
        DispatchQueue.main.async {
            // インジケーターを終了
            self.activityIndicator.stopAnimating()
            // オーバーレイビューを非表示
            self.loadingOverlay.isHidden = true
            // サーチバーを有効化
            self.searchBar.isUserInteractionEnabled = true
        }
    }
    
    func fetchList(searchText: String){
        guard !searchText.isEmpty else { return }
        
        shopEntities = []
        tableView.reloadData()
        
        // インジゲーターを表示
        startIndicator()
        
        let selectedSortIndex = selectedSortOptionIndex
        
        GourmetSearchFetcher().fetchForShopName(searchText, selectedSortIndex: selectedSortIndex) { [weak self] entities in
            guard let self else { return }
            DispatchQueue.main.async {
                // インジケーターを非表示
                self.stopIndicator()
                
                if entities.isEmpty
                {
                    let noResultsAlert = AlertUtlity.makeFetchNoResultsAlert()
                    self.present(noResultsAlert, animated: true, completion: nil)
                }
                else
                {
                    self.shopEntities = entities
                    self.tableView.reloadData()
                }
            }
        } failure: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                // インジケータを非表示
                self.stopIndicator()

                let alert = AlertUtlity.makeFetchErrorAlert {
                    self.fetchList(searchText: searchText)
                }
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
