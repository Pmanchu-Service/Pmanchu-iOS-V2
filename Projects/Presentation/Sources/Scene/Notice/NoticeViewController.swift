import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import Domain
import DesignSystem

public class NoticeViewController: BaseViewController<NoticeViewModel> {
    public override func attribute() {
        super.attribute()
        view.backgroundColor = .red
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

}
