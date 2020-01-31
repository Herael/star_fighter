//
//  Algo2020.swift
//  Test2020
//
//  Created by Benoit Briatte on 08/01/2020.
//  Copyright © 2020 ESGI. All rights reserved.
//
import Foundation

class Algo2020 {
    
    let val: Int
    
    init(val: Int) {
        self.val = val
    }
    
    
     /**
        Call this function for showing alert with OK and Cancel button in your View Controller class.
        - Parameters:
           - VC : View Controller over which the function is called. You can use self, or provide view controller name.
           - message: Pass your alert message in String.
           - okClickHandler: This will give you call back inside block when OK button is clicked
        
        ### Usage Example: ###
        ````
        AlertClass().showAlert(self, andMessage: "This is custom alert") { (okClick) in
        }
        ````
        */
    func isLess(than val: Int) -> Bool {
        return val < self.val
    }
    
    func isGreater(than val: Int) -> Bool {
        return val > self.val
    }
}
