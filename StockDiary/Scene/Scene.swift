//
//  Scene.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

//앱에서 구현할 scene을 열거형으로 선언
enum Scene {
    case list(BuyRecordViewModel)
    case detail(BuyDetailViewModel)
    case compose(BuyComposeViewModel)
}

extension Scene {
    //Scene을 생성하고 viewmodel을 바인딩 해서 리턴
    func instantiate(from storyboard: String = "Main") -> UIViewController{
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "BuyRecordNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var buyRecordVC = nav.viewControllers.first as? BuyRecordViewController else {
                fatalError()
            }
            
            buyRecordVC.bind(viewModel: viewModel)
            
            //여기서 navigationController를 리턴해야한다고 한다. 왜냐면 navigationController를 embed한 viewController니까
            return nav
            
        case .detail(let viewModel):
            guard var buyDetailVC = storyboard.instantiateViewController(withIdentifier: "BuyDetailViewController") as? BuyDetailController else {
                fatalError()
            }
            
            buyDetailVC.bind(viewModel: viewModel)
            
            //얘는 navigation stack에 푸시되기 때문에 navigationController를 고려할 필요가 없다.
            return buyDetailVC
            
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "BuyComposeNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var buyComposeVC = nav.viewControllers.first as? BuyComposeController else {
                fatalError()
            }
            
            buyComposeVC.bind(viewModel: viewModel)
            
            return nav
        }
    }
}
