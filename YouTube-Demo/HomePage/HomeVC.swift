//
//  HomeVC.swift
//  YouTube-Demo
//
//  Created by Uzair Majeed on 09/06/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    // Create an instance of ItemViewModel
    let itemViewModel = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Fetch data when the view loads
        itemViewModel.fetchData()
        
        // Observe changes to items in ItemViewModel and update collectionView
                itemViewModel.$items
                    .receive(on: RunLoop.main)
                    .sink { [weak self] _ in
                        self?.collectionView.reloadData()
                    }
                    .store(in: &itemViewModel.cancellables)

    }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionCell
            let item = itemViewModel.items[indexPath.row]
            cell.configure(with: item)
        //This creates the shadows and modifies the cards a little bit
               cell.contentView.layer.cornerRadius = 4.0
               cell.contentView.layer.borderWidth = 1.0
               cell.contentView.layer.borderColor = UIColor.clear.cgColor
               cell.contentView.layer.masksToBounds = false
               cell.layer.shadowColor = UIColor.gray.cgColor
               cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
               cell.layer.shadowRadius = 4.0
               cell.layer.shadowOpacity = 1.0
               cell.layer.masksToBounds = false
               cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            return cell
        }
}
