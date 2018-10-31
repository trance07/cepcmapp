//
//  CalificacionController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 9/2/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import Foundation

class CalificacionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let titulo : String = "CEPCM"
    
    var userDefaults = UserDefaults.standard
    
    var calificaciones = [CalificacionesBean]()
    
    @IBOutlet weak var califTable: UITableView!

    let calificacionService : CalificacionesService = CalificacionesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.califTable.dataSource = self
        self.califTable.delegate = self
        
        self.calificacionService.obtenerCalificacionesFirebase() { (resultado, response) in
            
            if resultado == false {
                
                print("---> No se pueden mostrar las calificaciones")
                self.presentarAlerta(mensaje: response as! String )
                
            } else {
                
                print("---> Se pueden mostrar las calificaciones")
                
                self.calificaciones =  response as! [CalificacionesBean]
                
                self.califTable.reloadData()

                
            }
            
        }
        /*
        self.calificacionService.obtenerCalificacionesBackend() { (resultado, response) in
            
            if resultado == true {
                let promedioBean = response as! PromedioBean
                
                self.calificaciones = promedioBean.calificaciones!
                
                self.califTable.reloadData()
                
            } else {
                print(".---> El resultado no es true")
            }
            
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("********* tamanio de calificaciones: \(calificaciones.count)")
        return calificaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalificacionCell") as! CalificacionCell
        cell.setCalificacion(calificacion: calificaciones[indexPath.item].str_calificacion!)
        cell.setClave(clave: (calificaciones[indexPath.item].materia?.clave)!)
        cell.setFecha(fecha: calificaciones[indexPath.item].fecha!)
        cell.setMateria(materia: (calificaciones[indexPath.item].materia?.descripcion)!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CalificacionController.lanzarDetalle))
        cell.addGestureRecognizer(tapGesture)
        
        return cell;
        
        
    }
    
    @objc func lanzarDetalle() -> Void {
        
        
        print("----> Lanzando detalle")
        
        
    }
    
    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
}
