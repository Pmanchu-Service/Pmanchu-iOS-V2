import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class NameViewController: BaseViewController<NameViewModel> {
    private let label = PMAuthLabelView(
        explainText: "이름을 입력하세요"
    )
    private let nameTextField = PMTextField()
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
            clickNextButton: nextButton.buttonTap.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.isNextButtonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        nextButton.buttonTap
            .map { PMStep.rankIsRequired }
            .bind(to: viewModel.steps)
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            label,
            nameTextField,
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
        nameTextField.snp.makeConstraints {
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
