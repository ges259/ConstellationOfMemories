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
        
        // numberOfLines
        if let numberOfLines = numberOfLines {
            lbl.numberOfLines = numberOfLines
        }
        
        
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
        
        
        // textAlignment
        if let textAlignment = textAlignment {
            lbl.textAlignment = textAlignment
        }
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
}


// MARK: - UIImage
extension UIImage {
    static func setImg(_ leftBtnImg: imageString) -> UIImage {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let img: UIImage = UIImage(systemName: leftBtnImg.description,
                                   withConfiguration: imageConfig)!
        return img
    }
}

