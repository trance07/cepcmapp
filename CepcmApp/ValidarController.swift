//
//  ValidarController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class ValidarController: UIViewController ,UITextFieldDelegate{

   
    let titulo : String = "CEPCM"
    
    let mensajeVacio : String = "Los campos no pueden ir vacíos."
    
    let mensajeConexion : String = "Verifica tu conexión a internet"
    
    let mensajeIncorrecto : String = "La matricula y/o el curp son incorrectos, favor de verificar"
    
    let validarService : ValidarService = ValidarService()
    
    @IBOutlet weak var txtMatricula: UITextField!
    
    @IBOutlet weak var txtCurp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuracion para el teclado
        txtMatricula.delegate = self
        txtCurp.delegate = self
        
        txtMatricula.text = "123"
        txtCurp.text = "123"

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
    

    
    @IBAction func validarDatos() {
        print("validando datos...")
        
        if (self.txtMatricula.text?.isEmpty)! || (self.txtCurp.text?.isEmpty)! {
            
            self.presentarAlerta(mensaje: self.mensajeVacio)
            
        } else {
            
            print("Entrando en el else")
            var request = RequestUsuario()
            request.matricula = self.txtMatricula.text
            request.curp = self.txtCurp.text?.uppercased()
            
            if ConnectionService.isConnectedToNetwork() {
            
                self.validarService.validarDatos(request: request) { (resultado) in
                    
                    if resultado == true {
                        
                        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistroController") as? RegistroController {
                            
                            viewController.matriculaText = self.txtMatricula?.text
                            viewController.curpText = self.txtCurp?.text
                            
                           // self.navigationController?.pushViewController(viewController, animated: true)
                            
                              self.present(viewController, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        
                        self.presentarAlerta(mensaje: self.mensajeIncorrecto)
                        
                    }
                    
                }
                
            } else {
                
                self.presentarAlerta(mensaje: mensajeConexion)
                
            }
            
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
