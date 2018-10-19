//
//  MateriaController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 9/2/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class MateriaController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
  
    let titulo : String = "CEPCM"

    @IBOutlet weak var tblMaterias: UITableView!
   
    var materias = [String]()

    let materiasService : MateriasService = MateriasService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblMaterias.dataSource = self;
        self.tblMaterias.delegate = self;
    
        //Cargando las materias
        self.materiasService.obtenerMaterias() { (resultado, response) in
            
            if resultado == true {
                
                let materiasCarrera = response as! [MateriaCarreraBean]
                
                materiasCarrera.forEach({ (materiaCarrera) in
                    self.materias.append( "\(materiaCarrera.clave!) : \(materiaCarrera.descripcion!)")
                })
                
                self.tblMaterias.reloadData()
                
            } else {
                
                self.presentarAlerta(mensaje: response as! String )
                
            }
            
        }// fin registrarDispositivo
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MateriasCell") as! MateriasCell
        cell.setMateria(materia: materias[indexPath.item])
        return cell;
       
        
    }
    
    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    

}
