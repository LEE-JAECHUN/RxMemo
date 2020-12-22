//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoListViewModel: CommonViewModel {
    
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map { _ in}
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }
    
    // 참고: public typealias CocoaAction = Action<Void, Void>
        /// public final class Action<Input, Element>
        /// public typealias WorkFactory = (Input) -> Observable<Element>
    func makeCreateAction () -> CocoaAction {
        // 참고: Action 생성자 정의, Action<Void, Void>(enabledIf: , workFactory: )
        // Trailing Closure로 수행할 작업 (workFactory) 정의
        return CocoaAction { _ in
            /// 1. 빈 메모생성 :  createMemo에서 새로 생성된 메모 방출
            /// 2. MemoComposeViewModel 생성 및 화면전환
            ///     * VM를 생성하면서, 두 가지 액션 (saveAction, cancelAction) 주입
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    let memoComposeViewModel = MemoComposeViewModel(title: "새 메모",
                                                                    sceneCoordinator: self.sceneCoordinator,
                                                                    storage: self.storage,
                                                                    saveAction: self.performUpdate(memo: memo),
                                                                    cancelAction: self.performCancel(memo: memo))
                    let composeScene = Scene.compose(memoComposeViewModel)
                    // transition메소드는 Completable이 반환하므로, 반환타입에 맞게 observable 반환
                    return self.sceneCoordinator.transition(to: composeScene, style: .modal, animated: true)
                        .asObservable()
                        .map { _ in }
                }
        }
    }
}
