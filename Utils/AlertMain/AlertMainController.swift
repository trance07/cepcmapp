//
//  AlertMainController.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class AlertMainController: UIViewController {
    
    let alertMainBox = AlertMainBox()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Main Alert"
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        alertMainBox.translatesAutoresizingMaskIntoConstraints = false
        self.view .addSubview(alertMainBox);
        alertMainBox.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:0).isActive = true
        alertMainBox.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0).isActive = true
        alertMainBox.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0).isActive = true
        alertMainBox.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0).isActive = true
     
        alertMainBox.buttonAceptar.addTarget(self, action: #selector(aceptar(sender:)), for: .touchUpInside)
        
        
    }
    
    
    
    
    @objc func aceptar(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}
