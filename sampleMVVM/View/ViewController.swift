//
//  ViewController.swift
//  sampleMVVM
//
//  Created by 手塚友健 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: -- View
class ViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewModel(
            input: (
                idTextField.rx.text.orEmpty.asDriver(),
                passwordTextField.rx.text.orEmpty.asDriver(),
                passwordConfirmTextField.rx.text.orEmpty.asDriver(),
                registerButton.rx.tap.asSignal()
            )
        )
        
        viewModel.validationResult.drive(onNext: { validationresult in
            self.registerButton.isEnabled = validationresult.isValidated
            self.validationLabel.text = validationresult.text
            self.validationLabel.textColor = validationresult.textColor
        }).disposed(by: disposeBag)
    }
}

