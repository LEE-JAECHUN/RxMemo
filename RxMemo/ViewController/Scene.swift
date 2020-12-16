//
//  Scene.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/15.
//

import UIKit

/// Scene (화면) 열거형
enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

/// Scene (화면) 열거형 확장,  객체생성 메소드 추가
/// 참고: Swift는 열거형/구조체/클래스 모두 메소드 추가 가능
extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        switch self {
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            listVC.bind(viewModel: viewModel)
            return nav
        case .detail(let viewModel):
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                fatalError()
            }
            detailVC.bind(viewModel: viewModel)
            return detailVC
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                fatalError()
            }
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
