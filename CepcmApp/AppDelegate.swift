//
//  AppDelegate.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 7/20/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref: DatabaseReference!

    override init() {
        //leyendo el archivo Config.plist
        let filePath = Bundle.main.path(forResource: "Config", ofType: "plist")
        let configPlist = NSDictionary(contentsOfFile: filePath!)
        let ambiente = configPlist?["Ambiente"] as! String
     
        var configPath = ""
        if ambiente == "Desarrollo"{
            configPath = Bundle.main.path(forResource: "Des-GoogleService-Info", ofType: "plist")!
        }else if ambiente == "Produccion"{
            configPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        }
        let fileOpts = FirebaseOptions.init(contentsOfFile: configPath)
        FirebaseApp.configure(options: fileOpts!)
        ref = Database.database().reference()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
            
        UINavigationBar.appearance().tintColor = Colors.brightOrange()
        
        let attributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey.font: Fonts.AvenirMedium(size: 18),
            NSAttributedStringKey.foregroundColor: Colors.darkColor()
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        UITabBar.appearance().tintColor = Colors.darkColor()
       // application.registerForRemoteNotifications()
        //ESTO ES PARA CONFIGURAR FACEBOOK
        /*FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)*/
        
        let filePath = Bundle.main.path(forResource: "Config", ofType: "plist")
        let configPlist = NSDictionary(contentsOfFile: filePath!)
        //Se guardar el plist
        RUtil.persistValue(value: configPlist!, key: "config")
        
        Session.add(token: DeviceToken())
        Session.add(session: User())
    
        checkLogin()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func checkLogin() {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        //Inicia la validacion de la sesion
        if RUtil.valueForKey_(key: "SESSION") != nil {
            if Session.shared.user?.idUsuario != nil {
                
                    let session = Session.shared.user!
                    let data = NSKeyedArchiver.archivedData(withRootObject: session)
                    let keyChain = KeychainSwift()
                    keyChain.set(data, forKey: "CEPCM_SESSION_GNP")
               
                    let adminController = storyBoard.instantiateViewController(withIdentifier: "PrincipalController")
                    self.window?.rootViewController = adminController
            }else{
                //No hay sesion se manda al login
                let loginController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerLogin")
                self.window?.rootViewController = loginController
            }
        }else{
             //No hay sesion se manda al login
            let loginController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerLogin")
            self.window?.rootViewController = loginController
        }
        
        
        
        
    }

}

