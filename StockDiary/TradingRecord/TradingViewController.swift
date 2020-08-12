//
//  TradingViewController.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/08.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import SnapKit

class TradingViewController: UIViewController, CustomMenuBarDelegate, PageControllerDelegate {

    @IBOutlet weak var containerView: UIView!
    
    let pageController = PageController(coder: NSCoder())!
    
    var customTabBar: CustomTabBar = {
        let customTabBar = CustomTabBar()
        return customTabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBar()
        
        //containerView에 추가
        addChild(pageController)
        self.containerView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        pageController.dele = self
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0).isActive = true
        pageController.view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        pageController.view.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        pageController.view.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
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

    func customMenuBar(scrollTo index: Int) {
        self.pageController.toForward(changeTo: index)
    }
    
    func changePage(changeTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        customTabBar.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        customTabBar.collectionView(customTabBar.collectionView, didSelectItemAt: indexPath)
    }

}



