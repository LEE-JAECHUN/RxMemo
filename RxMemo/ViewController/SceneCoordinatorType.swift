//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/15.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
