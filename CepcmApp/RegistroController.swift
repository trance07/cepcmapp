//
//  RegistroController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 7/22/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class RegistroController: UIViewController {

    let mensajeVacio : String = "Los campos no pueden ir vacíos."
    
    let mensajePassword : String = "Las contraseñas no coinciden"
    
    let titulo : String = "CEPCM"
    
    @IBOutlet weak var matricula: UITextField!
    
    @IBOutlet weak var curp: UITextField!
    
    @IBOutlet weak var correo: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validarUsuario() {
        print("---> Evento de validar datos")
        
        if (self.matricula.text?.isEmpty)! || (self.curp.text?.isEmpty)! || (self.correo.text?.isEmpty)! || (self.password.text?.isEmpty)! || (self.confPassword.text?.isEmpty)! {
            
            print("---> Alguno de los campos esta vacio")
            
            presentarAlerta(mensaje: self.mensajeVacio)
            
        } else {
            
            print("---> Los campos No estan vacios, se puede enviar registro")
            var matriculaTemp = self.matricula.text
            var curpTemp = self.curp.text
            
        }
        
    }
    
    func presentarAlerta( mensaje : String) -> Void {
     
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    @IBAction func regresar() {
        
        dismiss(animated: true, completion: nil)
    }

    
}
