//
//  SesionController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/26/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class SesionController: UIViewController {

    let mensajeConexion : String = "Verifica tu conexión a internet"
    
    let mensajeEmail : String = "Se debe indicar un correo electrónico válido."
    
    let mensajeVacio : String = "Los campos no pueden ir vacíos."
    
    let titulo : String = "CEPCM"
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var correo: UITextField!
    
    @IBAction func lanzarRecuperacion() {
        
        print("---> Evento lanzar recuperacion")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecuperarController") as? RecuperarController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @IBAction func lanzarSesion() {
        
        print("---> Evento iniciar sesion")
        
        if (self.correo.text?.isEmpty)! || (self.password.text?.isEmpty)! {
            
            presentarAlerta(mensaje: mensajeVacio)
            
        } else if Utilerias.validarEmail(email: (self.correo.text)!) == false {
            
            presentarAlerta(mensaje: self.mensajeEmail)
            
        } else {
            
            procesarSesion(email: self.correo.text!, password: self.password.text!)
            
        }
        
    }
    
    @IBAction func lanzarCancelacion() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerLogin") as? ViewController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func procesarSesion(email : String, password : String) -> Void {
        
        print("---> Procesando sesion")
        
        //if ConnectionService.isConnectedToNetwork() {
        
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrincipalController") as? PrincipalController {
                
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        /*} else {
            
            presentarAlerta(mensaje: self.mensajeConexion)
            
        }*/
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}
