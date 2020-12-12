//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import UIKit

protocol ViewModelBindableType {
    // ViewModel이 무엇인지 구체적으로 모르기 때문에 Generic으로 선언
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set}
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        // Loads the view controller’s view if it has not yet been loaded.
        loadViewIfNeeded()
        bindViewModel()
    }
    
}
