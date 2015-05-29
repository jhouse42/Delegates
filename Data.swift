//
//  Data.swift
//  PlantFavs
//
//  Created by Jeanie House on 4/23/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import Foundation

class Data {
    
    var pClass: [String:[String]]
    
    var pClassList: [String] {
        var list: [String] = []
        for pClassName in pClass.keys {
            list.append(pClassName)
        }
        
        list.sort(<)
        
        return list
    }
    
    init() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let pClassInfo = userDefaults.valueForKey("pClass") as? [String:[String]] {
            pClass = pClassInfo
        } else {
            
            //default data
            
            pClass = [
                " Trees": [],
                " Shrubs" : [],
                " Annuals" : [],
                " Tropicals" : [],
                " Perennials" : []
            ]
        }
    }
    
    func saveData() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(pClass, forKey: "pClass")
    }
    
    func addVariety(pClass inpClass: String, variety: String) {
        if var varieties = pClass[inpClass] {
            varieties.append(variety)
            pClass[inpClass] = varieties
        }
        
        saveData()
    }
    
    func removeVariety(pClass inpClass: String, variety inVariety: String) {
        if var varieties = pClass[inpClass] {
            var index = -1
            
            for (idx, variety) in enumerate(varieties) {
                if variety == inVariety {
                    index = idx
                    break
                }
            }
            
            if index != -1 {
                varieties.removeAtIndex(index)
                pClass[inpClass] = varieties
                saveData()
            }
            
        }
    }
    
    class func urlForVariety(variety: String) -> NSURL {
       
        var safeString = variety.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        return NSURL(string: "http://en.wikipedia.org/wiki/" + safeString)!
      //  http://en.wikipedia.org/wiki/
    }
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : Data? = nil
    }
    
    class var sharedInstance : Data {
        dispatch_once(&Static.onceToken) {
            Static.instance = Data()
        }
        return Static.instance!
    }
}


