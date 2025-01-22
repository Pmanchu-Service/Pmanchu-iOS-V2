import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class EmailViewController: BaseViewController<EmailViewModel> {
    private let label = PMAuthLabelView(
        explainText: "이메일을 입력하세요"
    )
    private let emailTextField = PMTextField(
        placeholder: "이메일을 입력해주세요"
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
        let input = EmailViewModel.Input(
            emailText: emailTextField.rx.text.orEmpty.asObservable(),
            clickNextButton: nextButton.buttonTap.asObservable(),
            nextButton: nextButton
        )
        _ = viewModel.transform(input: input)
    }
    public override func addView() {
        [
            label,
            emailTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    public override func setLayout() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(224)
            $0.height.equalTo(73)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
