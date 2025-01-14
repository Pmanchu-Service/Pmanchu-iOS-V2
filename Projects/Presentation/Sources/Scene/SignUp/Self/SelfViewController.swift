import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SelfViewController: BaseViewController<SelfViewModel> {
    private let label = PMAuthLabelView(
        explainText: "자기소개를 입력하세요"
    )
    private let selfTextField = PMTextField()
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
        let input = SelfViewModel.Input(
            selfText: selfTextField.rx.text.orEmpty.asObservable(),
            clickNextButton: nextButton.buttonTap.asObservable(),
            nextButton: nextButton
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
            label,
            selfTextField,
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
        selfTextField.snp.makeConstraints {
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
