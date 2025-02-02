import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class MajorViewController: BaseViewController<MajorViewModel> {
    private let label = PMAuthLabelView(
        explainText: "전공을 입력하세요"
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
        super.bind()

        let input = MajorViewModel.Input(
            nextButtonTap: nextButton.rx.tap.asObservable()
        )

        let output = viewModel.transform(input: input)
        output.nextStep
            .drive(onNext: { [weak self] step in
                self?.steps.accept(step)
            })
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            label,
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
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
