//
//  SwipeAnimator.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/6.
//

import Foundation
import UIKit

class SwipeAnimator: YLTransitionAnimator {
  
    let animationDirection: AnimationDirection
    
    init(animationDirection:AnimationDirection) {
        self.animationDirection = animationDirection
        super.init()
    }
    
    deinit {
        debugPrint("SwipeAnimator deinit")
    }
    
    override func setToViewUIStateForPresenting(toView:UIView, isStart: Bool ,transitionContext: UIViewControllerContextTransitioning)  {
       
        let containerView = transitionContext.containerView

        if isStart {
            switch animationDirection {
            case .toLeft:
                toView.frame = containerView.frame.offsetBy(dx: containerView.bounds.width, dy: 0.0)
            case .toRight:
                toView.frame = containerView.frame.offsetBy(dx: -containerView.bounds.width, dy: 0.0)
            case .toBottom:
                toView.frame = containerView.frame.offsetBy(dx: 0.0, dy: -containerView.bounds.height)
            case .toTop:
                toView.frame = containerView.frame.offsetBy(dx: 0.0, dy: +containerView.bounds.height)
            }
        } else {
            toView.frame = containerView.bounds
        }
    }
    
    override func setFromViewUIStateForPresenting(fromView: UIView,isStart:Bool ,transitionContext: UIViewControllerContextTransitioning) {
        if isStart {
            guard let fromVC = transitionContext.viewController(forKey: .from) else { return}
            let fromFrame = transitionContext.initialFrame(for: fromVC)
            fromView.frame = fromFrame
        }
    }
    
    override func setFromViewUIStateForDismissal(fromView: UIView,isStart:Bool ,transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        if !isStart {
            ///消失过程动画方向与呈现过程相反
            switch animationDirection {
            case .toLeft:
            //to right
                fromView.frame = containerView.frame.offsetBy(dx: -containerView.bounds.width, dy: 0.0)
            case .toRight:
            // to left
                fromView.frame = containerView.frame.offsetBy(dx: containerView.bounds.width, dy: 0.0)
            case .toBottom:
            // to top
                fromView.frame = containerView.frame.offsetBy(dx: 0.0, dy: +containerView.bounds.height)
            case .toTop:
            // to bottom
                fromView.frame = containerView.frame.offsetBy(dx: 0.0, dy: -containerView.bounds.height)
            }
        }
    }
    
    override func setToViewUIStateForDismissal(toView: UIView,isStart:Bool ,transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
}




