//
//  SceneCoordinatorType.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import RxSwift

//SceneCoordinator가 공통적으로 구현해야하는 부분을 선언
protocol SceneCoordinatorType{
    
    //새로운 scene 표현
    @discardableResult
    func transition(storyboard: String, to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable

    //현재 scene을 닫고 이전 scene으로 돌아간다
    @discardableResult
    func close(animated: Bool) -> Completable
    
}
