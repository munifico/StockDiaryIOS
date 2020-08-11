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
    let identifiers: NSArray = ["AllVC", "DailyVC", "SupportVC"]
    
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "AllVC"),
                self.VCInstance(name: "DailyVC"),
                self.VCInstance(name: "SupportVC")]
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
        dele?.changePage(changeTo: viewControllerIndex)
        
        if previousIndex < 0 {
            return nil
        } else {
            return VCArray[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        
        
        let nextIndex = viewControllerIndex + 1
        dele?.changePage(changeTo: viewControllerIndex)
        
        if nextIndex >= VCArray.count {
            return nil
        } else {
            return VCArray[nextIndex]
        }
    }
    
    func toForward(changeTo index: Int) {
        setViewControllers(VCArray, direction: .forward, animated: true, completion: nil)
    }
    
    func toReverse(changeTo index: Int) {
        setViewControllers(VCArray, direction: .reverse, animated: true, completion: nil)
    }
}
