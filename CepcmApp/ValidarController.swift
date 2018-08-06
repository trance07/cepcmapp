//
//  ValidarController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class ValidarController: UIViewController {

    let titulo : String = "CEPCM"
    
    let mensajeVacio : String = "Los campos no pueden ir vacíos."
    
    @IBOutlet weak var matricula: UITextField!
    
    @IBOutlet weak var curp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validarDatos() {
        print("validando datos...")
        
        if (self.matricula.text?.isEmpty)! || (self.curp.text?.isEmpty)! {
            
            self.presentarAlerta(mensaje: self.mensajeVacio)
            
        } else {
            
            
            
        }
        
        
    }
    
    @IBAction func regresar() {
        dismiss(animated: true, completion: nil)
    }
    
    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}
