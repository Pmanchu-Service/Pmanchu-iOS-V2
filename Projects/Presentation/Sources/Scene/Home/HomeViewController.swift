import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import Domain
import DesignSystem

public class HomeViewController: BaseViewController<HomeViewModel> {
    private lazy var navigationBar = PMMainNavigationBar(view: self)

    public override func addView() {
        [
            navigationBar
        ].forEach {
            view.addSubview($0)
            $0.isUserInteractionEnabled = true
        }
    }

    public override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }

    public override func bind() {
        super.bind()

        navigationBar.bellButtonTapped
            .bind(to: viewModel.bellButtonTapped)
            .disposed(by: disposeBag)
    }
}
