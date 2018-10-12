//
//  RegistroController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 7/22/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class RegistroController: UIViewController, UITextFieldDelegate {

    let length_min_pass : Int = 6
    
    let mensajeVacio : String = "Los campos no pueden ir vacíos."
    
    let mensajePassword : String = "Las contraseñas no coinciden"
    
    let mensajeEmail : String = "Se debe indicar un correo electrónico válido."
    
    let mensajeMinPassword : String = "La contraseña debe contener al menos 6 caractéres."
    
    let mensajeDiffPassword : String = "Las contraseñas no coinciden."
    
    let mensajeConexion : String = "Verifica tu conexión a internet"
    
    let mensajeErrorRegistro : String = "Ocurrió un error en el registro, intente más tarde."
    
    let mensajeVerificacion : String = "Un mensaje será enviado a la dirección de correo electrónico especificada. Este correo contiene un enlace para completar el proceso de verficación."
    
    let titulo : String = "CEPCM"
    
    var matriculaText : String? = ""
    
    var curpText : String? = ""
    
    let id_tipo_usuario_alumno : Int = 1
    
    let id_aplicaion : Int = 1
    
    @IBOutlet weak var txtMatricula: UITextField!
    
    @IBOutlet weak var txtCurp: UITextField!
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfPassword: UITextField!
    
    var firebaseService : FirebaseService = FirebaseService()
    
    let restService : RestService = RestService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtMatricula.text = matriculaText
        self.txtCurp.text = curpText
        
        txtMatricula.delegate = self
        txtCurp.delegate = self
        txtCorreo.delegate = self
        txtPassword.delegate = self
        txtConfPassword.delegate = self
        
        self.txtCorreo.text = "iscjccm@gmail.com"
        self.txtPassword.text = "123456"
        self.txtConfPassword.text = "123456"
        
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
    
    @IBAction func validarUsuario() {
        print("---> Evento de validar datos")
        
        if (self.txtMatricula.text?.isEmpty)! || (self.txtCurp.text?.isEmpty)! || (self.txtCorreo.text?.isEmpty)! || (self.txtPassword.text?.isEmpty)! || (self.txtConfPassword.text?.isEmpty)! {
            
            print("---> Alguno de los campos esta vacio")
            
            presentarAlerta(mensaje: self.mensajeVacio)
            
        } else if Utilerias.validarEmail(email: (self.txtCorreo.text)!) == false {
            
            presentarAlerta(mensaje: self.mensajeEmail)
            
        } else if (self.txtPassword.text?.count)! < self.length_min_pass {
            
            presentarAlerta(mensaje: self.mensajeMinPassword)
            
        } else if (self.txtPassword.text)! != (self.txtConfPassword.text)! {
            
            presentarAlerta(mensaje: self.mensajeDiffPassword)
            
        } else {
            
            print("---> Los campos estan validados, se puede enviar registro")
            procesarRegistro(email: self.txtCorreo.text!, password: self.txtPassword.text!)
            
        }
        
    }
    
    func procesarRegistro(email : String, password : String) -> Void {
        
        print("---> Procesando registro de cuenta")
      
           self.firebaseService.crearCuentaFirebase(email: email, password: password) { (resultado, response) in
          
                if resultado == true {
                    
                    Session.shared.user?.email = email
                    
                    var request = RequestPersistirIdFirebaseBean()
                    request.correo = email
                    request.id_firebase = response as? String
                    request.id_aplicacion = self.id_aplicaion
                    request.id_tipo_usuario = self.id_tipo_usuario_alumno
                    print(Session.shared.user?.idUsuario)
                    request.id_usuario = Session.shared.user?.idUsuario
                    
                   // self.restService.persistirIdFirebaseEnBackend(request: request) { (resultado, response) in
                    
                      //  if resultado == true {
                            
                          /*  self.firebaseService.enviarEmailVerificacion(email: email) { (resultado, response) in
                                
                                if resultado == true {
                                    
                                     self.presentarAlerta(mensaje: response as! String )
                                    
                                }else{
                                    
                                     self.presentarAlerta(mensaje: response as! String )
                                }
                                
                            }//fin enviarEmailVerificacion*/
                            
                            /*if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistroController") as? RegistroController {
                                
                                self.presentarAlerta(mensaje: self.mensajeVerificacion)
                                
                            }*/
                    
                            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistroController") as? RegistroController {
                                
                                  self.present(viewController, animated: true, completion: nil)
                                
                            }
                        
                      
                            
                        } else {
                            
                            self.presentarAlerta(mensaje: response as! String )
                            
                        }
                   // }// fin persistirIdFirebaseEnBackend
                    
            
                    
                    
                /*} else {
                    
                    self.presentarAlerta(mensaje: response as! String )
                    
                }*/
            
            }// fin crearCuentaFirebase
            
        
        
    }
    
    func presentarAlerta( mensaje : String) -> Void {
     
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    @IBAction func regresar() {
       
        self.dismiss(animated: true, completion: nil)
      
    }

    
}
