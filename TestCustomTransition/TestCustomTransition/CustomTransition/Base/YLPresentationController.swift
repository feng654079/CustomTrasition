//
//  DefaultPresentationController.swift
//  CustomTrastionDemo
//
//  Created by Ifeng科技 on 2020/6/9.
//  Copyright © 2020 Ifeng科技. All rights reserved.
//

import Foundation
import UIKit

protocol PanDismissProgressHandler {
    ///pan手势结束时,触发dismiss的进度阈值
    var dismissTriggerProgress:CGFloat { get }
    
    ///pan手势移动时调用,获取当前dismiss进度 返回值必须 0.0 ~ 1.0
    func progress(for pan:UIPanGestureRecognizer) -> CGFloat
    
    ///pan手势移动和结束时调用,调整UI元素位置
    func adjustUIState(with progress:CGFloat , animated:Bool)
}

//MARK:- DefaultPresentationController

class YLPresentationController: UIPresentationController ,PanDismissProgressHandler{
    
    lazy var isAllowTouchDismiss:Bool = true
    lazy private(set) var dimmingView: UIView? = UIView(frame: .zero)
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    deinit {
        debugPrint("DefaultPresentationController deinit")
    }
    
    var dismissTriggerProgress: CGFloat {
        return 0.3
    }
    
    func progress(for pan:UIPanGestureRecognizer) -> CGFloat {
        let translation = pan.translation(in: self.containerView).y
        let percent = max(0, translation / self.presentedViewController.view.bounds.height)
        return percent
    }
    
    func adjustUIState(with progress:CGFloat , animated:Bool) {
        guard
            let containerView = self.containerView
            else {
                return
        }
        
        let changeBlock = {
            let alphaDistance:CGFloat = 0.5
            containerView.backgroundColor = UIColor.black.withAlphaComponent((1 - progress) * alphaDistance)
        }
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                changeBlock()
            }
        } else {
            changeBlock()
        }
    }
    
    private func _addTouchDismissGestureIfNeeded() {
        if isAllowTouchDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(_touchedContainerView(tap:)))
            dimmingView!.addGestureRecognizer(tap)
        }
    }
    
    @objc private  func _touchedContainerView(tap:UITapGestureRecognizer) {
        guard
            isAllowTouchDismiss,
            let containerView = self.containerView,
            let presentedView = self.presentedView
        else { return }
        let loc = tap.location(in: containerView)
        if !presentedView.frame.contains(loc) {
            self.presentedViewController.dismiss(animated: true, completion: nil)
        }
    }
}


//MARK:- override system
extension YLPresentationController {
    //MARK: Tracking the layout progress
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }
    //MARK: Tracking the Transition Start and End
    override func presentationTransitionWillBegin() {
       // super.presentationTransitionWillBegin()
        debugPrint("presentationTransitionWillBegin")
        guard
            let containerView = self.containerView,
              let dimmingView = self.dimmingView
              else {
            return
        }
        dimmingView.frame = containerView.bounds
        //dimmingView.isOpaque = false
        dimmingView.backgroundColor = UIColor.black
        if let p = self.presentedView {
            containerView.insertSubview(dimmingView, belowSubview: p)
        }
        
        dimmingView.alpha = 0.0
        self.presentingViewController.transitionCoordinator?
            .animate(alongsideTransition: { [weak self ](context) in
               dimmingView.alpha = 0.5
            self?.presentedViewController.setNeedsStatusBarAppearanceUpdate()
            }, completion: {(context) in })
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        self._addTouchDismissGestureIfNeeded()
        if completed == false {
            self.dimmingView = nil
        }
       
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (context) in
            self?.dimmingView?.alpha = 0.0
            }, completion: { (context) in })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        
    }
    
}

//MARK:- override UIContentContainer
extension YLPresentationController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
}





