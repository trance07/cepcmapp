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
   
    var materias = [MateriaCarreraBean]()
    
    var userDefaults = UserDefaults.standard
    
    //var holder: UIView?

    let materiasService : MateriasService = MateriasService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inicializaNavigationBar()
        self.inicializaTableView()
       
        
    }
    
    func inicializaNavigationBar(){
 
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Materias"
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
        
        self.tblMaterias.dataSource = self;
        self.tblMaterias.delegate = self;
        self.tblMaterias.estimatedRowHeight = 144
        self.tblMaterias.rowHeight = UITableViewAutomaticDimension
        
        //let nib = UINib(nibName: "viewTblCellMaterias", bundle: nil)
       // self.tblMaterias.register(nib, forCellReuseIdentifier: "customCellMaterias")
        
        //Cargando las materias
        self.materiasService.obtenerMaterias() { (resultado, response) in
            
            if resultado == true {
                
                self.materias = response as! [MateriaCarreraBean]
                
                self.tblMaterias.reloadData()
                
            } else {
                
                self.presentarAlerta(mensaje: response as! String )
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*let cell: CustomTblViewCellMaterias = (self.tblMaterias.dequeueReusableCell(withIdentifier: "customCellMaterias") as? CustomTblViewCellMaterias)!
        
       
        let recipe = materias[indexPath.item]
        
        cell.lblMateria?.text = recipe
        cell.lblMateria?.numberOfLines = 0
        
        return cell;*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MateriaCell") as! MateriaCell
        //cell.setCalificacion(calificacion: calificaciones[indexPath.item].str_calificacion!)
        cell.setClave(clave: (materias[indexPath.item].clave)!)
        //cell.setFecha(fecha: calificaciones[indexPath.item].fecha!)
        cell.setMateria(materia: (materias[indexPath.item].descripcion)!)
        cell.lblMateria?.numberOfLines = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CalificacionController.lanzarDetalle))
        cell.addGestureRecognizer(tapGesture)
        
        return cell;
       
        
    }
    
    func presentarAlerta( mensaje : String) -> Void {
        
        print("---> Generando mensaje de alerta")
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func back(){
        
        self.navigationController?.popViewController(animated: true)
        
    }

}
