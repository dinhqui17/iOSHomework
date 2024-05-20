//
//  AdsView.swift
//  TPISofware_Homework
//
//  Created by vfa on 18/05/2024.
//

import UIKit
import Combine

class AdsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let viewModel = HomeViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        Bundle.main.loadNibNamed("AdsView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        getBannerData()
        setUpCollectionView()
        setUpPageControl()
        setUpTimer()
    }
    
    private func getBannerData() {
        viewModel.getBanner()
        viewModel.$banners
            .sink { [weak self] banners in
                self?.collectionView.reloadData()
                self?.pageControl.numberOfPages = banners.count
            }
            .store(in: &viewModel.subscriptions)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdsCell", bundle: nil), forCellWithReuseIdentifier: "AdsCell")
    }
    
    private func setUpPageControl() {
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        viewModel.$currentPage
            .sink(receiveValue: { page in
                self.pageControl.currentPage = page
            })
            .store(in: &viewModel.subscriptions)
    }
    
    private func setUpTimer() {
        Timer.publish(every: 3.0, on: .main, in: .common)
               .autoconnect()
               .sink { [weak self] _ in
                   self?.scrollToNextItem()
               }
               .store(in: &viewModel.subscriptions)
    }
    
    func scrollToNextItem() {
        let currentOffset = collectionView.contentOffset
        let nextOffset = CGPoint(x: currentOffset.x + collectionView.bounds.width, y: currentOffset.y)
        
        if nextOffset.x < collectionView.contentSize.width {
            collectionView.setContentOffset(nextOffset, animated: true)
        } else {
            collectionView.setContentOffset(CGPoint.zero, animated: true)
        }
        
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    
}

extension AdsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            viewModel.currentPage = visibleIndexPath.row
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.banners.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCell", for: indexPath) as! AdsCell
        cell.configure(with: viewModel.banners[indexPath.row].linkUrl)
        return cell
    }
    
    
}