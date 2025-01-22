import UIKit
import RxSwift
import RxCocoa

final class NameImagePicker: NSObject {
    private let picker = UIImagePickerController()
    private let pickerSubject = PublishSubject<UIImage>()
    
    var selectImage: Observable<UIImage> {
        return pickerSubject.asObservable()
    }
    
    override init() {
        super.init()
        picker.delegate = self
    }
    
    func present(from viewController: UIViewController) {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        viewController.present(picker, animated: true)
    }
}

extension NameImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            pickerSubject.onNext(image)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
