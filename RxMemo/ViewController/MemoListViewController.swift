//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by JAECHUN LEE on 2020/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo,cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
        
        // Action은 이전 작업이 끝나지 않았을 경우, 다음 작업이 시작되지 않는 것을 보장하고, 오류(Error), 현재 실행상테 등에 관한 Observable를 제공한다.
        // Action은 다음과 같은 것을 할 수 있다.
            /// public let inputs: AnyObserver<Input>:  inputs 프로퍼티를 이용하여 수동으로 새로운 작업을 트리거 가능
            /// public let enabled: Observable<Bool>:  enabled 프로퍼티를 이용하여, 현재 실행중인지 확인가능
            /// 작업(Work)을 수행하고 Observable의 결과를 반환하는 Factory Closure 호출 됨
            /// Work Observable에 의해 발생되는 에러 처리 (Gracefully handles error)
        // typealias CocoaAction = Action<Void, Void>
        addButton.rx.action = viewModel.makeCreateAction()
    }

}
