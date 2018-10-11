//
//  RUtil.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import AVFoundation

import SystemConfiguration

import CoreLocation


class RUtil: NSObject{
    
    
    class func appVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return ""
    }
    
    class func archive(object: Any, for key: String) {
        let defs = UserDefaults.standard
        
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        defs.set(data, forKey: key)
        defs.synchronize()
    }
    
    class func unarchiveObjectFor(key: String) -> Any? {
        let defs = UserDefaults.standard
        
        if let data = defs.object(forKey: key) as? Data {
            let object = NSKeyedUnarchiver.unarchiveObject(with: data)
            defs.synchronize()
            
            return object
        }
        
        return nil
    }
    
    class func removeObjectFor(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func containsNumber(string: String) -> Bool {
        if (string as NSString).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")).location == NSNotFound {
            
            return false
        }
        
        return true
    }
    
    class func containsChar(string: String) -> Bool {
        if (string as NSString).rangeOfCharacter(from: CharacterSet(charactersIn: "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz")).location == NSNotFound {
            
            return false
        }
        
        return true
    }
    
    class func loadNib(name: String) -> UIView? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)![0] as? UIView
    }
    
    /*class func formIsValid(form: UIView) -> Bool {
     var isBad = false
     
     for view in form.subviews {
     if let field = view as? RTextField {
     if field.isMandatory {
     if field.text!.characters.count > 0 {
     isBad = false
     } else {
     isBad = true
     break
     }
     }
     } else {
     for view2 in view.subviews {
     if let field = view2 as? RTextField {
     if field.isMandatory {
     if field.text!.characters.count > 0 {
     isBad = false
     } else {
     isBad = true
     break
     }
     }
     }
     }
     }
     }
     
     return !isBad
     }*/
    
    class func keyboardHeightFrom(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardFrame: NSValue = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        return keyboardRectangle.height
    }
    
    class func customColor(r: CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    class func screenBoundsInOrientation() -> CGRect{
        let screenBounds = UIScreen.main.bounds
        return screenBounds
    }
    
    class func isIpad() -> Bool{
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }else{
            return false
        }
    }
    
    class func formatValue(value: Double) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = NumberFormatter.Style.decimal;
        formatter.maximumIntegerDigits = 24;
        formatter.minimumFractionDigits = 2;
        formatter.maximumFractionDigits = 2;
        formatter.usesSignificantDigits = false;
        formatter.usesGroupingSeparator = true;
        formatter.groupingSeparator = ",";
        formatter.decimalSeparator = "."
        
        var cant = String(format: "%@", formatter.string(from: NSNumber(value: value))!)
        let range = (cant as NSString).range(of: ".")
        
        if range.length > 0 {
            cant = (cant as NSString).substring(to: range.location)
        }
        
        return cant
    }
    
    class func instantiateController(name: String, forStoryboard board: String) -> UIViewController {
        return UIStoryboard(name: board, bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    class func showInfoAlertWithText(text: String, title: String, controller: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController.init(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: handler))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func showOptionAlertWithText(text: String, title: String, controller: UIViewController, okCallBack: @escaping (_ alert: UIAlertAction) -> Void, cancelCallBack: @escaping (_ alert: UIAlertAction) -> Void) {
        
        let alert = UIAlertController.init(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: cancelCallBack))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: okCallBack))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func valueForKey_(key: String) -> AnyObject?{
        let value = UserDefaults.standard.object(forKey: key)
        return value as AnyObject?
    }
    
    class func persistValue(value: AnyObject?, key: String) {
        let defs = UserDefaults.standard
        defs.set(value, forKey: key)
        defs.synchronize()
    }
    
    class func resetDefaultsExceptKeys(keys: Array<String>?) {
        let defs = UserDefaults.standard
        let dic = defs.dictionaryRepresentation().keys
        
        for key in dic {
            if keys != nil {
                if !keys!.contains(key as String) {
                    defs.removeObject(forKey: key)
                }
            }else{
                defs.removeObject(forKey: key)
            }
        }
        defs.synchronize()
    }
    
    class func showTransparentView(show: Bool, alpha: CGFloat) {
        let window = UIApplication.shared.delegate?.window
        
        if show {
            let transView = UIView.init(frame: CGRect(x: 0, y: 0, width: 1024, height: window!!.frame.size.height))
            transView.alpha = 0;
            transView.backgroundColor = UIColor.black
            transView.tag = 8888;
            window!!.addSubview(transView)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                transView.alpha = alpha;
            }, completion: nil)
        }else{
            var transView = window!!.viewWithTag(8888)
            
            if transView != nil {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                    transView?.alpha = 0
                }, completion: { (Bool) -> Void in
                    transView?.removeFromSuperview()
                    transView = nil
                })
            }
        }
    }
    
    class func takeScreenshotToView(view: UIView, result: @escaping (_ image: UIImage) -> ()) {
        UIGraphicsBeginImageContext(view.bounds.size)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        DispatchQueue.main.async(execute: {
            result(image)
        })
    }
    
    class func blur(image: UIImage, blurImage: @escaping (_ image: UIImage) -> ()) {
        let radius: CGFloat = 5;
        let context = CIContext(options: nil);
        let inputImage = CIImage(cgImage: image.cgImage!);
        let filter = CIFilter(name: "CIGaussianBlur");
        filter?.setValue(inputImage, forKey: kCIInputImageKey);
        filter?.setValue("\(radius)", forKey:kCIInputRadiusKey);
        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage;
        let rect = CGRect(x: radius * 2,y: radius * 2, width: image.size.width - radius * 4,height: image.size.height - radius * 4)
        let cgImage = context.createCGImage(result, from: rect);
        let returnImage = UIImage(cgImage: cgImage!);
        
        DispatchQueue.main.async(execute: {
            blurImage(returnImage)
        })
    }
    
    class func documentsDirectoryForFile(file: String) -> String{
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls.first
        let finalUrl = documentDirectory!.appendingPathComponent(file)
        
        return finalUrl.relativeString
    }
    
    class func addViewToWindow(view: UIView) {
        let window = UIApplication.shared.delegate?.window
        window!!.addSubview(view)
    }
    
    class func addViewToWindow(view: UIView, animated: Bool) {
        let window = UIApplication.shared.delegate?.window
        view.alpha = 0
        window!!.addSubview(view)
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                view.alpha = 1
            })
        } else {
            view.alpha = 1
        }
    }
    
    class func playSystemSoundFor(id: Int) {
        let systemSoundID: SystemSoundID = SystemSoundID(id)
        AudioServicesPlaySystemSound (systemSoundID)
    }
    
    class func monthNameFromNumber(num: Int) -> String{
        var number = num
        if number == 0 {number = 12}
        
        let dateString = String(format: "%d", number)
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "MM"
        let myDate = dateFormatter.date(from: dateString)
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "MMMM"
        let stringDate = formatter.string(from: myDate!)
        
        return stringDate
    }
    
    class func addBlurToView(view: UIView, style: UIBlurEffectStyle, frame: CGRect) {
        let effect = UIBlurEffect(style: style)
        let blur = UIVisualEffectView.init(effect: effect)
        blur.frame = frame
        
        let vib = UIVibrancyEffect.init(blurEffect: effect)
        let vibView = UIVisualEffectView.init(effect: vib)
        vibView.alpha = 0.5
        
        blur.contentView.addSubview(vibView)
        blur.alpha = 0
        
        UIView.animate(withDuration: 0.2) { () -> Void in
            blur.alpha = 1
        }
        
        blur.tag = 202020
        view.addSubview(blur)
    }
    
    class func blurWindowWithStyle(style: UIBlurEffectStyle) {
        let window = UIApplication.shared.delegate?.window
        
        let effect = UIBlurEffect(style: style)
        let blur = UIVisualEffectView.init(effect: effect)
        blur.frame = window!!.bounds
        
        let vib = UIVibrancyEffect.init(blurEffect: effect)
        let vibView = UIVisualEffectView.init(effect: vib)
        
        blur.contentView.addSubview(vibView)
        blur.alpha = 0
        
        UIView.animate(withDuration: 0.2) { () -> Void in
            blur.alpha = 1
        }
        
        blur.tag = 202020
        window!!.addSubview(blur)
    }
    
    class func removeBlur() {
        let window = UIApplication.shared.delegate?.window
        var blur = window!!.viewWithTag(202020)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            blur?.alpha = 0
            
        }) { (Bool) -> Void in
            blur?.removeFromSuperview()
            blur = nil
        }
    }
    
    class func screenSizeForOrientation(orientation: Int) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height
        
        if orientation == 1 || orientation == 0 {
            if width > height {
                return CGSize(width: height, height: width)
            }else{
                return CGSize(width: width, height: height)
            }
        }else{
            if width > height {
                return CGSize(width: width, height: height)
            }else{
                return CGSize(width: height, height: width)
            }
        }
    }
    
    class func checkPushEnabled() -> Bool {
        if UIApplication.shared.responds(to: #selector(getter: UIApplication.currentUserNotificationSettings)) {
            if let grantedSettings = UIApplication.shared.currentUserNotificationSettings {
                if grantedSettings.types.contains([.alert, .sound, .badge]) {
                    return true
                    
                }else {
                    return false
                }
            }
        }
        
        return false
    }
    
    class func colorWithRed(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor {
        return UIColor( red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(alpha))
    }
    
    class func device() -> String {
        let width = self.screenBoundsInOrientation().width
        let height = self.screenBoundsInOrientation().height
        
        if width == 320 {
            if height == 480 {
                return "4"
            }else{
                return "5"
            }
        }else if width == 375 {
            return "6"
        }else{
            return "6+"
        }
    }
    
    class func showTransView(show: Bool, inView view: UIView, forTag tag: Int, withAlpha alpha: CGFloat, atIndex index: Int) {
        if show {
            let transView = UIView.init(frame: view.bounds)
            transView.backgroundColor = UIColor.black
            transView.tag = tag
            transView.alpha = 0
            
            if index == -1 {
                view.addSubview(transView)
            } else {
                view.insertSubview(transView, at: index)
            }
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                transView.alpha = alpha
            }) { (Bool) -> Void in
                
            }
        }else{
            var transView = view.viewWithTag(tag)
            
            if transView != nil {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                    transView!.alpha = 0
                }) { (Bool) -> Void in
                    transView?.removeFromSuperview()
                    transView = nil
                }
            }
        }
    }
    
    class func isPushEnable() -> Bool {
        let grantedSettings = UIApplication.shared.currentUserNotificationSettings
        
        if !grantedSettings!.types.contains([.badge, .sound, .alert]) {
            return false
            
        }else{
            return true
        }
    }
    
    class func promptToEnablePush(title: String, message: String, controller: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open settings", style: .default, handler: { (UIAlertAction) in
            UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (UIAlertAction) in
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func formatValue(value: Double, decimals: Int) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = NumberFormatter.Style.decimal;
        formatter.maximumIntegerDigits = 24;
        formatter.minimumFractionDigits = decimals;
        formatter.maximumFractionDigits = decimals;
        formatter.usesSignificantDigits = false;
        formatter.usesGroupingSeparator = true;
        formatter.groupingSeparator = ",";
        formatter.decimalSeparator = "."
        
        var cant = String(format: "%@", formatter.string(from: NSNumber(value: value))!)
        let range = (cant as NSString).range(of: ".")
        
        if range.length > 0 {
            cant = (cant as NSString).substring(to: range.location)
        }
        
        return cant
    }
    
    class func callNumber(num: String) {
        
        let number = num.replacingOccurrences(of: "[^0-9|.,+]", with: "", options: .regularExpression, range: num.startIndex..<num.endIndex)
        //print(number)
        let aURL = NSURL(string: "telprompt://\(number)")
        if UIApplication.shared.canOpenURL(aURL! as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(aURL! as URL, options: [:], completionHandler: {(action) in
                    //print("............COMPLETED..............")
                })
            } else {
                UIApplication.shared.openURL(aURL! as URL)
            }
        } else {
            //print("error calling")
        }
    }
    
    func locationEnabled() -> Bool {
        
        
        return true
    }
    
    
    /*class func networkAvailable() -> Bool {
     let conn = Connection.reachabilityForInternet()
     let connected = conn?.isReachable()
     return connected!
     }*/
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
}


// Extensions
extension String {
    func boolValue() -> Bool {
        switch self {
        case "True", "true", "yes", "1", "Yes", "YES":
            return true
            
        case "False", "false", "no", "0", "No", "NO":
            return false
            
        default:
            return false
        }
        
    }
    
    func removeAccents() -> String {
        var text = self
        
        text = text.replacingOccurrences(of: "á", with: "a")
        text = text.replacingOccurrences(of: "é", with: "e")
        text = text.replacingOccurrences(of: "í", with: "i")
        text = text.replacingOccurrences(of: "ó", with: "o")
        text = text.replacingOccurrences(of: "ú", with: "u")
        
        text = text.replacingOccurrences(of: "Á", with: "A")
        text = text.replacingOccurrences(of: "É", with: "E")
        text = text.replacingOccurrences(of: "Í", with: "I")
        text = text.replacingOccurrences(of: "Ó", with: "O")
        text = text.replacingOccurrences(of: "Ú", with: "U")
        
        return text
    }
    
    func currencyWithSymbol(useSymbol: Bool, digits: Int) -> String{
        if self == "" {
            return ""
        }
        
        let value = RUtil.formatValue(value: Double(self)!, decimals: digits)
        var newVal = ""
        
        if useSymbol {
            newVal = String(format: "$ %@", value)
        }else{
            newVal = String(format: "%@", value)
        }
        
        return newVal
    }
    
    func cleanText() -> String{
        var value = self
        
        value = value.replacingOccurrences(of: ",", with: "")
        value = value.replacingOccurrences(of: "-", with: "")
        value = value.replacingOccurrences(of: "%", with: "")
        value = value.replacingOccurrences(of: "'", with: "")
        value = value.replacingOccurrences(of: " ", with: "")
        value = value.replacingOccurrences(of: "(", with: "")
        value = value.replacingOccurrences(of: ")", with: "")
        value = value.replacingOccurrences(of: "+", with: "")
        
        value = value.replacingOccurrences(of: "á", with: "")
        value = value.replacingOccurrences(of: "é", with: "")
        value = value.replacingOccurrences(of: "í", with: "")
        value = value.replacingOccurrences(of: "ó", with: "")
        value = value.replacingOccurrences(of: "ú", with: "")
        
        return value;
    }
    
    func cleanWhiteSpacesFromContactNum() -> String {
        var value = self.cleanText()
        let phone = NSMutableString(string: "")
        
        for chr in value.unicodeScalars {
            if chr.value >= 48 && chr.value <= 57 {
                phone.append(String.init(chr))
            }
        }
        
        return phone as String
        
        //        value = (value as NSString).stringByReplacingOccurrencesOfString("^0-9", withString: "", options: .RegularExpressionSearch, range: NSMakeRange(0, (value as NSString).length))
        //        return value
    }
    
    func isNumeric() -> Bool {
        let nonNumbers = NSCharacterSet.decimalDigits.inverted
        let string = self as NSString
        let range = string.rangeOfCharacter(from: nonNumbers)
        return range.location == NSNotFound
    }
    
    func isNumericAllowingDot() -> Bool{
        let nonNumbers = NSCharacterSet.decimalDigits.inverted
        let string = self as NSString
        
        return (string.trimmingCharacters(in: nonNumbers) as NSString).length > 0;
    }
    
    func removeDecimal() -> String {
        var value = self as NSString;
        let range = value.range(of: ".")
        
        if range.length > 0 {
            value = value.substring(to: range.location) as NSString
        }
        
        return value as String;
    }
    
    
    func isValidMail() -> Bool {
        let stricterFilterString = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$"
        //let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = stricterFilterString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: self)
    }
    
    
}

extension Date {
    
    func dateByAddingHours(hours: Int) -> Date {
        let currentDate = self
        var dateComps = DateComponents()
        dateComps.hour = +hours
        let newDate = NSCalendar.current.date(byAdding: dateComps as DateComponents, to: currentDate as Date)
        
        return newDate!
    }
    
    func dateByAddingYears(years: Int) -> Date {
        let currentDate = self
        var dateComps = DateComponents()
        dateComps.year = +years
        let newDate = NSCalendar.current.date(byAdding: dateComps as DateComponents, to: currentDate as Date)
        
        return newDate!
    }
    
    func dateBySubstractingYears(years: Int) -> Date {
        let currentDate = self
        var dateComps = DateComponents()
        dateComps.year = -years
        let newDate = NSCalendar.current.date(byAdding: dateComps as DateComponents, to: currentDate as Date)
        
        return newDate!
    }
    
    func dateBySubstractingHours(hours: Int) -> Date {
        let currentDate = self
        var dateComps = DateComponents()
        dateComps.hour = -hours
        let newDate = NSCalendar.current.date(byAdding: dateComps as DateComponents, to: currentDate as Date)
        
        return newDate!
    }
    
    func stringDateWithFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let dateString = formatter.string(from: self as Date)
        return dateString
    }
    
    func minutesFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
}

extension UIView {
    func bounce() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.3, y: 1.3)
        }) { (bool) in
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            })
        }
    }
    
    func bounce(scale: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        }) { (bool) in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            })
        }
    }
    
    func fadeOut(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0
            })
        } else {
            self.alpha = 0
        }
    }
    
    func fadeIn(duration: Double, delay: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1
            
        }, completion: nil)
    }
}

extension NSMutableAttributedString {
    func addTextNFont(text:String, font: UIFont) -> NSMutableAttributedString {
        let attrs:[NSAttributedStringKey: Any] = [NSAttributedStringKey.font : font]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }}

