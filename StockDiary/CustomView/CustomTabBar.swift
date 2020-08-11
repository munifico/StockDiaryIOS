//
//  CustomTabBar.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/08.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import SnapKit

protocol CustomMenuBarDelegate: class {
    func customMenuBar(scrollTo index: Int)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomMenuBarDelegate?
    
    var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomTabBarCell.self, forCellWithReuseIdentifier: "CustomTabBarCell")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupTabBar()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupTabBar() {
        
        setupCollectionView()
        setupIndicator()
        
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(55)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupIndicator() {
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.bottom.equalTo(self.collectionView.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.height.equalTo(3)
            $0.width.equalTo(UIScreen.main.bounds.size.width/3)
        }
    }
    
    public func setFirstTab() {
        
        //첫번째 cell 선택
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        //얘를 해줘야 이후 deSelect가 적용된다.
        self.collectionView(self.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
    }
    
}


extension CustomTabBar : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabBarCell", for: indexPath) as? CustomTabBarCell
            else {
            return UICollectionViewCell()
        }
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomTabBarCell else {
            return
        }
        cell.pageName.textColor = .black
        indicatorView.snp.updateConstraints {
            $0.left.equalTo(self.snp.left).offset(Int(self.frame.width)/3 * indexPath.row)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        
        //메뉴바 클릭시 이벤트
        delegate?.customMenuBar(scrollTo: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomTabBarCell else {
            return
        }
        cell.pageName.textColor = .gray
    }
    
    
}

extension CustomTabBar : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 3 , height: 55)
    }
}
