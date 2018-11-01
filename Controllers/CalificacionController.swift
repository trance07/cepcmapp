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
        
        self.inicializaNavigationBar()
        self.inicializaTableView()
        
        
    }
    
    func inicializaNavigationBar(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Calificaciones"
        self.view.backgroundColor = Colors.backgroundGray()
        self.view.frame = CGRect.init(x: 0, y: 0, width:self.view.frame.width , height: self.view.frame.height-(self.navigationController?.navigationBar.frame.height)!-20)
        var frame = self.view.frame
        frame.size.width = self.view.frame.size.width
        frame.size.height = self.view.frame.height
        let imgBack = UIImage(named: "backArrow")
        let buttonBack = UIBarButtonItem(image: imgBack, style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        buttonBack.tintColor = Colors.brightCherry()
        self.navigationItem.leftBarButtonItem = buttonBack
        
    }
    
    func inicializaTableView(){
        
       
        
        
        self.califTable.dataSource = self
        self.califTable.delegate = self
        self.califTable.rowHeight = 304
        self.califTable.rowHeight = UITableViewAutomaticDimension
        
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
        cell.lblMateria?.numberOfLines = 0
        
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

    @objc func back(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
