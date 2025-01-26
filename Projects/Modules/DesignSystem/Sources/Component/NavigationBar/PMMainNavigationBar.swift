import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core

public class PMMainNavigationBar: BaseView {
    private let presentViewController: UIViewController
    public let bellButtonTapped = PublishRelay<Void>()
    private let pmLogoImageView = UIImageView(image: .logo).then {
        $0.contentMode = .scaleAspectFit
    }
    private let bellButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.tintColor = .black
    }
    private lazy var rightItemStackView = UIStackView(arrangedSubviews: [
        bellButton
    ]).then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
    }

    public init(view: UIViewController) {
        self.presentViewController = view
        super.init(frame: .zero)
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBindings() {
        bellButton.rx.tap
            .bind(to: bellButtonTapped)
            .disposed(by: disposeBag)
    }

    public override func layout() {
        [pmLogoImageView, rightItemStackView].forEach { self.addSubview($0) }
        pmLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(95)
            $0.height.equalTo(38)
        }

        rightItemStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        bellButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
    }
}
