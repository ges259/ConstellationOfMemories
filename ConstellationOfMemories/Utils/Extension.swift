//
//  Extension.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import UIKit

// MARK: - Date
extension Date {
    func timeAgoToDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute: Int = 60
        let hour: Int = 60 * minute
        let day: Int = 24 * hour
        let week: Int = 7 * day
        let month: Int = 4 * week
        
        let quotient: Int // 몫
        let unit: String
        
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "SECOND"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "MIN"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "HOUR"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "DAY"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "WEEK"
        } else {
            quotient = secondsAgo / month
            unit = "MONTH"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "S" ) AGO"
    }
}



// MARK: - UIColor
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let textFieldGray: UIColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    
}



// MARK: - UIView
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeading: CGFloat = 0,
                
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTrailing: CGFloat = 0,
                
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                
                centerX: UIView? = nil,
                paddingCenterX: CGFloat = 0,
                
                centerY: UIView? = nil,
                paddingCenterY: CGFloat = 0,
                
                cornerRadius: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX.centerXAnchor, constant: paddingCenterX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY.centerYAnchor, constant: paddingCenterY).isActive = true
        }
        // cornerRadius
        if let cornerRadius = cornerRadius {
            self.clipsToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
}



// MARK: - UIStackView
extension UIStackView {
    
    func stackView(arrangedSubviews: [UIView],
                   axis: NSLayoutConstraint.Axis? = .vertical,
                   spacing: CGFloat? = nil,
                   alignment: UIStackView.Alignment? = nil,
                   distribution: UIStackView.Distribution? = nil)
    -> UIStackView {
        
        let stv = UIStackView(arrangedSubviews: arrangedSubviews)
        
        if let axis = axis {
            stv.axis = axis
        }
        if let distribution = distribution {
            stv.distribution = distribution
        }
        if let spacing = spacing {
            stv.spacing = spacing
        }
        if let alignment = alignment {
            stv.alignment = alignment
        }
        return stv
    }
}



// MARK: - UILabel
extension UILabel {
    func label(labelText: String? = nil,
               LabelTextColor: UIColor? = .darkGray,
               
               fontName: FontStyle? = .system,
               fontSize: CGFloat? = nil,
               
               numberOfLines: Int? = nil,
               textAlignment: NSTextAlignment? = nil)
    -> UILabel {
        
        let lbl = UILabel()
        
        // text
        if let labelText = labelText {
            lbl.text = labelText
            lbl.textColor = LabelTextColor
        }
        
        // font
        if let fontSize = fontSize {
            if fontName == .system {
                lbl.font = UIFont.systemFont(ofSize: fontSize)
            } else if fontName == .bold {
                lbl.font = UIFont.boldSystemFont(ofSize: fontSize)
            } else {
                lbl.font = UIFont(name: "Avenir-Light", size: fontSize)
            }
        }
        
        // numberOfLines
        if let numberOfLines = numberOfLines {
            lbl.numberOfLines = numberOfLines
        }
        // textAlignment
        if let textAlignment = textAlignment {
            lbl.textAlignment = textAlignment
        }
        return lbl
    }
}



// MARK: - UIButton
extension UIButton {
    func button(title: String? = nil,
                titleColor: UIColor? = nil,
                
                fontName: FontStyle? = .system,
                fontSize: CGFloat? = nil,
                
                tintColor: UIColor? = UIColor.black,
                
                borderColor: UIColor? = nil,
                borderWidth: CGFloat? = 2,
                
                backgroundColor: UIColor? = nil,
                
                isEnable: Bool? = nil,
                
                image: String? = nil)
    -> UIButton {
        // type
        let btn = UIButton(type: .system)

        // text
        if let title = title {
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
        }
        // tintColor
        btn.tintColor = tintColor
        
        // font
        if let fontSize = fontSize {
            switch fontName {
            case .system:
                btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
                
                
            case .bold:
                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
                
                
            case .AvenirLight:
                btn.titleLabel?.font = UIFont(name: "Avenir-Light", size: fontSize)
            
            default:
                btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
        
        if let borderColor = borderColor, let borderWidth = borderWidth {
            btn.layer.borderColor = borderColor.cgColor
            btn.layer.borderWidth = borderWidth
        }
        
        
        // background Color
        if let backgroundColor = backgroundColor {
            btn.backgroundColor = backgroundColor
        }
//        // cornerRadius
//        if let cornerRadius = cornerRadius {
//            btn.clipsToBounds = true
//            btn.layer.cornerRadius = cornerRadius
//        }
        // button enable
        if isEnable == false {
            btn.isEnabled = false
        }
        // image
        if let image = image {
            btn.setImage(#imageLiteral(resourceName: image).withRenderingMode(.alwaysOriginal), for: .normal)
            btn.contentMode = .scaleAspectFit
        }
        return btn
    }
    
    
    // mutableAttributedString
    func mutableAttributedString(buttonType: UIButton.ButtonType,
                                 
                                 type1TextString: String,
                                 type1FontName: FontStyle,
                                 type1FontSize: CGFloat,
                                 type1Foreground: UIColor,
                                 
                                 type2TextString: String,
                                 type2FontName: FontStyle,
                                 type2FontSize: CGFloat,
                                 type2Foreground: UIColor) -> UIButton {
        // mutable_Attributed_String 받아오기
        let attributedTitle = NSMutableAttributedString().mutableAttributedText(type1TextString: type1TextString,
                                                                      type1FontName: type1FontName,
                                                                      type1FontSize: type1FontSize,
                                                                      type1Foreground: type1Foreground,
                                                                      
                                                                      type2TextString: type2TextString,
                                                                      type2FontName: type2FontName,
                                                                      type2FontSize: type2FontSize,
                                                                      type2Foreground: type2Foreground)
        // 버튼 만들기
        let attributedButton = UIButton(type: buttonType)
            // 버튼에 string 추가
            attributedButton.setAttributedTitle(attributedTitle, for: .normal)
        return attributedButton
    }
}



// MARK: - NSMutableAttributedString
extension NSMutableAttributedString {
    
    func mutableAttributedText(type1TextString: String,
                               type1FontName: FontStyle,
                               type1FontSize: CGFloat,
                               type1Foreground: UIColor,
                               
                               type2TextString: String,
                               type2FontName: FontStyle,
                               type2FontSize: CGFloat,
                               type2Foreground: UIColor,
                               
                               type3TextString: String? = nil,
                               type3FontName: FontStyle? = nil,
                               type3FontSize: CGFloat? = nil,
                               type3Foreground: UIColor? = nil
    ) -> NSMutableAttributedString {
        
        // UIFont 설정
        let type1Font: UIFont = type1FontName == FontStyle.system ? UIFont.systemFont(ofSize: type1FontSize) : UIFont.boldSystemFont(ofSize: type1FontSize)
        
        let type2Font: UIFont = type2FontName == FontStyle.system ? UIFont.systemFont(ofSize: type2FontSize) : UIFont.boldSystemFont(ofSize: type2FontSize)
        
        // Mutable_Attributed_String 설정
        let attributedTitle = NSMutableAttributedString(
            string: type1TextString,
            attributes: [NSAttributedString.Key.font : type1Font,
                         NSAttributedString.Key.foregroundColor : type1Foreground]
        )
        attributedTitle.append(NSAttributedString(
            string: type2TextString,
            attributes: [NSAttributedString.Key.font : type2Font,
                         NSAttributedString.Key.foregroundColor : type2Foreground])
        )
        
        // type 3
        if let type3TextString = type3TextString,
           let type3FontName = type3FontName,
           let type3FontSize = type3FontSize,
           let type3Foreground = type3Foreground
        {
            // type 3 - font 설정
            let type3Font: UIFont = type3FontName == FontStyle.system ? UIFont.systemFont(ofSize: type1FontSize) : UIFont.boldSystemFont(ofSize: type3FontSize)
            
            attributedTitle.append(NSAttributedString(
                string: type3TextString,
                attributes: [NSAttributedString.Key.font : type3Font,
                             NSAttributedString.Key.foregroundColor : type3Foreground])
            )
        }
        return attributedTitle
    }
}



// MARK: - TextField
extension UITextField {
    
    func textField(withPlaceholder placeholder: String,
                   
                   textColor: UIColor? = .black,
                   
                   fontSize: CGFloat? = 16,
                   
                   backgroundColor: UIColor? = UIColor.clear,
                   
                   keyboardType: UIKeyboardType = .webSearch,
                   isSecureTextEntry: Bool? = false,
                   
                   paddingLeftView: Bool? = false,
                   paddingInt: CGFloat? = 16)
    
    -> UITextField {
        
        let tf = UITextField()
        
        // set keyboardType
        tf.keyboardType = keyboardType
        
        // set text color
        tf.textColor = textColor
        
        // set font size
        tf.font = UIFont.systemFont(ofSize: fontSize!)
        
        // set background color
        tf.backgroundColor = backgroundColor
        
        // set placeholder
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        // padding Left View
        if paddingLeftView! {
            let paddingView = UIView()
                paddingView.anchor(width: paddingInt, height: 30)
            tf.leftView = paddingView
            tf.leftViewMode = .always
        }
        // cornerRadius
//        if let cornerRadius = cornerRadius {
//            tf.clipsToBounds = true
//            tf.layer.cornerRadius = cornerRadius
//        }
        // secureTextEntry
        tf.isSecureTextEntry = isSecureTextEntry ?? false
        
        tf.borderStyle = .none
        
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        
        tf.textContentType = .oneTimeCode
        
        return tf
    }
}
