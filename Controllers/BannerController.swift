//
//  BannerController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 11/19/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import SafariServices
import UIKit
import Auk
import moa

class BannerController: UIViewController, UIScrollViewDelegate, SFSafariViewControllerDelegate {

    var bannerService = BannerService()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        
        print("---> Hola desde el reconocedor de gestos \(self.scrollView.auk.currentPageIndex)")
        
        print("---> El tamanio de las imagenes controller es: \(Session.shared.listaImagenes?.listaImagenes?.count)")
        
        if let indice = self.scrollView.auk.currentPageIndex {
            
            if let object = Session.shared.listaImagenes?.listaImagenes![indice] {
                
                print("urlRedirect : \(object.redirect)")
                if let urlRedirect = object.redirect {
                
                    if let url = URL(string: urlRedirect) {
                        
                        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                        vc.delegate = self
                        
                        present(vc, animated: true)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Moa.settings.cache.requestCachePolicy = .returnCacheDataElseLoad
        Moa.settings.cache.memoryCapacityBytes = 20 * 1024 * 1024
        
        self.bannerService.obtenerImagenesFirebase() { (codigo, respuesta) in
            
            if(codigo == true) {
                
                let imagenes = respuesta as! [ImagenBannerBean]
                
                imagenes.forEach{ item in
                    self.scrollView.auk.show(url: item.url!)
                    
                }
                
            }
            
            self.scrollView.auk.startAutoScroll(delaySeconds: 3)
            
        }
        
       

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
