import UIKit

class SearchResultController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let items = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"]
    var searchResult = [String]()
    
    let sortOptions = ["店名かな順", "ジャンルコード順", "小エリアコード順", "おススメ順"]
    
    var selectedSortOptionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ナビゲーションバーのタイトルを設定
        self.title = "検索結果一覧画面"
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(onTapSortButton))
        self.navigationItem.rightBarButtonItem = sortButton
        
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "searchResultCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")
        
        searchResult = items  // 初期値として全件を表示するために items を設定
    }

    // 初期化メソッドでxibをロード
    init() {
        super.init(nibName: "SearchResultController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func onTapSortButton() {
        let alert: UIAlertController = UIAlertController(title: "並び順", message: "赤文字が現在指定している並び順", preferredStyle:  UIAlertController.Style.actionSheet)
        
        for (index, option) in sortOptions.enumerated() {
            let style: UIAlertAction.Style = index == selectedSortOptionIndex ? .destructive : .default
            let action = UIAlertAction(title: option, style: style) { [weak self] action in
                guard let self = self else { return }
                self.selectedSortOptionIndex = index  // 選択されたオプションを更新
                self.applySort()  // ソート処理を呼び出し
            }
            alert.addAction(action)
        }
        
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func applySort() {
        // ここで選択されたオプションに基づいて searchResult をソートする
        switch selectedSortOptionIndex {
        case 0:
            searchResult.sort()  // 例: 店名かな順
        case 1:
            // 他のソート条件を追加
            break
        case 2:
            // 他のソート条件を追加
            break
        case 3:
            // 他のソート条件を追加
            break
        default:
            break
        }
        
        tableView.reloadData()  // ソートされた結果をリロード
    }
}

extension SearchResultController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // searchResult の数を返す
        return searchResult.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // searchResult のデータを使用
        cell.textLabel?.text = searchResult[indexPath.row]
        return cell
    }
}

extension SearchResultController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchResult.removeAll()

        if searchBar.text == "" {
            searchResult = items  // テキストが空の場合、すべてのアイテムを表示
        } else {
            for data in items {
                if data.contains(searchBar.text!) {
                    searchResult.append(data)
                }
            }
        }
        tableView.reloadData()
    }
}
