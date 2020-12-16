//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import Foundation
import RxSwift


class MemoryStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "hello", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    
    /// BehaviorSubject 는 최신 요소를 방출하는 특징을 가지고 있다, 구독하자 마자 최신 요소를 방출하기 위한 목적으로 사용
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        store.onNext(list)
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        /// 구독자에게 최신요소 방출
        store.onNext(list)
        /// 업데이트된  요소 방출
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where:  { $0 == memo }){
            list.remove(at: index)
        }
        /// 구독자에게 최신요소 방출
        store.onNext(list)
        /// 삭제 된  요소 방출
        return Observable.just(memo)
    }
    
    
}
