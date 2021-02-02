//
//  DissmissViewController.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/6.
//

import Foundation
import UIKit

class DissmissViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }
    
    deinit {
        debugPrint(self,#function)
    }
    
    func setupAction() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    func setupUI() {
        self.view.backgroundColor = .lightGray
        
        let btn = UIButton()
        btn.setTitle("dismiss", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        btn.addTarget(self, action: #selector(dismissTouched), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func dismissTouched(_ sender:UIButton ) {
        debugPrint(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePanGesture(_ sender:UIPanGestureRecognizer) {
        if sender.state == .began {
            self.configDismissalInteractionGestureRecoginzer(sender)
            self.dismiss(animated: true, completion: nil)
        } else if sender.stateIsInvalid {
            self.configDismissalInteractionGestureRecoginzer(nil)
        }
    }
}


extension UITapGestureRecognizer: Interactionable {}
