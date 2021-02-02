//
//  YLTransitionDelegate.swift
//  TestCustomTransition
//
//  Created by feng on 2021/1/7.
//  Copyright © 2021 feng. All rights reserved.
//

import Foundation
import UIKit

///UIViewControllerTransitioningDelegate基类,主要是为了统一类型
class YLTransitionDelegate:NSObject, UIViewControllerTransitioningDelegate  {
    var interactionGestureRecoginer:UIGestureRecognizer?
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YLTransitionAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YLTransitionAnimator()
    }
    
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        ///默认不支持 presentation 的交互手势
        return nil
    }
    
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let igr = interactionGestureRecoginer  {
            return YLInteractionController(gestureRecognizer: igr)
        }
        return nil
    }
}
