//
//  BuyRecordViewModel.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import RxCocoa
import RxSwift
import RxFlow
import Action

//화면 전환 & 메모 저장 처리
class BuyRecordViewModel: CommonViewModel {
    //의존성을 주입하는 생성자
    //바인딩에 사용되는 속성과 메서드
    //*뷰모델을 생성하는 시점에 생성자를 통해서 의존성을 주입해야한다.
    var buyRecords: Observable<[BuyRecord]> {
        return storage.buyRecords()
    }
    
    func performUpdate(buyRecord: BuyRecord) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(buyRecord: buyRecord, stockName: input).map { _ in }
        }
    }
    
    func performCancel(buyRecord: BuyRecord) -> CocoaAction {
        return Action {
            return self.storage.delete(buyRecord: buyRecord).map { _ in }
        }
    }
    

    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createBuyRecord(stockName: "")
                .flatMap { buyRecord -> Observable<Void> in
                    let composeViewModel = BuyComposeViewModel(title: "새 매수 기록", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(buyRecord: buyRecord), cancelAction: self.performCancel(buyRecord: buyRecord))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    return self.sceneCoordinator.transition(storyboard: "BuyCompose", to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
                    
            }
            
        }
    }
  
}
