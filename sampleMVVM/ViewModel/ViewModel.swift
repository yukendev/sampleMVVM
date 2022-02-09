//
//  ViewModel.swift
//  sampleMVVM
//
//  Created by 手塚友健 on 2022/02/08.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: -- ViewModel
final class ViewModel {
    
    typealias Input = (
        idDriver: Driver<String>,
        passwordDriver: Driver<String>,
        passwordConfirmDriver: Driver<String>,
        registerButtonSignal: Signal<Void>
    )
    
    // バリデーションの結果
    let validationResult: Driver<ValidationResult>
    // 空欄がないかどうかのバリデーション
    let blankValidation: Driver<Bool>
    // パスワードとパスワード(確認用)が一致しているかどうかのバリデーション
    let passwordConfirmValidation: Driver<Bool>
    
    private let disposeBag = DisposeBag()
    
    init(input: Input) {
        
        let validationModel = ValidationModel()
        
        blankValidation = Driver.combineLatest(
            input.idDriver,
            input.passwordDriver,
            input.passwordConfirmDriver
        ) { id, password, passwordConfirm in
            return validationModel.blankBalidation(text: [id, password, passwordConfirm])
        }
        
        passwordConfirmValidation = Driver.combineLatest(
            input.passwordDriver,
            input.passwordConfirmDriver
        ) { password, passwordConfirm in
            return validationModel.passwordConfirmValidation(password: password, passwordConfirm: passwordConfirm)
        }
        
        validationResult = Driver.combineLatest(
            blankValidation,
            passwordConfirmValidation
        ) { blankValidation, passwordConfirmValidation in
            if !blankValidation {
                // 空白がある場合
                return .blankError
            } else if !passwordConfirmValidation {
                // パスワードが確認用と一致していない場合
                return .passwordConfirmError
            } else {
                // 全てのバリデーションがOKの場合
                return .ok
            }
        }
    }
}
