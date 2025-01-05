import UIKit

import RxSwift
import RxCocoa

import Core
import DesignSystem

open class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
    public let disposeBag = DisposeBag()
    public var viewModel: ViewModel
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        bind()
        configureNavigationBar()
        self.navigationItem.hidesBackButton = true
    }

    open func attribute() {
        
        view.backgroundColor = .systemBackground

    }
    open func configureNavigationBar() {
        // 네비게이션바 관련 코드를 설정하는 함수
    }
    open func configureNavgationBarLayOutSubviews() {
        // viewDidLayoutSubviews에서 네비게이션바 관련 코드를 호출하는 함수
    }
    open func bindAction() {
        // Rx 액션을 설정하는 함수
    }
    open func bind() {
        // UI 바인딩을 설정하는 함수
    }
    open func addView() {
        // 서브뷰를 구성하는 함수
    }
    open func setLayout() {
        // 레이아웃을 설정하는 함수
    }
    open func setLayoutData() {
        // 뷰 관련 데이터를 호출하는데 사용하는 함수
    }
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addView()
        setLayout()
    }
}
