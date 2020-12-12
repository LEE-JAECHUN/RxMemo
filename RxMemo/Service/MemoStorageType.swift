//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func MemoList() -> Observable<[Memo]>.Element
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
