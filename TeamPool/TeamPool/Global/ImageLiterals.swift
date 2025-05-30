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
    static var homeFill: UIImage { .load(name: "Home")}
    static var pool: UIImage { .load(name: "Plus")}
    static var calendar: UIImage { .load(name: "Calendar")}
    static var myPage: UIImage { .load(name: "Person")}

    //MARK: - LoginIcon
    static var logInPerson: UIImage { .load(name: "LoginPerson")}
    static var logInLock: UIImage { .load(name: "LoginLock")}

    //MARK: - ProfileIcon
    static var mypageProfile: UIImage { .load(name: "Profile")}
    
    //MARK: - SettingIcon
    static var settingProfile: UIImage { .load(name: "Setting_Profile")}
    static var settingCalendar: UIImage { .load(name: "Setting_Calendar")}
    static var settingFriend: UIImage { .load(name: "Setting_Friend")}
    static var settingAgreement: UIImage { .load(name: "Setting_Agreement")}
    static var settingArrow: UIImage { .load(name: "Arrow")}
    
    //MARK: - SercingIcon
    static var SearchIcon: UIImage { .load(name: "Search")}
    
    //MARK: -Logout
    static var LogoutIcon: UIImage { .load(name: "Logout")}
    //MARK: - PoolIcon
    static var teamIcon: UIImage { .load(name: "TeamIcon")}
    static var bookMark: UIImage { .load(name: "BookMark")}
    static var check: UIImage { .load(name: "Check")}

    //MARK: - StepImage
    static var step1: UIImage { .load(name: "Step1")}
    static var step2: UIImage { .load(name: "Step2")}
    static var step3: UIImage { .load(name: "Step3")}
    static var step4: UIImage { .load(name: "Step4")}
    
    //MARK: - Pool
    static var poolRecord_start: UIImage { .load(name: "Record_start")}
    static var poolRecord_end: UIImage { .load(name: "Record_end")}

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
