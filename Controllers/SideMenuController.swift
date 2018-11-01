//
//  SideMenuController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/19/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import KeychainSwift

class SideMenuController: UITableViewController {
    
    let menuItems = ["Inicio","Notificaciones","Términos y Condiciones","Acerca de","Novedades","Salir"]
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "header")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        if indexPath.row == 0 {
            
            let imageName = UIImage(named: "ic_menu_info")
            cell.imageView?.image = imageName
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuController.lanzarInicio))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 1 {
            
            let imageName = UIImage(named: "not_bell")
            cell.imageView?.image = imageName
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuController.lanzarNotificaciones))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 2 {
            
            let imageName = UIImage(named: "ic_menu_share")
            cell.imageView?.image = imageName
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuController.lanzarTerminos))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 3 {
            
            let imageName = UIImage(named: "ic_menu_info")
            cell.imageView?.image = imageName
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuController.lanzarAcerca))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 4 {
            
            let imageName = UIImage(named: "ic_menu_info")
            cell.imageView?.image = imageName
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuController.lanzarNovedades))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 5 {
            
            let imageName = UIImage(named: "ic_menu_exit")
            cell.imageView?.image = imageName
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SideMenuController.lanzarSalir))
            cell.addGestureRecognizer(tapGesture)
            
        }
        
        cell.textLabel?.text = menuItems[indexPath.row]
        
        
        
        return cell
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

    @objc func lanzarInicio() -> Void {
        print("---> Lanzando inicio")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrincipalController") as? PrincipalController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarNotificaciones() -> Void {
        print("---> Lanzando notificaciones")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificacionController") as? NotificacionController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarTerminos() -> Void {
        print("---> Lanzando terminos")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TerminosController") as? TerminosController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarAcerca() -> Void {
        print("---> Lanzando acerca")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcercaController") as? AcercaController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarNovedades() -> Void {
        print("---> Lanzando novedades")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NovedadesController") as? NovedadesController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarSalir() -> Void {
        print("---> Lanzando salir")
        
        let salirMessage = UIAlertController(title: "CEPCM", message: "¿Desea salir de la aplicación?", preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: {(action) -> Void in
            
            do {
                try Auth.auth().signOut()
            } catch {
                
            }
            
            self.ref.removeAllObservers()
            
            URLCache.shared.removeAllCachedResponses()
            URLCache.shared.diskCapacity = 0
            URLCache.shared.memoryCapacity = 0
            
            //TODO: Mandar a llamar el logout de backend
            UIApplication.shared.applicationIconBadgeNumber = 0
            
            //Manteniendo en memoria el email del ultimo usuario
            if let uMail = Session.shared.user?.email {
                RUtil.persistValue(value: uMail as AnyObject, key: "lastUser")
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //Removiendo la sesion
            RUtil.removeObjectFor(key: "SESSION")
            RUtil.removeObjectFor(key: "GRUPO")
            let keychain = KeychainSwift()
            keychain.delete("CEPCM_SESSION")
            Session.add(session: User())
            Session.add(tokenOaut: TokenOaut())
            appDelegate.checkLogin()
            
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (action) -> Void in
            
            print("---> Cancelando salida")
            
            /*if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrincipalController") as? PrincipalController {
                
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }*/
            
        }
        
        salirMessage.addAction(aceptar)
        salirMessage.addAction(cancelar)
        
        self.present(salirMessage, animated: true, completion: nil)
        
    }
    
   
    
}
