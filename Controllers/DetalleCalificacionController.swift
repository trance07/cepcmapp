//
//  DetalleCalificacionController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 10/22/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class DetalleCalificacionController: UIViewController {

    let titulo : String = "CEPCM"
    
    var indice : Int?
    
    let detalleService : DetalleCalificacionesService = DetalleCalificacionesService()
    
    @IBOutlet weak var viewCalificacion: UIView!
    
    @IBOutlet weak var viewAsistencia: UIView!
    
    @IBOutlet weak var viewClases: UIView!
    
    @IBOutlet weak var viewProfesor: UIView!
    
    @IBOutlet weak var calificacion: UILabel!
    
    @IBOutlet weak var numSesiones: UILabel!
    
    @IBOutlet weak var diasClase: UILabel!
    
    @IBOutlet weak var inicioMateria: UILabel!
    
    @IBOutlet weak var terminoMateria: UILabel!
    
    @IBOutlet weak var inicio: UILabel!
    
    @IBOutlet weak var termino: UILabel!
    
    @IBOutlet weak var profesor: UILabel!
    
    func crearEstiloViews() {
        
        self.viewCalificacion.layer.borderWidth = 1
        self.viewCalificacion.layer.shadowColor = UIColor.black.cgColor
        self.viewCalificacion.layer.shadowOpacity = 0.5
        self.viewCalificacion.layer.shadowRadius = 1
        
        self.viewAsistencia.layer.borderWidth = 1
        self.viewAsistencia.layer.shadowColor = UIColor.black.cgColor
        self.viewAsistencia.layer.shadowOpacity = 0.5
        self.viewAsistencia.layer.shadowRadius = 1
        
        self.viewClases.layer.borderWidth = 1
        self.viewClases.layer.shadowColor = UIColor.black.cgColor
        self.viewClases.layer.shadowOpacity = 0.5
        self.viewClases.layer.shadowRadius = 1
        
        self.viewProfesor.layer.borderWidth = 1
        self.viewProfesor.layer.shadowColor = UIColor.black.cgColor
        self.viewProfesor.layer.shadowOpacity = 0.5
        self.viewProfesor.layer.shadowRadius = 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("---> El indice en detalle es: \(self.indice!)")
        
        self.crearEstiloViews()
        
        let lista = Session.shared.listaCalificaciones!.listaCalificaciones!
        
        self.calificacion.text = lista[self.indice!].str_calificacion
        
        print("---> El elemento de la list con indice es \(lista[self.indice!])")
        
        self.detalleService.obtenerDetalleCalificacion(idMateria: lista[self.indice!].materia?.id) { (codigo, respuesta) in
            
            if codigo == true {
                
                let detalle = respuesta as! CalificacionDetalleBean
                
                print("---> El detalle es: \(detalle)")
                
                let numSesionesString = detalle.conceptos_asistencias![0].numero
                self.numSesiones.text = String(numSesionesString)
                
                self.diasClase.text = detalle.sesiones
                self.inicioMateria.text = detalle.fecha_inicio
                self.terminoMateria.text = detalle.fecha_termino
                self.inicio.text = detalle.hora_inicio
                self.termino.text = detalle.hora_termino
                self.profesor.text = "\(detalle.docente!.nombres) \(detalle.docente!.apaterno) \(detalle.docente!.amaterno)"
                
            } else {
                
                self.presentarAlerta(mensaje: respuesta as! String)
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}
