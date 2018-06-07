//
//  SettingService.swift
//  voice-calculator
//
//  Created by lz on 6/7/18.
//  Copyright © 2018 Zhuang Liu. All rights reserved.
//

import Foundation
import UIKit

class SettingsService {
    
    class var sharedService : SettingsService {
        struct Singleton {
            static let instance = SettingsService()
        }
        return Singleton.instance
    }
    
    init() { }
    
    var backgroundColor : UIColor {
        get {
            let data: NSData? = UserDefaults.standard.object(forKey: "backgroundColor") as? NSData
            var returnValue: UIColor?
            if data != nil {
                returnValue = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UIColor
            } else {
                returnValue = UIColor.black;
            }
            return returnValue!
        }
        set (newValue) {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(data, forKey: "backgroundColor")
            UserDefaults.standard.synchronize()
        }
    }
    
    var textColor : UIColor {
        get {
            let data: NSData? = UserDefaults.standard.object(forKey: "textColor") as? NSData
            var returnValue: UIColor?
            if data != nil {
                returnValue = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UIColor
            } else {
                returnValue = UIColor.white;
            }
            return returnValue!
        }
        set (newValue) {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(data, forKey: "textColor")
            UserDefaults.standard.synchronize()
        }
    }
    
    var lightModeStatus : Bool {
        get {
            let data: NSData? = UserDefaults.standard.object(forKey: "lightModeStatus") as? NSData
            var returnValue: Bool?
            if data != nil {
                returnValue = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? Bool
            } else {
                returnValue = true;
            }
            return returnValue!
        }
        set (newValue) {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(data, forKey: "lightModeStatus")
            UserDefaults.standard.synchronize()
        }
    }
}
