import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SkillViewController: BaseViewController<SkillViewModel> {
    private let label = PMAuthLabelView(
        explainText: "기술스택을 입력하세요"
    )
    private let skillTextField = PMTextField()
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
            label,
            skillTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    public override func setLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(224)
            $0.height.equalTo(73)
        }
        skillTextField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
