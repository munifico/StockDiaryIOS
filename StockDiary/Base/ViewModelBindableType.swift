//
//  ViewModelBindable.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType       //이게 제너릭이라는데?
    
    var viewModel: ViewModelType! {get set}
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    //vc 추가된 vm 속성에 실제의 vm을 저장하고
    //bindViewModel을 호출하는 메서드를 자동으로 호출
    //-> 개별 viewModel에서 bindViewModel 메서드를 호출할 필요가 없기 때문에 코드가 단순해짐
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
