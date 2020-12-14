//
//  TransitionModel.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/15.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
