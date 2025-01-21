import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SkillViewController: BaseViewController<SkillViewModel> {
    private let signupLabel = PMAuthLabelView(
        explainText: "기술스택을 입력하세요"
    )
    private let skillTextField = PMTextField(
        placeholder: "기술 스택을 입력하세요"
    )
    private let addButton = SkillAddButton()
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
        let input = SkillViewModel.Input(
            skillText: skillTextField.rx.text.orEmpty.asObservable(),
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
            skillTextField,
            addButton,
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
        skillTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(71)
            $0.height.equalTo(45)
        }
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(skillTextField.snp.centerY)
            $0.leading.equalTo(skillTextField.snp.trailing).offset(7)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
