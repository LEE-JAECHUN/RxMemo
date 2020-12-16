//
//  MemoComposeViewModel.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: CommonViewModel {
    private let content:String?
    var inititalText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, content:String?, sceneCoorinator: SceneCoordinator, storage: MemoryStorage, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil){
        self.content = content
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoorinator.close(animated: true).asObservable().map { _ in }
        }
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoorinator.close(animated: true).asObservable().map { _ in }
        }
        super.init(title: title, sceneCoordinator: sceneCoorinator, storage: storage)
    }
}

