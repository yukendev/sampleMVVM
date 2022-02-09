//
//  ValidationModel.swift
//  sampleMVVM
//
//  Created by 手塚友健 on 2022/02/09.
//

import Foundation
import UIKit

enum ValidationResult {
    
    case ok
    case blankError
    case passwordConfirmError
    
    var isValidated: Bool {
        switch self {
        case .ok: return true
        case .blankError, .passwordConfirmError: return false
        }
    }
    
    var text: String {
        switch self {
        case .ok: return "登録可能です"
        case .blankError: return "空欄があります"
        case .passwordConfirmError: return "パスワードが確認用と一致していません"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .ok: return .green
        case .blankError, .passwordConfirmError: return .red
        }
    }
}

// MARK: -- Model
final class ValidationModel {
    // 引数の[String]の中に空文字があったらfalseを返す
    func blankBalidation(text: [String]) -> Bool {
        for text in text {
            if text.isEmpty {
                return false
            }
        }
        return true
    }
    
    // パスワードとパスワード(確認用)が一致してなかったらfalseを返す
    func passwordConfirmValidation(password: String, passwordConfirm: String) -> Bool {
        return password == passwordConfirm
    }
    
}
