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
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    static let textFieldGray: UIColor = UIColor.rgb(r: 149, g: 204, b: 244)
    
    static let nightFontColor: UIColor = UIColor(white: 1, alpha: 1)
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
    
    
    // MARK: - viewConfig
    func viewConfig(backgroundColor color: UIColor,
              borderColor: UIColor? = nil,
              borderWidth: CGFloat = 3) -> UIView {
        
        let view = UIView()
            // background Color
            view.backgroundColor = color
        
        // configure border
        if let borderColor = borderColor {
            // border Color
            view.layer.borderColor = borderColor.cgColor
            // border Width
            view.layer.borderWidth = borderWidth
        }
        return view
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
    func labelConfig(labelText: String = "",
                     LabelTextColor: UIColor = .darkGray,
                     
                     fontName: FontStyle = .system,
                     fontSize: CGFloat? = nil,
                     
                     borderColor: UIColor? = nil,
                     borderWidth: CGFloat = 1,
                     
                     numberOfLines: Int? = nil,
                     textAlignment: NSTextAlignment? = nil)
    -> UILabel {
        
        let lbl = UILabel()
        
        // numberOfLines
        if let numberOfLines = numberOfLines {
            lbl.numberOfLines = numberOfLines
        }
        
        
        // text
        lbl.text = labelText
        // text Color
        lbl.textColor = LabelTextColor
        
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
        
        // Border
        if let borderColor = borderColor?.cgColor {
            lbl.layer.borderColor = borderColor
            lbl.layer.borderWidth = borderWidth
        }
        
        // textAlignment
        if let textAlignment = textAlignment {
            lbl.textAlignment = textAlignment
        }
        return lbl
    }
    
    func homeMiniDiary(title: String) -> UILabel {
        let lbl = UILabel()
            lbl.text = title
            lbl.textColor = .nightFontColor
            lbl.font = .boldSystemFont(ofSize: 9)
            lbl.textAlignment = .center
            lbl.layer.borderColor = UIColor.white.cgColor
            lbl.layer.borderWidth = 1
            lbl.layer.cornerRadius = 6
            lbl.clipsToBounds = true
        return lbl
    }
}



// MARK: - UIButton
extension UIButton {
    func buttonSustemImage(btnSize: CGFloat,
                           imageString: imageString)
    -> UIButton {
        // setImg를 쓸까..? 굳이 한 번 더 거쳐야 하나?
        let imageConfig = UIImage.SymbolConfiguration(pointSize: btnSize, weight: .regular)
        let image = UIImage(systemName: imageString.description, withConfiguration: imageConfig)
        
        let btn = UIButton()
            btn.setImage(image, for: .normal)
            btn.tintColor = .white
        return btn
    }
    
    func authButton(title: String,
                    backgroundColor: UIColor = UIColor(white: 1, alpha: 0.3))
    -> UIButton {
        let btn = UIButton(type: .system)
        
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.lightGray, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            btn.backgroundColor = backgroundColor
//        btn.isEnabled = false
        
            btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 10
        
        return btn
    }
    
    
    
    
    
    // mutableAttributedString
    func mutableAttributedString(buttonType: UIButton.ButtonType = .system,
                                 
                                 type1TextString: String,
                                 type1FontName: FontStyle = .system,
                                 type1FontSize: CGFloat = 14,
                                 type1Foreground: UIColor = .lightGray,
                                 
                                 type2TextString: String,
                                 type2FontName: FontStyle = .bold,
                                 type2FontSize: CGFloat = 14,
                                 type2Foreground: UIColor = .black) -> UIButton {
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
        
        // 버튼 만들기
        let attributedButton = UIButton(type: buttonType)
            // 버튼에 string 추가
            attributedButton.setAttributedTitle(attributedTitle, for: .normal)
        return attributedButton
    }
    
}



// MARK: - UIImage
extension UIImage {
    static func setImg(_ leftBtnImg: imageString, pointSize: CGFloat = 31) -> UIImage {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .light)
        let img: UIImage = UIImage(systemName: leftBtnImg.description,
                                   withConfiguration: imageConfig)!
        return img
    }
}


// MARK: - TextField
extension UITextField {
    
    func textField(withPlaceholder placeholder: String,
                   
                   textColor: UIColor? = .black,
                   
                   fontSize: CGFloat? = 16,
                   
                   keyboardType: UIKeyboardType = .webSearch,
                   
                   isSecureTextEntry: Bool? = false)
    
    -> UITextField {
        
        let tf = UITextField()
        
        // set placeholder _ FontColor
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        // set keyboardType
        tf.keyboardType = keyboardType
        
        // set text color
        tf.textColor = textColor
        
        // set font size
        tf.font = UIFont.systemFont(ofSize: fontSize!)
        
        // set background color
        tf.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        
        // padding Left View
        let paddingView = UIView()
            paddingView.anchor(width: 16, height: 50)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        // cornerRadius
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 10
        
        // secureTextEntry
        tf.isSecureTextEntry = isSecureTextEntry ?? false
        
        tf.borderStyle = .none
        
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        
        tf.textContentType = .oneTimeCode
        
        return tf
    }
}
