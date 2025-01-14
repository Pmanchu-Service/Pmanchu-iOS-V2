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
    
    
    
    
}
