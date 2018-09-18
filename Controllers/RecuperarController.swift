//
//  RecuperarController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 9/2/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class RecuperarController: UIViewController {
    
    let mensajeVacio : String = "El correo electrónico no puede estar vacio."
    
    let mensajeEmail : String = "Se debe indicar un correo electrónico válido."
    
    let mensajeConexion : String = "Verifica tu conexión a internet"
    
    let titulo : String = "CEPCM"
    
    @IBOutlet weak var correo: UITextField!
    
    @IBAction func lanzarCancelar() {
        
        print("---> Lanzar cancelacion")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SesionController") as? SesionController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }

        
    }
    
    @IBAction func lanzarAceptar() {
        
        print("---> Lanzar aceptar")
        
        if (self.correo.text?.isEmpty)! {
            
            presentarAlerta(mensaje: self.mensajeVacio)
            
        } else if Utilerias.validarEmail(email: (self.correo.text)!) == false {
            
            presentarAlerta(mensaje: self.mensajeEmail)
            
        } else {
            
            enviarCorreo(email: self.correo.text!)
            
        }
        
    }
    
    func enviarCorreo(email : String) -> Void {
        
        if ConnectionService.isConnectedToNetwork() {
        
            /// se debe lanzar proceso de recuperacion de password
            
        } else {
            
            presentarAlerta(mensaje: self.mensajeConexion)

            
        }
        
    }
    
    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
