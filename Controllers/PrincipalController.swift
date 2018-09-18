//
//  PrincipalController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/19/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import SideMenu

class PrincipalController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageArray = [UIImage(named: "ic_adeudos"), UIImage(named: "ic_calendario"), UIImage(named: "ic_calificaciones"), UIImage(named: "ic_materias"), UIImage(named: "ic_pagos")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        if indexPath.row == 0 {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PrincipalController.lanzarAdeudos))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 1 {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PrincipalController.lanzarCalendario))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 2 {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PrincipalController.lanzarCalificaciones))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 3 {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PrincipalController.lanzarMaterias))
            cell.addGestureRecognizer(tapGesture)
            
        } else if indexPath.row == 4 {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PrincipalController.lanzarPagos))
            cell.addGestureRecognizer(tapGesture)
            
        }
        
        cell.imgImage.image = imageArray[indexPath.row]
        
        return cell
        
    }
    

    @IBAction func activarSideBar(_ sender: UIBarButtonItem) {
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "sideMenuNavigation") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
        
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func lanzarAdeudos() -> Void {
        print("--> Lanzando adeudos")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdeudoController") as? AdeudoController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }

    @objc func lanzarCalendario() -> Void {
        print("--> Lanzando calendario")
    }
    
    @objc func lanzarCalificaciones() -> Void {
        print("---> Lanzando calificaciones")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalificacionController") as? CalificacionController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarMaterias() -> Void {
        print("---> Lanzando materias")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MateriaController") as? MateriaController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    @objc func lanzarPagos() -> Void {
        print("---> Lanzando pagos")
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagosController") as? PagosController {
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
}
