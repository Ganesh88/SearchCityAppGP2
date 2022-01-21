//
//  Utilities.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 17/12/21.
//

import Foundation
import UIKit
import MBProgressHUD

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

