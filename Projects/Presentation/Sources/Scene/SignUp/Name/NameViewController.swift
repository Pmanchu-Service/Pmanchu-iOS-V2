import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DesignSystem

public class NameViewController: BaseViewController<NameViewModel> {
    private let nameTextField = PMTextField()
    private let nextButton = PMButton(
        buttonText: "다음",
        isHidden: false
    )

    public override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
    }
    public override func addView() {
        [
            nameTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        addView()
        setLayout()
    }

    public override func setLayout() {
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(373)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(40)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
