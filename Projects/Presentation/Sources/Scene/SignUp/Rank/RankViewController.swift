import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class RankViewController: BaseViewController<RankViewModel> {
    private let signupLabel = PMAuthLabelView(
        explainText: "기수를 입력하세요"
    )
    private let rankTextField = PMTextField(
        placeholder: "본인의 기수를 입력해주세요 (ex 10)"
    )
    private let nextButton = PMButton(
        buttonText: "다음",
        isHidden: false
    )

    public override func attribute() {
        super.attribute()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    public override func bind() {
        let input = RankViewModel.Input(
            rankText: rankTextField.rx.text.orEmpty.asObservable(),
            nextButtonTap: nextButton.buttonTap.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.isNextButtonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        output.nextStep
            .drive(onNext: { [weak self] step in
                self?.viewModel.steps.accept(step)
            })
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            signupLabel,
            rankTextField,
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
        rankTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
