import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class NameViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    private let keychain = KeychainImpl()
    private let signUpUseCase: SignUpUseCase

    private let nameErrorDescription = PublishRelay<String?>()

    public init(signUpUseCase: SignUpUseCase) {
        self.signUpUseCase = signUpUseCase
    }

    public struct Input {
        let nameText: Observable<String>
        let clickNextButton: Observable<Void>
        let nextButton: PMButton
    }

    public struct Output {
        let nameErrorDescription: Signal<String?>
    }

    public func transform(input: Input) -> Output {
        let nameText = input.nameText.share()

        nameText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .subscribe(onNext: { isEnabled in
                input.nextButton.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)

        input.clickNextButton
            .withLatestFrom(nameText)
            .filter { [weak self] name in
                guard let self = self else { return false }
                return self.checkNameData(name)
            }
            .flatMap { [weak self] name -> Single<Step> in
                guard let self = self else { return .never() }

                let signUpRequest = SignUpRequestParams(
                    name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                    majors: [""],
                    rank: 0,
                    introduction: "",
                    shortIntroduction: "",
                    contact: "",
                    links: [""],
                    stacks: [""]
                )

                return self.signUpUseCase.execute(req: signUpRequest)
                    .catch { [weak self] error in
                        print("SignUp Error: \(error.localizedDescription)")
                        self?.nameErrorDescription.accept("이름 저장에 실패했습니다. 다시 시도해주세요.")
                        return .never()
                    }
                    .andThen(Single.just(PMStep.rankIsRequired))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            nameErrorDescription: nameErrorDescription.asSignal()
        )
    }
}

extension NameViewModel {
    private func checkNameData(_ name: String) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedName.isEmpty {
            nameErrorDescription.accept("이름을 입력해주세요")
            return false
        } else {
            nameErrorDescription.accept(nil)
            return true
        }
    }
}
