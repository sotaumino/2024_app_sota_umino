//
//  FavoriteCollectionViewController.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/08/29.
//

import UIKit

class FavoriteCollectionViewController: UIViewController {
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    private var shopEntities = [GourmetSearchShopEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "お気に入り画面0件"
        setupFavoriteCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = favoriteCollectionView.indexPathsForSelectedItems?.first{
            favoriteCollectionView.deselectItem(at: indexPath , animated: true)
        }
        fetchList(shopIds: UserDefaultsManager.favoriteShopIds())
    }
    
    func setupFavoriteCollectionView(){
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(UINib(nibName: CellName.FavoriteViewCell, bundle: nil),forCellWithReuseIdentifier: CellName.FavoriteViewCell)
        
        collectionViewFlowLayout.minimumLineSpacing = 4
        collectionViewFlowLayout.minimumInteritemSpacing = 4
    }
    
    func fetchList(shopIds: [String]){
        guard !shopIds.isEmpty else { return updateData(entities: [])}
        
        let maxShopIds = shopIds.prefix(20).map { $0 }
        GourmetSearchFetcher().fetchForShopIds(maxShopIds) { [ weak self ] entities in
            guard let self else { return }
            DispatchQueue.main.async{
                self.updateData(entities: entities)
            }
        } failer: { [ weak self ] in
            guard self != nil else { return }
        }

    }
    
    func updateData(entities: [GourmetSearchShopEntity]){
        shopEntities = entities
        navigationItem.title = "お気に入り画面\(entities.count)件"
        favoriteCollectionView.reloadData()
    }
}

extension FavoriteCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard shopEntities.count > indexPath.row else { return }
        
        let shopDetail = ShopDetailController()
        shopDetail.setup(shopEntity: shopEntities[indexPath.row])
        
        
    }
}

extension FavoriteCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopEntities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellName.FavoriteViewCell, for: indexPath) as? FavoriteViewCell,
              shopEntities.count > indexPath.row else {
            return UICollectionViewCell()
        }
        
        cell.setup(entity: shopEntities[indexPath.row])
        return cell
    }
}

extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let prototypeCell = UINib(nibName: CellName.FavoriteViewCell, bundle: nil).instantiate(withOwner: nil, options: nil).first as? FavoriteViewCell else { return .zero }
        
        return prototypeCell.systemLayoutSizeFitting(CGSize(width: view.bounds.width / 3 - 8, height: 0), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
    }
}
