import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture
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
    private let scrollView = UIScrollView()
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
    }

    public override func setupKeyboard() {
        Observable.merge([
            view.rx.tapGesture().when(.recognized).map { _ in () }
        ])
        .subscribe(onNext: { [weak self] in
            self?.view.endEditing(true)
        })
        .disposed(by: disposeBag)
    }

    public override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    public override func addView() {
        [
            signupLabel,
            skillTextField,
            addButton,
            scrollView,
            nextButton
        ].forEach { view.addSubview($0) }

        scrollView.addSubview(stackView)
    }

    public override func bind() {
        let input = SkillViewModel.Input(
            skillText: skillTextField.rx.text.orEmpty.asObservable(),
            clickNextButton: nextButton.buttonTap.asObservable(),
            addButtonTap: addButton.buttonTap.asObservable(),
            deleteSkill: viewModel.deleteSkillSubject.asObservable(),
            nextButton: nextButton
        )

        let output = viewModel.transform(input: input)

        output.isButtonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        output.skills
            .drive(onNext: { [weak self] skills in
                self?.updateSkillViews(with: skills)
            })
            .disposed(by: disposeBag)

        addButton.buttonTap
            .subscribe(onNext: { [weak self] in
                self?.skillTextField.text = ""
                self?.skillTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }

    private func updateSkillViews(with skills: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        skills.forEach { skill in
            let skillView = SkillItemView()
            skillView.configure(with: skill)

            skillView.deleteButtonTapped
                .subscribe(onNext: { [weak self] in
                    self?.viewModel.deleteSkillSubject.accept(skill)
                })
                .disposed(by: disposeBag)

            stackView.addArrangedSubview(skillView)
        }
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

        scrollView.snp.makeConstraints {
            $0.top.equalTo(skillTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-16)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
