//
//  YLInteractionController.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/7.
//

import Foundation
import UIKit

///交互手势处理基类,封装了百分比更新逻辑,使外界只要关注如何计算百分比即可
public class YLInteractionController: UIPercentDrivenInteractiveTransition {
    private var gestureRecognizer: UIGestureRecognizer
    
    private(set) var transitionContext: UIViewControllerContextTransitioning?
    
    public init(gestureRecognizer:UIGestureRecognizer) {
        self.gestureRecognizer = gestureRecognizer
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(handleGestureRecognizer(_:)))
    }
    
    @objc private func handleGestureRecognizer(_ sender:UIGestureRecognizer) {
        guard
            let pan = sender as? UIPanGestureRecognizer,
            let tct = self.transitionContext
              else {
            /// error,直接结束动画过程
            self.finish()
            return
        }
        
        let progress = progressFor(pan,transitionContext:tct)
        if progress < 0.0 {
            self.finish()
            return
        }
        
        switch sender.state {
        case .began: break
        case .changed:
            self.update(progress)
        case .ended:
            if progress >= 0.5 {
                self.finish()
            } else {
                self.cancel()
            }
        default:
            self.cancel()
        }
    }
    
    public override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        super.startInteractiveTransition(transitionContext)
    }
    
    //MARK: 子类重载点
   public func progressFor(_ gestureRecognizer:UIGestureRecognizer,transitionContext:UIViewControllerContextTransitioning) -> CGFloat {
        let containerView = transitionContext.containerView
        let progress = gestureRecognizer.location(in: containerView).x / containerView.bounds.width
        return progress
    }
}
