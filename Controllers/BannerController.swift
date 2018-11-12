//
//  BannerController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 11/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Auk
import UIKit
import FirebaseAuth
import FirebaseDatabase

class BannerController: UIViewController, UIScrollViewDelegate {

    var bannerService = BannerService()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bannerService.obtenerImagenesFirebase() { (codigo, respuesta) in
            
        }
        
        scrollView.auk.show(url: "https://bit.ly/auk_image")
        scrollView.auk.show(url: "https://bit.ly/moa_image")

        // Return the number of pages in the scroll view
        scrollView.auk.numberOfPages
        
        // Get the index of the current page or nil if there are no pages
        scrollView.auk.currentPageIndex
        
        // Return currently displayed images
        scrollView.auk.images
        
        // Scroll images automatically with the interval of 3 seconds
        scrollView.auk.startAutoScroll(delaySeconds: 3)
        
        // Stop auto-scrolling of the images
        //scrollView.auk.stopAutoScroll()
        
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
