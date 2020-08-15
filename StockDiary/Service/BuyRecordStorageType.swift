//
//  File.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/15.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import RxSwift

protocol BuyRecordStorageType {
    @discardableResult
    func createBuyRecord(stockName: String) -> Observable<BuyRecord>
    
    @discardableResult
    func buyRecords() -> Observable<[BuyRecord]>
    
    @discardableResult
    func update(buyRecord: BuyRecord, stockName: String) -> Observable<BuyRecord>
    
    @discardableResult
    func delete(buyRecord: BuyRecord) -> Observable<BuyRecord>
    
}
