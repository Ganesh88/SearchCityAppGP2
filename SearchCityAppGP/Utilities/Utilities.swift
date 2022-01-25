//
//  Utilities.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 17/12/21.
//

import Foundation
import UIKit
import MBProgressHUD
import AFNetworking
import PromiseKit

class Utilities {
    weak var appDelegate: AppDelegate!    
    // MARK: - Singleton
    class var instance: Utilities {
        struct Static {
            static let instance: Utilities = Utilities()
        }
        return Static.instance
    }
    
    // MARK: - Initialise
    func initialise() {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func formattedDateFromString(dateString: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm a"
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    func showAlert(title: String,
                   message: String) {
        let alert = UIAlertController(title: title,
                                      message:message,
                                      preferredStyle: .alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .cancel,
                                      handler: nil))
        
        if let window = UIApplication.shared.windows.first {
            // show the alert
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func checkConnectivity() -> Promise<Bool> {
        return Promise { seal  in
            let reachability = AFNetworkReachabilityManager.shared()
                reachability.startMonitoring();
                reachability.setReachabilityStatusChange({ (status) -> Void in
                    switch(status) {
                    case .unknown,.notReachable:
                        seal.fulfill(false)
                    case .reachableViaWWAN,.reachableViaWiFi:
                        seal.fulfill(true)
                    @unknown default:
                        seal.fulfill(false)
                    }
                })
        }
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 10, height: 10)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UIViewController {
    func showHud() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = kLoading
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

//Error Enum
enum AppError : Error {
    case defaultError
    case networkError
}

extension AppError : LocalizedError {
    public var errorDescription: String? {
        switch self{
        case .defaultError:
            return kUnknownError
        case .networkError:
            return kNetworkError
        
        }
    }
}


