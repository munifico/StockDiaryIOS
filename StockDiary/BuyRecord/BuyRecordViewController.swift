//
//  BuyViewController.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Action

class BuyRecordViewController: UIViewController, ViewModelBindableType {
    
    //rx를 활용하려면 outlet으로 가져옴
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    var viewModel: BuyRecordViewModel!

    @IBOutlet weak var buyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyTableView.register(UINib.init(nibName: "BuyTableViewCell", bundle: nil), forCellReuseIdentifier: "BuyTableViewCell")
        
    }
    
    
    
    func bindViewModel() {
        
        
        
        //viewmodel이 nil에러가 뜬다. 즉, viewModel 인스턴스 생성이 안 된 것이다.
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.buyRecords
            .bind(to: buyTableView.rx.items(cellIdentifier: "BuyTableViewCell", cellType: BuyTableViewCell.self)) {
                row, buyRecord, cell in
                cell.stockName.text = buyRecord.stockName
            }
            .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        
    }
}


