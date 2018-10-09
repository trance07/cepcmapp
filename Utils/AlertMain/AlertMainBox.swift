//
//  AlertMainBox.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class AlertMainBox: UIView {
    
    let alertTitle = UILabel()
    let alertMessage = UILabel()
    let buttonCancelar = UIButton()
    let buttonAceptar = UIButton()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    required init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    // MARK: Build View hierarchy
    func addSubviews(){
        // add subviews
        
        self.backgroundColor = .clear
        
        let paddingView = UIView()
        paddingView.translatesAutoresizingMaskIntoConstraints = false;
        paddingView.backgroundColor = .white
        paddingView.layer.shadowColor = UIColor.black.cgColor
        paddingView.layer.cornerRadius = 5
        paddingView.layer.shadowOpacity = 1.0;
        paddingView.layer.shadowOffset = .zero;
        paddingView.layer.shadowRadius = 5.0
        self.addSubview(paddingView)
        paddingView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        paddingView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        paddingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:18).isActive = true
        paddingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-18).isActive = true
        paddingView.heightAnchor.constraint(equalToConstant: 217).isActive = true
        
        alertTitle.translatesAutoresizingMaskIntoConstraints = false
        alertTitle.text = "Asociación de póliza"
        alertTitle.textAlignment = .center
        alertTitle.adjustsFontSizeToFitWidth = true
        alertTitle.font = Fonts.AvenirMedium(size: 18.0)
        alertTitle.textColor = Colors.darkColor()
        alertTitle.isUserInteractionEnabled = false
        alertTitle.backgroundColor = .clear
        paddingView.addSubview(alertTitle)
        alertTitle.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor, constant: 33).isActive = true
        alertTitle.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor, constant: -33).isActive = true
        alertTitle.topAnchor.constraint(equalTo: paddingView.topAnchor, constant: 20).isActive = true
        alertTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        alertMessage.translatesAutoresizingMaskIntoConstraints = false
        alertMessage.text = "prueba de subview"
        alertMessage.textAlignment = .center
        alertMessage.adjustsFontSizeToFitWidth = true
        alertMessage.numberOfLines = 0
        alertMessage.font = Fonts.AvenirMedium(size: 15.0)
        alertMessage.textColor = Colors.steelGrey()
        alertMessage.isUserInteractionEnabled = false
        alertMessage.backgroundColor = .clear
        paddingView.addSubview(alertMessage)
        alertMessage.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor, constant: 33).isActive = true
        alertMessage.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor, constant: -33).isActive = true
        alertMessage.topAnchor.constraint(equalTo: paddingView.topAnchor, constant: 55).isActive = true
        alertMessage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        let stackBtm = UIStackView()
        stackBtm.translatesAutoresizingMaskIntoConstraints = false;
        stackBtm.axis = .horizontal;
        stackBtm.distribution = .fillEqually;
        stackBtm.alignment = .fill;
        stackBtm.spacing = 0;
        paddingView.addSubview(stackBtm)
        stackBtm.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor, constant:0).isActive = true
        stackBtm.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor, constant:0).isActive = true
        stackBtm.bottomAnchor.constraint(equalTo: paddingView.bottomAnchor, constant:0).isActive = true
        stackBtm.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        buttonAceptar.translatesAutoresizingMaskIntoConstraints = false
        buttonAceptar.backgroundColor = Colors.brightOrange()
        buttonAceptar.setTitle("Aceptar", for: .normal)
        buttonAceptar.titleLabel?.font = Fonts.AvenirBook(size: 17.0)
        buttonAceptar.setTitleColor(.white, for: .normal)
        stackBtm.addArrangedSubview(buttonAceptar)
        
        
        
        
    }
    
    
    
    
    override func layoutSubviews() {
        
        let path = UIBezierPath(roundedRect:buttonAceptar.bounds,
                                byRoundingCorners:[.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        buttonAceptar.layer.mask = maskLayer
        
        
        let path2 = UIBezierPath(roundedRect:buttonCancelar.bounds,
                                 byRoundingCorners:[.bottomLeft],
                                 cornerRadii: CGSize(width: 5, height:  5))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = path2.cgPath
        buttonCancelar.layer.mask = maskLayer2
        
    }
    
    func setupLayout(){
        // Autolayout
        
    }
    
}
