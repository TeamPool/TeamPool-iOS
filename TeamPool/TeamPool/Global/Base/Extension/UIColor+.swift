//
//  UIColor+.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit


extension UIColor {
    static var poolBlue1: UIColor {
        return UIColor(hex: "#4E709D")
    }

    static var poolBlue2: UIColor {
        return UIColor(hex: "#89A4C7")
    }

    static var poolBlue3: UIColor {
        return UIColor(hex: "#D2E0FB")
    }

    //MARK: - BackGround

    static var poolBackGround: UIColor {
        return UIColor(hex: "#EFF5FF")
    }

    //MARK: - Text
    static var poolGray1: UIColor {
        return UIColor(hex: "#8B8B8B")
    }

    static var poolGray2: UIColor {
        return UIColor(hex: "#CACACA")
    }

    //MARK: - TimeTable Colors
    static var timetableColors: [UIColor] {
        return [
            UIColor(red: 0.98, green: 0.26, blue: 0.21, alpha: 0.3), // 빨강
            UIColor(red: 0.91, green: 0.12, blue: 0.39, alpha: 0.3), // 핑크
            UIColor(red: 0.61, green: 0.15, blue: 0.69, alpha: 0.3), // 보라
            UIColor(red: 0.40, green: 0.23, blue: 0.72, alpha: 0.3), // 남색
            UIColor(red: 0.26, green: 0.44, blue: 0.76, alpha: 0.3), // 파랑
            UIColor(red: 0.01, green: 0.66, blue: 0.96, alpha: 0.3), // 하늘색
            UIColor(red: 0.00, green: 0.75, blue: 0.67, alpha: 0.3), // 청록색
            UIColor(red: 0.30, green: 0.69, blue: 0.31, alpha: 0.3), // 초록
            UIColor(red: 0.54, green: 0.76, blue: 0.00, alpha: 0.3), // 연두
            UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 0.3), // 노랑
            UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 0.3), // 주황
        ]
    }
    
    //MARK: - Calendar Colors
    static var CalendarColar1: UIColor {
        return UIColor(hex: 0x00C7BE, alpha: 0.5)
    }
    static var CalendarColar2: UIColor {
        return UIColor(hex: 0x30B0C7, alpha: 0.5)
    }
    static var CalendarColar3: UIColor {
        return UIColor(hex: 0x007AFF, alpha: 0.5)
    }
    static var CalendarColar4: UIColor {
        return UIColor(hex: 0x32ADE6, alpha: 0.5)
    }
    static var CalendarColar5: UIColor {
        return UIColor(hex: 0x5856D6, alpha: 0.5)
    }


}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
