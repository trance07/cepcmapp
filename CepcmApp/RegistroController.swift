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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtMatricula.text = matriculaText
        self.txtCurp.text = curpText
        
        txtMatricula.delegate = self
        txtCurp.delegate = self
        txtCorreo.delegate = self
        txtPassword.delegate = self
        txtConfPassword.delegate = self
        
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
        if ConnectionService.isConnectedToNetwork() {

            let resultado = self.firebaseService.crearCuentaFirebase(email: email, password: password)
            
            if resultado != "error" {
                
                var request = RequestPersistirIdFirebaseBean()
                request.correo = email
                request.id_firebase = resultado
                request.id_aplicacion = self.id_aplicaion
                request.id_tipo_usuario = self.id_tipo_usuario_alumno
                
                let restService = RestService()
                restService.persistirIdFirebaseEnBackend(request: request) { (resultado) in
                self.firebaseService.persistirDatosAlumnoFirebase()
                    
                    if resultado.respuesta != nil {
                        
                        if resultado.respuesta?.codigo == 0 {
                            
                            self.presentarAlerta(mensaje: self.mensajeVerificacion)
                            
                        } else if resultado.respuesta?.codigo == -1 {
                            
                            self.presentarAlerta(mensaje: (resultado.respuesta?.mensaje)!)
                            
                        }
                        
                    } else {
                        
                        self.presentarAlerta(mensaje: self.mensajeErrorRegistro)
                        
                    }
                    
                }
                
            } else {
                
                presentarAlerta(mensaje: self.mensajeErrorRegistro)
                
            }
            
            
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
    
    @IBAction func regresar() {
        
        dismiss(animated: true, completion: nil)
    }

    
}
