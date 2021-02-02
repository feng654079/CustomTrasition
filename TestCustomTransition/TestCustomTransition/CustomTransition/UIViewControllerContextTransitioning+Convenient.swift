//
//  UIViewControllerContextTransitioning+convenient.swift
//  TestCustomTransition
//
//  Created by feng on 2021/1/7.
//  Copyright © 2021 feng. All rights reserved.
//

import Foundation
import UIKit

extension UIViewControllerContextTransitioning {
    
    var fromViewController: UIViewController? {
        return viewController(forKey: .from)
    }
    
    var toViewController:UIViewController? {
        return viewController(forKey: .to)
    }
    
    func getFromView() -> UIView? {
        var fromView = view(forKey: .from)
        if fromView == nil  {
           fromView = fromViewController?.view
        }
        return fromView
    }
    
    func getToView() -> UIView? {
        var toView = view(forKey: .to)
        if toView == nil  {
            toView = toViewController?.view
        }
        return toView
    }
    

    var isPresenting: Bool {
       return toViewController?.presentingViewController == fromViewController
    }
}
