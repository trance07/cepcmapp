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
    
    let validarService : ValidarService = ValidarService()
    
    @IBOutlet weak var txtMatricula: UITextField!
    
    @IBOutlet weak var txtCurp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuracion para el teclado
        txtMatricula.delegate = self
        txtCurp.delegate = self
        
        txtMatricula.text = "1033117120"
        txtCurp.text = "AORO860319MDFNBL09"

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
        print("validando cuenta del alumno...")
        
        if (self.txtMatricula.text?.isEmpty)! || (self.txtCurp.text?.isEmpty)! {
            
            self.presentarAlerta(mensaje: self.mensajeVacio)
            
        } else {
            
            var request = RequestUsuario()
            request.matricula = self.txtMatricula.text
            request.curp = self.txtCurp.text?.uppercased()
            
            self.validarService.validarDatos(request: request) { (resultado, response) in
                
                if resultado == true {
                    
                    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistroController") as? RegistroController {
                        
                        viewController.matriculaText = self.txtMatricula?.text
                        viewController.curpText = self.txtCurp?.text
                        
                        //Persistir la informacion del alumno en la sesion
                        let respuestaValidaCuentaAlumnoBean = response as! RespuestaValidaCuentaAlumnoBean
                        
                        Session.shared.user?.idUsuario = respuestaValidaCuentaAlumnoBean.alumno?.id
                        Session.shared.user?.nombres = respuestaValidaCuentaAlumnoBean.alumno?.nombres
                        Session.shared.user?.apaterno = respuestaValidaCuentaAlumnoBean.alumno?.apaterno
                        Session.shared.user?.amaterno = respuestaValidaCuentaAlumnoBean.alumno?.apaterno
                       
                        //Session.add(alumno: respuestaValidaCuentaAlumnoBean.alumno!);
                        
                        self.present(viewController, animated: true, completion: nil)
                        
                    }
                    
                } else {
                    
                    self.presentarAlerta(mensaje: response as! String )
                    
                }
                
            }// fin validarDatos
          
            
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
