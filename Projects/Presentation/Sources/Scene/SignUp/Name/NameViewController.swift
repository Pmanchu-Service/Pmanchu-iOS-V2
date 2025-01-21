import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class NameViewController: BaseViewController<NameViewModel> {
    private let signuplabel = PMAuthLabelView(
        explainText: "이름을 입력하세요"
    )
    private let nameTextField = PMTextField(
        placeholder: "이름(본명)을 입력하세요"
    )
    private let nextButton = PMButton(
        buttonText: "다음",
        isHidden: false
    )

    public override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    public override func bind() {
        let input = NameViewModel.Input(
            nameText: nameTextField.rx.text.orEmpty.asObservable(),
            clickNextButton: nextButton.buttonTap.asObservable(),
            nextButton: nextButton
        )
        _ = viewModel.transform(input: input)
    }

    public override func addView() {
        [
            signuplabel,
            nameTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        signuplabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(224)
            $0.height.equalTo(73)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(signuplabel.snp.bottom).offset(181)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
