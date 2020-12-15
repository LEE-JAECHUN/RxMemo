//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
