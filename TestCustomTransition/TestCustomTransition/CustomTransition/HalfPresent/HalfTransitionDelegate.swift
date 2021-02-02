//
//  HalfTransitionDelegate.swift
//  TestCustomTransition
//
//  Created by feng on 2021/1/7.
//  Copyright © 2021 feng. All rights reserved.
//

import Foundation
import UIKit

class HalfTransitionDelegate: YLTransitionDelegate {
    
    override func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfTransitionAnimator()
    }
    
    
    override func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfTransitionAnimator()
    }
    
//    override func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        if let igr = self.interactionGestureRecoginer {
//            return SwipeInteractionController(gestureRecognizer: igr, animationDirection: .toLeft)
//        }
//        return nil
//    }
    
    override func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let igr = self.interactionGestureRecoginer {
            return SwipeInteractionController(gestureRecognizer: igr, animationDirection: .toRight)
        }
        return nil
    }
    
     func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
         return YLPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
