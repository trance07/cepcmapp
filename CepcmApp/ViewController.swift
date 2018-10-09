//
//  ViewController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 7/20/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func lanzarValidacion() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ValidarController") as? ValidarController {
            
            //self.navigationController?.pushViewController(viewController, animated: true)
            
              self.present(viewController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func lanzarSesion() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SesionController") as? SesionController {
            
            self.present(viewController, animated: true, completion: nil)
            
        }
        
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
      
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

   
    
}

