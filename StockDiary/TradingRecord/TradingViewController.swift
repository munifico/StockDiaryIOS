//
//  TradingViewController.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/08.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import SnapKit

class TradingViewController: UIViewController, CustomMenuBarDelegate {
   
    var customTabBar: CustomTabBar = {
        let customTabBar = CustomTabBar()
        return customTabBar
    }()
    
    var pageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "PageCell")
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBar()
        setupPageCollectionView()
        
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customTabBar.setFirstTab()
    }

    private func setupCustomTabBar() {
        self.view.addSubview(customTabBar)
        customTabBar.delegate = self
        customTabBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            $0.height.equalTo(55)
        }
    }
    
    private func setupPageCollectionView() {
        self.view.addSubview(pageCollectionView)
        pageCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.customTabBar.snp.bottom)
            $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }

}


extension TradingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! PageCell
        
        cell.label.text = "\(indexPath.row + 1)번째 뷰"
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        customTabBar.indicatorView.snp.remakeConstraints {
//            $0.left.equalTo(self.view.snp.left).offset(scrollView.contentOffset.x / 3)
//        }
//    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        
        customTabBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        customTabBar.collectionView(customTabBar.collectionView, didSelectItemAt: indexPath)
    }
}

extension TradingViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
}

