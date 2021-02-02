//
//  UIViewController+SwipTransition.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/7.
//

import Foundation
import UIKit

extension NSObject {
    func lazyAssociatedObject<R>(key:UnsafeRawPointer,associationPolicy: objc_AssociationPolicy,creator: () -> R ) -> R {
        if let obj = objc_getAssociatedObject(self,key) as? R{
            return obj
        }
        let obj = creator()
        objc_setAssociatedObject(self, key, obj, associationPolicy)
        return obj
    }
}

extension UIViewController {
    
    private static var TransitionDelegateKey = "SwipeTransitionDelegateKey"
    fileprivate var storedTransitionDelegate: YLTransitionDelegate? {
        
        set {
            objc_setAssociatedObject(self, &UIViewController.TransitionDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
           return objc_getAssociatedObject(self, &UIViewController.TransitionDelegateKey) as? YLTransitionDelegate
        }
    }
}


protocol Interactionable:NSObjectProtocol {}

fileprivate extension Interactionable {
    
    func asInteractionGestureRecognizer() -> UIGestureRecognizer? {
        guard
            self.isKind(of: UIPanGestureRecognizer.self)
        else {
            return nil
        }
        return (self as! UIGestureRecognizer)
    }
}

extension UIPanGestureRecognizer: Interactionable {}

extension UIViewController {
    
    
    func preparePresentTransition(for presentedViewController:UIViewController,
                                transitionDelegateCreator: () -> YLTransitionDelegate )  {
        presentedViewController.modalPresentationStyle = .custom
        let std = transitionDelegateCreator()
        self.storedTransitionDelegate = std
        presentedViewController.transitioningDelegate = std
    }
    
    
    /// 配置呈现转场交互手势,传nil时表示清除
    /// - Parameter igr: 转场交互手势对象, 必须是UIPanGestureRecognizer或其子类
    func configPresentationInteractionGestureRecoginzer(_ igr:Interactionable?) {
        let vc:UIViewController = self
        guard let td = vc.storedTransitionDelegate  else {
            return
        }
        if igr == nil {
            td.interactionGestureRecoginer = nil
            return
        }
        if let asIgr = igr?.asInteractionGestureRecognizer() {
            td.interactionGestureRecoginer = asIgr
        } else {
            fatalError("必须是UIPanGestureRecognizer或其子类:\(#function)")
        }
    }
     
    func configDismissalInteractionGestureRecoginzer(_ igr: Interactionable?) {
        guard let td = self.transitioningDelegate as? YLTransitionDelegate else {
            return
        }
        if igr == nil {
            td.interactionGestureRecoginer = nil
            return
        }
        if let asIgr = igr?.asInteractionGestureRecognizer() {
            td.interactionGestureRecoginer = asIgr
        } else {
            fatalError("必须是UIPanGestureRecognizer或其子类:\(#function)")
        }
    }
   
}

extension UIPanGestureRecognizer {
    var stateIsInvalid: Bool {
        return (state == .ended || state == .cancelled || state == .failed)
    }
}
