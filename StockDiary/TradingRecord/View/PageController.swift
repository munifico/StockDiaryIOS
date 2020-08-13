//
//  PageController.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/10.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import SnapKit

protocol PageControllerDelegate: class {
    func changePage(changeTo index: Int)
}

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    weak var dele: PageControllerDelegate?
    
    var pendingPage: Int?
    let identifiers: NSArray = ["SellController", "BuyController", "TotalController"]
    var currentPageIndex: Int = 1
    
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "SellController"),
                self.VCInstance(name: "BuyController"),
                self.VCInstance(name: "TotalController")]
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Trading", bundle: nil).instantiateViewController(identifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension PageController {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return nil
        } else {
            return VCArray[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex >= VCArray.count {
            return nil
        } else {
            return VCArray[nextIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let currentVC = pageViewController.viewControllers![0]
        
        if currentVC is SellController {
            dele?.changePage(changeTo: 0)
        } else if currentVC is BuyController {
            dele?.changePage(changeTo: 1)
        } else if currentVC is TotalController {
            dele?.changePage(changeTo: 2)
        }
    }
    
    func toForward(changeTo index: Int) {
        if index > currentPageIndex {
            setViewControllers([VCArray[index]], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([VCArray[index]], direction: .reverse, animated: true, completion: nil)
        }
        
        currentPageIndex = index
    }
    
}
