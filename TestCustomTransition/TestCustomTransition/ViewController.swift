//
//  ViewController.swift
//  TestCustomTransition
//
//  Created by apple on 2021/1/6.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var trasitionDelegate = SwipeTranstionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        debugPrint(self,#function)
    }
    
    func setupUI() {
        let btn = UIButton()
        btn.setTitle("swipe present", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 38.0)
        btn.addTarget(self, action: #selector(swipeBtnTouched(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupAction()  {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleScreenEdgePanGestureRecognize(_:)))
        //gesture.edges = .right
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func handleScreenEdgePanGestureRecognize(_ sender:UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .began {
            let dismissVC = DissmissViewController()
            self.preparePresentTransition(for: dismissVC, transitionDelegateCreator: {
                  // return YLTransitionDelegate()
                return SwipeTranstionDelegate()
               //return HalfTransitionDelegate()
            })
            self.configPresentationInteractionGestureRecoginzer(sender)
            present(dismissVC, animated: true, completion: nil)
        } else if sender.stateIsInvalid {
            self.configPresentationInteractionGestureRecoginzer(nil)
        }
    }
    
    
    @objc func swipeBtnTouched(_ sender: Any) {
        let dismissVC = DissmissViewController()
        self.preparePresentTransition(for: dismissVC, transitionDelegateCreator: {
            // return YLTransitionDelegate()
            //  return SwipeTranstionDelegate()
            return HalfTransitionDelegate()
        })
        present(dismissVC, animated: true, completion: nil)
    }
}

