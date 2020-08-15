//
//  SceneCoordinator.swift
//  StockDiary
//
//  Created by 김상진 on 2020/08/14.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag()
    
    //화면전환을 위해서 window 인스턴스와 현재 화면에 표시된 scene을 가지고 있어야한다.
    private var window: UIWindow
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    
    @discardableResult
    func transition(storyboard: String, to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        //전환 결과흫 방출할 subject
        let subject = PublishSubject<Void>()
        
        let target = scene.instantiate(from: storyboard)
        
        switch style {
        case .root:
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            //navigation이 embed되어 있지 않은 경우 error 반환
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.pushViewController(target, animated: animated)
            currentVC = target
            
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
        }
        
        return subject.ignoreElements()  //subject를 completable로 바꿔주는 메서드
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            //현재 view가 modal 방식이라면 dismiss
            if let presetingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presetingVC
                    completable(.completed)
                }
            }   //nav방식이면 pop
            else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
    }
    
    
}
