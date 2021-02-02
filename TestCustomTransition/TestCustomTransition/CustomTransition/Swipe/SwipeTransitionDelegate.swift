//
//  SwipeTransitionDelegate.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/6.
//

import Foundation
import UIKit



class SwipeTranstionDelegate:YLTransitionDelegate {
    
    let presentingDirection: AnimationDirection
    let dissmissalDirection: AnimationDirection
    
    
    init(presentingDirection:AnimationDirection = .toLeft,
                  dissmissalDirection:AnimationDirection = .toRight) {
        self.presentingDirection = presentingDirection
        self.dissmissalDirection = dissmissalDirection
        super.init()
    }
    
    deinit {
        debugPrint("SwipeTranstionDelegate deinit")
    }
    
    override func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeAnimator(animationDirection: presentingDirection)
    }

    override func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeAnimator(animationDirection: dissmissalDirection)
    }

    
    override func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        ///设置了交互手势才能返回手势交互对象
        if let igr = interactionGestureRecoginer ,
           let animator = animator as? SwipeAnimator {
            return SwipeInteractionController(gestureRecognizer: igr,animationDirection:animator.animationDirection)
        }
        return nil
    }
 
    
    override func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
         ///设置了交互手势才能返回手势交互对象
        if let igr = interactionGestureRecoginer ,
           let animator = animator as? SwipeAnimator {
            return SwipeInteractionController(gestureRecognizer: igr,animationDirection:animator.animationDirection)
        }
        return nil
    }


    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
    
}

//MARK: -


