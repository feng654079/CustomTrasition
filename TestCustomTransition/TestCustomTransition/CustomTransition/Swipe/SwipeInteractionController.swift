//
//  SwipeInteractionController.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/6.
//

import Foundation
import UIKit

class SwipeInteractionController:  YLInteractionController  {
    let animationDirection: AnimationDirection
    init(gestureRecognizer:UIGestureRecognizer,animationDirection:AnimationDirection) {
        self.animationDirection = animationDirection
        super.init(gestureRecognizer:gestureRecognizer)
    }

    deinit {
        debugPrint("SwipeInteractionController deinit")
    }

    override func progressFor(_ gestureRecognizer: UIGestureRecognizer, transitionContext: UIViewControllerContextTransitioning) -> CGFloat {
        
        guard
            let fromVC = transitionContext.fromViewController
             else {
            return -1.0
        }
        let containerView = transitionContext.containerView
        var fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        if transitionContext.isPresenting == false {
            fromViewInitialFrame = transitionContext.finalFrame(for: fromVC)
        }
        let loc = gestureRecognizer.location(in: containerView)
       
        switch animationDirection {
        case .toLeft:
            return max(0.0,(fromViewInitialFrame.width - loc.x)) /  fromViewInitialFrame.width
        case .toRight:
            return max(0.0,loc.x - fromViewInitialFrame.minX) / fromViewInitialFrame.width
        case .toBottom:
            return loc.y / fromViewInitialFrame.height
        case .toTop:
            return max(0.0,fromViewInitialFrame.height - loc.y) / fromViewInitialFrame.height
        }
    }
    
    private func _progressFor(_ gestureRecognizer: UIGestureRecognizer, transitionContext: UIViewControllerContextTransitioning) -> CGFloat {
        
        let containerView = transitionContext.containerView
        let loc = gestureRecognizer.location(in: containerView)
        switch animationDirection {
        case .toLeft:
            return (containerView.bounds.width - loc.x) / containerView.bounds.width
        case .toRight:
            return loc.x / containerView.bounds.width
        case .toBottom:
            return loc.y / containerView.bounds.height
        case .toTop:
            return (containerView.bounds.height - loc.y) / containerView.bounds.height
        }
    }
    
}
