//
//  SceneCoordinator.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/15.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
    
    private let bag = DisposeBag()
    private var window:UIWindows
    private var currentVC:UIViewController
    
    required init(windows: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target
            windows.rootViewController = target
            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.pushViewController(target, animated: true)
            currentVC = target
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: true){
                subject.onCompleted()
            }
            currentVC = target
        }
        return subject.ignoreElements()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: true){
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            }else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: true) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            }else {
                completable(.error(TransitionError.unknown))
            }
            return Disposables.create()
        }
    }
    
}
