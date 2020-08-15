//
//  TransitionModel.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
