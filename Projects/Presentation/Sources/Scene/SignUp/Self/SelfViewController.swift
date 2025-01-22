import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SelfViewController: BaseViewController<SelfViewModel> {
    private let signupLabel = PMAuthLabelView(
        explainText: "자기소개를 입력하세요"
    )
    private let selfTextField = PMTextField(
        placeholder: "한 줄로 자기소개를 해주세요"
    )
    private let detailTextField = DetailTextView(
        placeholder: "구체적으로 자기소개를 해주세요"
    )
    private let nextButton = PMButton(
        buttonText: "다음",
        isEnabled: false,
        isHidden: false
    )

    public override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    public override func bind() {
        let input = SelfViewModel.Input(
            selfText: selfTextField.rx.text.orEmpty.asObservable(),
            detailText: detailTextField.rx.text.orEmpty.asObservable(),
            clickNextButton: nextButton.buttonTap.asObservable(),
            nextButton: nextButton
        )
        let output = viewModel.transform(input: input)
        output.isButtonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            signupLabel,
            selfTextField,
            detailTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(224)
            $0.height.equalTo(73)
        }
        selfTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
        detailTextField.snp.makeConstraints {
            $0.top.equalTo(selfTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(183)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
