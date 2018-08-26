//
//  PrincipalController.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/19/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import SideMenu

class PrincipalController: UIViewController {

    @IBAction func activarSideBar(_ sender: UIBarButtonItem) {
        
        // Define the menus
        //let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: PrincipalController)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "sideMenuNavigation") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        //let menuRightNavigationController = UISideMenuNavigationController(rootViewController: PrincipalController)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        //SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        //Then from a button, do something like this:
        
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
        // Similarly, to dismiss a menu programmatically, you would do this:
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
