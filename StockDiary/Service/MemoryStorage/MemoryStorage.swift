//
//  MemoryStorage.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/15.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import RxSwift

class MemoryStorage: BuyRecordStorageType {
    private var list = [
        BuyRecord(stockName: "삼성전자", date: Date().addingTimeInterval(-10)),
        BuyRecord(stockName: "씨젠", date: Date().addingTimeInterval(-20))
    ]
    
    //기본값을 list로 선언하기 위해서 lazy로 선언했다는데... 뭔 소리지? => 사용될때 최신화된 list를 쓴다는 느낌같다.
    private lazy var store = BehaviorSubject<[BuyRecord]>(value: list)
    
    
    @discardableResult
    func createBuyRecord(stockName: String) -> Observable<BuyRecord> {
        let buyRecord = BuyRecord(stockName: stockName)
        list.insert(buyRecord, at:0)
        store.onNext(list)
        
        return Observable.just(buyRecord)
    }
    
    @discardableResult
    func buyRecords() -> Observable<[BuyRecord]> {
        return store
    }
    
    @discardableResult
    func update(buyRecord: BuyRecord, stockName: String) -> Observable<BuyRecord> {
        let updated = BuyRecord(original: buyRecord, updatedContent: stockName)
        
        if let index = list.firstIndex(where: {$0 == buyRecord}) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(buyRecord: BuyRecord) -> Observable<BuyRecord> {
        if let index = list.firstIndex(where: {$0 == buyRecord}) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        //이렇게 계속 방출해줘야 reload가 될꺼라네?
        return Observable.just(buyRecord)
    }
    
    
}
