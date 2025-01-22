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
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .profile
    }
    private let cameraButton = UIButton().then {
        $0.setImage(.camera, for: .normal)
    }
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
            profileImageView,
            nameTextField,
            nextButton
        ].forEach { view.addSubview($0) }
        profileImageView.addSubview(cameraButton)
    }

    public override func setLayout() {
        signuplabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(224)
            $0.height.equalTo(73)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(signuplabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(24)
        }
        cameraButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(45)
        }
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
    }
}
