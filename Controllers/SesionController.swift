//
//  SesionController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/26/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class SesionController: UIViewController, UITextFieldDelegate {

    let mensajeConexion : String = "Verifica tu conexión a internet"
    
    let mensajeEmail : String = "Se debe indicar un correo electrónico válido."
    
    let mensajeVacio : String = "Los campos no pueden ir vacíos."
    
    let titulo : String = "CEPCM"
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBAction func lanzarRecuperacion() {
        
        print("---> Evento lanzar recuperacion")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecuperarController") as? RecuperarController {
            
             self.present(viewController, animated: true, completion: nil)
            //self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @IBAction func lanzarSesion() {
        
        print("---> Evento iniciar sesion")
        
        if (self.txtCorreo.text?.isEmpty)! || (self.txtPassword.text?.isEmpty)! {
            
            presentarAlerta(mensaje: mensajeVacio)
            
        } else if Utilerias.validarEmail(email: (self.txtCorreo.text)!) == false {
            
            presentarAlerta(mensaje: self.mensajeEmail)
            
        } else {
            
            procesarSesion(email: self.txtCorreo.text!, password: self.txtPassword.text!)
            
        }
        
    }
    
    @IBAction func lanzarCancelacion() {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerLogin") as? ViewController {
            
             self.present(viewController, animated: true, completion: nil)
             //self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func procesarSesion(email : String, password : String) -> Void {
        
        print("---> Procesando sesion")
        
        //Guarda la Sesion de la persona logueada
        
        LoadingController.stop()
       
        Session.shared.user?.idUsuario = 123
        Session.shared.user?.nombres = "Juan Carlos"
        Session.shared.user?.apaterno = "Cas"
        Session.shared.user?.amaterno = "Mar"
        Session.shared.user?.email = "mail@mail.com"
        Session.shared.user?.firstLoad = nil
   
       
        //TODO: Mandar a registrar el device al back
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.checkLogin()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuracion para el teclado
        txtCorreo.delegate = self
        txtPassword.delegate = self
        
        txtCorreo.text = "mail@mail.com"
        txtPassword.text = "123456"
      
    }
    
    //Configuracion para el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Configuracion para el teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
