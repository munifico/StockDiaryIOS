//
//  BuyComposeViewModel.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/15.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

class BuyComposeViewModel : CommonViewModel{
    private let stockName: String?
    
    var initialText: Driver<String?> {
        return Observable.just(stockName).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, stockName: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: BuyRecordStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil) {
        
        self.stockName = stockName
        self.saveAction = Action<String, Void> { input in
            //action이 전달되었다면 action을 수행하고 화면을 닫지만, 그렇지 않다면 화면만 닫음
            if let action = saveAction {
                action.execute(input)
            }
            
            return sceneCoordinator.close(animated: true).asObservable().map{_ in}
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute()
            }
            
            return sceneCoordinator.close(animated: true).asObservable().map{_ in}
        }
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
