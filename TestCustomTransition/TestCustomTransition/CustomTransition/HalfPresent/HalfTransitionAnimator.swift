//
//  HalfTransitionAnimator.swift
//  TestCustomTransition
//
//  Created by feng on 2021/1/7.
//  Copyright © 2021 feng. All rights reserved.
//

import Foundation
import UIKit

class HalfTransitionAnimator: YLTransitionAnimator {

    override func setToViewUIStateForPresenting(toView: UIView, isStart: Bool, transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if isStart {
            toView.frame = containerView.frame.offsetBy(dx: containerView.bounds.width, dy: 0.0)
        } else {
            let half =  0.5 * containerView.bounds.width
            toView.frame = CGRect(x: half, y: 0, width: half, height: containerView.bounds.height)
        }
    }
    
    override func setFromViewUIStateForDismissal(fromView: UIView, isStart: Bool, transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if !isStart {
            let half = 0.5 * containerView.bounds.width
            fromView.frame =  CGRect(x: containerView.bounds.width, y: 0, width: half, height: containerView.bounds.height)
        }
    }
    
}
