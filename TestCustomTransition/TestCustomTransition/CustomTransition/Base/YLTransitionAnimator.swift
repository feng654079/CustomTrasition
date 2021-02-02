//
//  YLTransitionAnimator.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/7.
//

import Foundation
import UIKit

///动画器基类,分离了动画状态的几个时间点,只要关注这几个时间点view的UI状态就可以了
public class YLTransitionAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (transitionContext?.isAnimated ?? false) ? 0.35 : 0.0
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else {
            fatalError("\(#function) 必要数据获取失败")
        }
        var fromView = transitionContext.view(forKey: .from)
        var toView = transitionContext.view(forKey: .to)
        // modalPresentationStyle 为.custom 时会为空
        if fromView == nil  { fromView = fromVC.view }
        if toView == nil { toView = fromVC.view}
        
        let containerView = transitionContext.containerView
        let isPresenting = (toVC.presentingViewController == fromVC)
        
        if isPresenting {
            self.setFromViewUIStateForPresenting(fromView: fromView!, isStart: true, transitionContext: transitionContext)
            self.setToViewUIStateForPresenting(toView: toView!, isStart: true, transitionContext: transitionContext)
            containerView.addSubview(toView!)
        } else {
            //containerView.insertSubview(toView!, at: 0)
            self.setFromViewUIStateForDismissal(fromView: fromView!, isStart: true, transitionContext: transitionContext)
            self.setToViewUIStateForDismissal(toView: toView!, isStart: true, transitionContext: transitionContext)
        }
        
        self.performAnimation(isPresenting: isPresenting, transitionContext: transitionContext, animation: {
            if isPresenting {
                self.setFromViewUIStateForPresenting(fromView: fromView!, isStart: false, transitionContext: transitionContext)
                self.setToViewUIStateForPresenting(toView: toView!, isStart: false, transitionContext: transitionContext)
            } else {
                self.setFromViewUIStateForDismissal(fromView: fromView!, isStart: false, transitionContext: transitionContext)
                self.setToViewUIStateForDismissal(toView: toView!, isStart: false, transitionContext: transitionContext)
            }
        }) { (finished) in
            let wasCanceled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCanceled)
        }
        
    }
    
    //MARK: subclass override point
    /// 设置呈现过程 toView  初始UI状态
    public func setToViewUIStateForPresenting(toView:UIView, isStart: Bool ,transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if isStart {
            toView.frame = containerView.frame.offsetBy(dx: containerView.bounds.width, dy: 0.0)
        } else {
            toView.frame = containerView.bounds
        }
    }
    
    /// 设置呈现过程 fromeView  初始UI状态
    public func setFromViewUIStateForPresenting(fromView: UIView,isStart:Bool ,transitionContext: UIViewControllerContextTransitioning) {
       guard
        let fromVC = transitionContext.viewController(forKey: .from)
       else {
        return
       }
        if isStart {
            fromView.frame = transitionContext.initialFrame(for: fromVC)
        }
    }
    
    /// 设置消失过程 fromeView  初始UI状态
    public func setFromViewUIStateForDismissal(fromView: UIView,isStart:Bool ,transitionContext: UIViewControllerContextTransitioning) {
        
        if !isStart {
            let containerView = transitionContext.containerView
            fromView.frame = containerView.frame.offsetBy(dx: containerView.bounds.width, dy: 0.0)
        }
        
    }
    /// 设置消失过程 toView  初始UI状态
    public func setToViewUIStateForDismissal(toView: UIView,isStart:Bool ,transitionContext: UIViewControllerContextTransitioning) {
        //does nothing
    }
    
    
    public func performAnimation(isPresenting: Bool ,transitionContext: UIViewControllerContextTransitioning,animation:@escaping () -> Void ,completion:@escaping (Bool) -> Void) {
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
             animation()
        }) { (finished) in
            completion(finished)
        }
        
    }
}



