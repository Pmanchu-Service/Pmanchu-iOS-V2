import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class NameViewController: BaseViewController<NameViewModel> {
    private var profileImageData = PublishRelay<Data>()

    private let signuplabel = PMAuthLabelView(
        explainText: "이름을 입력하세요"
    )
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 55
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .profile
        $0.backgroundColor = .red
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
    }

    public override func bind() {
        let input = NameViewModel.Input(
            nameText: nameTextField.rx.text.orEmpty.asObservable(),
            clickNextButton: nextButton.buttonTap.asObservable(),
            nextButton: nextButton
        )
        let output = viewModel.transform(input: input)
    }
    public override func bindAction() {
        cameraButton.rx.tap
            .debug("Camera Button Tap")
            .bind { [weak self] in
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self?.present(picker, animated: true)
                print("버튼 눌림")
            }.disposed(by: disposeBag)
    }

    public override func addView() {
        [
            signuplabel,
            profileImageView,
            cameraButton,
            nameTextField,
            nextButton
        ].forEach { view.addSubview($0) }
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
            $0.height.width.equalTo(106)
        }
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).inset(26)
            $0.leading.equalTo(profileImageView.snp.leading).inset(26)
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
extension NameViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true) { [weak self] in
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self?.profileImageView.image = image
            self?.profileImageData.accept(image?.jpegData(compressionQuality: 0.1) ?? Data())
        }
    }
}
