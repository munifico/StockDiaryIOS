//
//  ViewPagerCell.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/08.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import SnapKit

class CustomTabBarCell: UICollectionViewCell {
    var pageName: UILabel = {
        let pageName = UILabel()
        pageName.text = "Tab1"
        pageName.textColor = .gray
        pageName.textAlignment = .center
        return pageName
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(pageName)
        
        pageName.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
    }
}
