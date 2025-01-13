import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class EmailViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    private let emailErrorDescription = PublishRelay<String?>()
    
    public struct Input {
        let emailText: Observable<String>
        let clickNextButton: Observable<Void>
        let nextButton: PMButton
    }
    
    public struct Output {
        let emailErrorDescription: Signal<String?>
    }
    
    public func transform(input: Input) -> Output {
        let emailText = input.emailText.share()
        emailText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .subscribe(onNext: { isEnabled in
                input.nextButton.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)
        
        input.clickNextButton
            .withLatestFrom(emailText)
            .filter { [weak self] email in
                guard let self = self else { return false }
                return self.checkEmailData(email)
            }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(PMStep.nameIsRequired)
            })
            .disposed(by: disposeBag)
        
        return Output(
            emailErrorDescription: emailErrorDescription.asSignal()
        )
    }
    
    private func checkEmailData(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedEmail.isEmpty {
            emailErrorDescription.accept("이메일을 입력해주세요")
            return false
        }
        
        emailErrorDescription.accept(nil)
        return true
    }
}
