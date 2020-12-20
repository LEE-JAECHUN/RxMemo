//
//  MemoComposeViewController.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoComposeViewModel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    
    func bindViewModel() {
        /// 네비게이션 아이템 타이틀
        /// 구독 시, 마지막 상태 값을 방출해야하기 때문에 Driver 사용
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        /// 구독 시, 마지막 상태 값을 방출해야하기 때문에 Driver 사용
        viewModel.inititalText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)
        
        /// 취소버튼: 취소 버튼을 탭하면, 실행할 코드 바인딩
        cancelButton.rx.action = viewModel.cancelAction
        cancelButton.rx.tap
        
        /// 저장버튼: 저장 버튼을ㅇ 탭하면, 실행할 코드 바인딩
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx.disposeBag)
        
    }
    
}
