//
//  BuyRecord.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/15.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation

//equatable - 값이 동일한지 어떤지를 비교할 수 있는 타입 (==, != 을 쓰기 위해서는 이 포로토콜을 채택해야해)
struct BuyRecord: Equatable {
    var stockName: String
    var date: Date
    var identity: String
    
    init(stockName: String, date: Date = Date()) {
        self.stockName = stockName
        self.date = date
        self.identity = "\(Date().timeIntervalSinceReferenceDate)"
    }
    
    init(original: BuyRecord, updatedContent: String) {
        self = original
        self.stockName = updatedContent
    }
}
