//
//  UIWindow+.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

extension UIWindow {

    func replaceRootViewController(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {

           let snapshotImageView = UIImageView(image: self.snapshot())
           self.addSubview(snapshotImageView)

           let dismissCompletion = { () -> Void in
               self.rootViewController = replacementController
               self.bringSubviewToFront(snapshotImageView)

               if animated {
                   UIView.animate(withDuration: 0.4, animations: { () -> Void in
                       snapshotImageView.alpha = 0
                   }, completion: { (success) -> Void in
                       snapshotImageView.removeFromSuperview()
                       completion?()
                   })
               }
               else {
                   snapshotImageView.removeFromSuperview()
                   completion?()
               }
           }

           if self.rootViewController!.presentedViewController != nil {
               self.rootViewController!.dismiss(animated: false, completion: dismissCompletion)
           }

           else {
               dismissCompletion()
           }
       }

    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage.init() }
        UIGraphicsEndImageContext()
        return result
    }

}
