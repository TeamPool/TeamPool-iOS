//
//  ImageLiterals.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation
import UIKit

enum ImageLiterals {

    //MARK: - tabBarIcon
    static var homeFill: UIImage { .load(name: "homeFill")}
    static var pool: UIImage { .load(name: "plus")}
    static var calendar: UIImage { .load(name: "calendar")}
    static var myPage: UIImage { .load(name: "person")}

}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }

    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
}
