//
//  BottomBarView.swift
//  TPISofware_Homework
//
//  Created by vfa on 19/05/2024.
//

import UIKit
import Combine

class BottomBarView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = BottomBarViewModel()
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        Bundle.main.loadNibNamed("BottomBarView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "BottomBarCell", bundle: nil), forCellWithReuseIdentifier: "BottomBarCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: false)
    }

}

extension BottomBarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItems = viewModel.bottomBarItems.count
        return CGSize(width: collectionView.frame.width / CGFloat(numberOfItems), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bottomBarItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomBarCell", for: indexPath) as! BottomBarCell
        cell.configure(with: viewModel.bottomBarItems[indexPath.row])
        return cell
    }
    
    
}
