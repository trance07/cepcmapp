//
//  AlertCEPCMController.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class AlertCEPCMController: UIViewController {
    
    var itmTitle: String?
    var alertStyle: UIAlertControllerStyle?
    var itmMessage: String?
    let buttonsStack = UIStackView()
    let bottomStack = UIStackView()
    let viewBottom = UIView()
    let view4 = UIView()
    var autodissmiss = true
    var orientation: ForceStyle? = .horizontal
    
    enum ForceStyle: Int {
        case none
        case horizontal
        case vertical
    }
    
    convenience init() {
        self.init(title: "Title", message: "Message", preferredStyle: .alert)
    }
    
    init(title: String? = nil, message: String? = nil, preferredStyle: UIAlertControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        self.itmTitle = title
        self.itmMessage = message
        self.alertStyle = preferredStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //self.modalTransitionStyle = .crossDissolve
        
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.backgroundColor = .white
        viewBottom.layer.cornerRadius = 10
        
        viewBottom.layer.shadowColor = UIColor.black.cgColor
        viewBottom.layer.shadowOpacity = 1.0;
        viewBottom.layer.shadowOffset = .zero;
        viewBottom.layer.shadowRadius = 10.0
        
        if alertStyle == UIAlertControllerStyle.actionSheet {
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(dissmiss))
            self.view.addGestureRecognizer(tap1)
        }
        
        self.view.addSubview(viewBottom)
        viewBottom.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false;
        mainStack.axis = .vertical;
        mainStack.distribution = .fill;
        mainStack.alignment = .fill;
        mainStack.spacing = 0;
        viewBottom.addSubview(mainStack)
        mainStack.leadingAnchor.constraint(equalTo: viewBottom.leadingAnchor, constant: 0).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: viewBottom.trailingAnchor, constant: 0).isActive = true
        mainStack.topAnchor.constraint(equalTo: viewBottom.topAnchor, constant: 0).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: viewBottom.bottomAnchor, constant: 0).isActive = true
        
        if itmTitle != nil {
            let topPad = UIView()
            topPad.translatesAutoresizingMaskIntoConstraints = false
            topPad.backgroundColor = .clear
            mainStack.addArrangedSubview(topPad)
            topPad.heightAnchor.constraint(equalToConstant: 15).isActive = true
            
            let view1 = UIView()
            view1.translatesAutoresizingMaskIntoConstraints = false
            view1.backgroundColor = .clear
            mainStack.addArrangedSubview(view1)
            //view1.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            let midPad = UIView()
            midPad.translatesAutoresizingMaskIntoConstraints = false
            midPad.backgroundColor = .clear
            mainStack.addArrangedSubview(midPad)
            midPad.heightAnchor.constraint(equalToConstant: 15).isActive = true
            
            
            let labelTitle = UILabel()
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            labelTitle.backgroundColor = .clear
            labelTitle.textAlignment = .center
            labelTitle.numberOfLines = 0
            labelTitle.font = Fonts.ArialMT(size: 22)
            labelTitle.textColor = UIColor.vcmLightNavy
            labelTitle.text = itmTitle
            view1.addSubview(labelTitle)
            labelTitle.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 5).isActive = true
            labelTitle.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -5).isActive = true
            labelTitle.topAnchor.constraint(equalTo: view1.topAnchor, constant: 10).isActive = true
            labelTitle.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: 0).isActive = true
            
            
        }
        if itmMessage != nil {
            let view2 = UIView()
            view2.translatesAutoresizingMaskIntoConstraints = false
            view2.backgroundColor = .clear
            mainStack.addArrangedSubview(view2)
            
            let btmPad = UIView()
            btmPad.translatesAutoresizingMaskIntoConstraints = false
            btmPad.backgroundColor = .clear
            mainStack.addArrangedSubview(btmPad)
            btmPad.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            
            //labelTitle.sizeToFit()
            let labelMessage = UILabel()
            labelMessage.translatesAutoresizingMaskIntoConstraints = false
            labelMessage.backgroundColor = .clear
            labelMessage.textAlignment = .center
            labelMessage.numberOfLines = 0
            labelMessage.font = Fonts.ArialMT(size: 12)
            labelMessage.textColor = UIColor.vcmBlack
            labelMessage.text = itmMessage
            view2.addSubview(labelMessage)
            labelMessage.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 20).isActive = true
            labelMessage.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -20).isActive = true
            labelMessage.topAnchor.constraint(equalTo: view2.topAnchor, constant: 10).isActive = true
            labelMessage.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -10).isActive = true
            
            let attributedString = NSMutableAttributedString.init(string: labelMessage.text!)
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 10
            paragraphStyle.alignment = .center
            //TODO Resolver bug
            /*attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, (labelMessage.text?.characters.count)!))*/
            labelMessage.attributedText = attributedString;
            
        }
        
        
        
        
        let view3 = UIView()
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.backgroundColor = .clear
        mainStack.addArrangedSubview(view3)
        
        
        
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false;
        buttonsStack.axis = .horizontal;
        buttonsStack.distribution = .fillEqually;
        buttonsStack.alignment = .fill;
        buttonsStack.spacing = 0;
        view3.addSubview(buttonsStack)
        buttonsStack.leadingAnchor.constraint(equalTo: view3.leadingAnchor, constant: 0).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: view3.trailingAnchor, constant: 0).isActive = true
        buttonsStack.topAnchor.constraint(equalTo: view3.topAnchor, constant: 0).isActive = true
        buttonsStack.bottomAnchor.constraint(equalTo: view3.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    @objc func dissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addAction(title:String, style:UIAlertActionStyle, alignment: NSTextAlignment? = nil, handler: (()->())?) {
        
        let button = UIButton()
 
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle(title, for: .normal)
        button.contentHorizontalAlignment = .center
        if alertStyle == UIAlertControllerStyle.alert {
            button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        }else{
            button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 5, right: 10)
        }
        
        if alignment == NSTextAlignment.left {
            button.contentHorizontalAlignment = .left
        }
        if alignment == NSTextAlignment.right {
            button.contentHorizontalAlignment = .right
        }
        
        buttonsStack.addArrangedSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        if style == .default {
            button.tag = 1001

        }else{
            button.tag = 1002
  
        }
        
        button.add(for: .touchUpInside, {
            if self.autodissmiss{
                self.dissmiss()
            }
            handler?()
        })
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        let width = viewBottom.frame.size.width
        
        if orientation == .horizontal {
            buttonsStack.axis = .horizontal
        }else if orientation == .vertical{
            buttonsStack.axis = .vertical
        }
        if buttonsStack.arrangedSubviews.count >= 3{
            buttonsStack.axis = .vertical
        }
        
        
        if buttonsStack.arrangedSubviews.count == 1 {
            let btnMain = buttonsStack.arrangedSubviews[0] as! UIButton
            if btnMain.tag == 1001 {
                btnMain.backgroundColor = Colors.brightOrange()
                btnMain.titleLabel?.font = Fonts.ArialMT(size: 17)
                btnMain.setTitleColor(.white, for: .normal)
            }else{
                btnMain.backgroundColor = .white
                btnMain.titleLabel?.font = Fonts.ArialMT(size: 17)
                btnMain.setTitleColor(Colors.darkColor(), for: .normal)
            }
            let path = UIBezierPath(roundedRect:CGRect.init(x: 0, y: 0, width: width, height: 50),
                                    byRoundingCorners:[.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            btnMain.layer.mask = maskLayer
        }
        
        if buttonsStack.arrangedSubviews.count == 2 {
            let btnMain = buttonsStack.arrangedSubviews[0] as! UIButton
            if btnMain.tag == 1001 {
                btnMain.backgroundColor = Colors.brightOrange()
                btnMain.titleLabel?.font = Fonts.ArialMT(size: 17)
                btnMain.setTitleColor(.white, for: .normal)
            }else{
                btnMain.backgroundColor = .white
                btnMain.titleLabel?.font = Fonts.ArialMT(size: 17)
                btnMain.setTitleColor(Colors.darkColor(), for: .normal)
            }
            
            if orientation == .horizontal {
                let path = UIBezierPath(roundedRect:CGRect.init(x: 0, y: 0, width: width/2, height: 50),
                                        byRoundingCorners:[.bottomLeft],
                                        cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer = CAShapeLayer()
                maskLayer.path = path.cgPath
                btnMain.layer.mask = maskLayer
            }
            
            let btnCancel = buttonsStack.arrangedSubviews[1] as! UIButton
            if btnCancel.tag == 1001 {
                btnCancel.backgroundColor = Colors.brightOrange()
                btnCancel.titleLabel?.font = Fonts.ArialMT(size: 17)
                btnCancel.setTitleColor(.white, for: .normal)
            }else{
                btnCancel.backgroundColor = .white
                btnCancel.titleLabel?.font = Fonts.ArialMT(size: 17)
                btnCancel.setTitleColor(Colors.darkColor(), for: .normal)
            }
            
            if orientation == .horizontal {
                let path2 = UIBezierPath(roundedRect:CGRect.init(x: 0, y: 0, width: width/2, height: 50),
                                         byRoundingCorners:[.bottomRight],
                                         cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer2 = CAShapeLayer()
                maskLayer2.path = path2.cgPath
                btnCancel.layer.mask = maskLayer2
            }
            else if orientation == .vertical{
                let path2 = UIBezierPath(roundedRect:CGRect.init(x: 0, y: 0, width: width, height: 50),
                                         byRoundingCorners:[.bottomLeft,.bottomRight],
                                         cornerRadii: CGSize(width: 10, height: 10))
                let maskLayer2 = CAShapeLayer()
                maskLayer2.path = path2.cgPath
                btnCancel.layer.mask = maskLayer2
            }
            
        }
        
        if buttonsStack.arrangedSubviews.count >= 3 {
            for btn in buttonsStack.arrangedSubviews{
                let useBtn = btn as! UIButton
                if useBtn.tag == 1001 {
                    useBtn.backgroundColor = Colors.brightOrange()
                    useBtn.titleLabel?.font = Fonts.ArialMT(size: 17)
                    useBtn.setTitleColor(.white, for: .normal)
                }else{
                    useBtn.backgroundColor = .white
                    useBtn.titleLabel?.font = Fonts.ArialMT(size: 17)
                    useBtn.setTitleColor(Colors.darkColor(), for: .normal)
                }
            }
            let btnMain = buttonsStack.arrangedSubviews[buttonsStack.subviews.count-1] as! UIButton
            let path = UIBezierPath(roundedRect:CGRect.init(x: 0, y: 0, width: width, height: 50),
                                    byRoundingCorners:[.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            btnMain.layer.mask = maskLayer
            
            
        }
        
        if alertStyle == UIAlertControllerStyle.actionSheet {
            viewBottom.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-20).isActive = true
            viewBottom.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        }else{
            viewBottom.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            viewBottom.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func add (for controlEvents: UIControlEvents, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
