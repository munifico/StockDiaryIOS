//
//  CommonViewModel.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/15.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let title: Driver<String>  //navigation title , driver는 observable과 같지만 mainScheduler에서 사용함(-> UI 관련은 driver)
    let sceneCoordinator: SceneCoordinatorType
    let storage: BuyRecordStorageType
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: BuyRecordStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
