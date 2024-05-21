//
//  FavoriteView.swift
//  TPISofware_Homework
//
//  Created by vfa on 18/05/2024.
//

import UIKit
import Combine

class FavoriteView: UIView {
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var disposeBag = Set<AnyCancellable>()
    
    weak var viewModel: FavoriteViewModel! {
        didSet {
            if let viewModel = viewModel {
                bindingViewModel(viewModel: viewModel)
            } else {
                disposeBag.removeAll()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        Bundle.main.loadNibNamed("FavoriteView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpCollectionView()
    }
    
    func bindingViewModel(viewModel: FavoriteViewModel) {
        viewModel.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.noDataView.isHidden = !result.isEmpty
                self?.collectionView.reloadData()
            }
            .store(in: &disposeBag)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FavoriteButtonCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteButtonCell")
    }
}

extension FavoriteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteButtonCell", for: indexPath) as! FavoriteButtonCell
        cell.configure(with: viewModel.favorites[indexPath.row])
        return cell
    }
    
    
}
