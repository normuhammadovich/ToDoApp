//
//  ex+UIView.swift
//  ToDoApp_exam
//
//  Created by Chingiz Jumanov on 26/10/22.
//

import Foundation
import UIKit


extension UIView {
    
    /// CornerRadius bervomiz
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        
        set { return layer.cornerRadius = newValue }
    }
    
    /// BorderWidth bervomiz
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        
        set {
            return layer.borderWidth = newValue
        }
    }
    /// BorderColor bervomiz
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        
        set { layer.borderColor = newValue?.cgColor }
    }
    
}
