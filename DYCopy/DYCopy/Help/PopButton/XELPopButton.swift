//
//  XELPopButton.swift
//  PopButton_Swift
//
//  Created by Tronsis－mac on 17/8/17.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

import UIKit

let kScreenWidth: CGFloat   = UIScreen.main.bounds.width
let kScreenHeight: CGFloat  = UIScreen.main.bounds.height
let kButtonHeight: CGFloat  = 50.0
let kButtonWidth: CGFloat   = 150.0
let kButtonMargin: CGFloat  = 15.0
let kRightMargin: CGFloat   = 30.0


class XELPopButton: UIButton {
    
    var titlesArray = Array<String>.init()
    var imagesArray: Array<UIImage>?
    
    fileprivate var completion: ((NSInteger) -> Void)?
    fileprivate var dimmingView: UIView?
    fileprivate var buttonsArray = Array<UIButton>.init()
    
    private var bottom: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        bottom = kScreenHeight - frame.maxY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension XELPopButton {
    func show(completion: @escaping (_ index: NSInteger) -> Void) {
        dimmingView = UIView.init(frame: UIScreen.main.bounds.offsetBy(dx: 0, dy: 0))
        dimmingView?.alpha = 0
        dimmingView?.backgroundColor = UIColor.black
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismiss))
        dimmingView?.isUserInteractionEnabled = true
        dimmingView?.addGestureRecognizer(tap)
        UIApplication.shared.keyWindow?.addSubview(dimmingView!)
        self.isHidden = true
        for i in 0..<self.titlesArray.count {
            let button = UIButton.init(type: .custom)
            button.tag = i
            button.frame = CGRect.init(x: self.frame.maxX - kButtonWidth, y: self.frame.minY, width: kButtonWidth, height: kButtonHeight)
            button.setTitle(titlesArray[i], for: .normal)
            if let imagesArray = imagesArray {
                button.setImage(imagesArray[i], for: .normal)
            }
            button.layoutButton(with: .right, imageTitleSpace: 5)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(doSomething(_:)), for: .touchUpInside)
            if let window = UIApplication.shared.keyWindow {
                window.addSubview(button)
            }
            buttonsArray.append(button)
            self.completion = completion
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                button.frame = CGRect.init(x: self.frame.maxX - kButtonWidth, y: self.frame.maxY - CGFloat(i + 1) * (kButtonHeight + kButtonMargin), width: kButtonWidth, height: kButtonHeight)
                self.dimmingView?.alpha = 0.6
            }, completion: { (finished) in
                
            })
        }
    }
}

extension XELPopButton {
    @objc fileprivate func dismiss() -> Void {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            for button in self.buttonsArray {
                button.frame = CGRect.init(x: self.frame.maxX - kButtonWidth, y: self.frame.minY, width: kButtonWidth, height: kButtonHeight)
            }
            self.dimmingView?.alpha = 0
        }) { (finished) in
            for button in self.buttonsArray {
                button.removeFromSuperview()
            }
            self.dimmingView?.removeFromSuperview()
            self.isHidden = false
        }
    }
    
    @objc fileprivate func doSomething(_ btn: UIButton)-> Void {
        if let completion = self.completion {
            completion(btn.tag)
        }
        dismiss()
    }
}
