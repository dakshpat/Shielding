//
//  Wall.swift
//  Shielding
//
//  Created by Daksh Patel on 2/8/22.
//

import Foundation
import SwiftUI

class Wall: NSObject, ObservableObject {
    
    @Published var wallHeight = 0.0
    @Published var wallThickness = 0.0
    @Published var energyAbsorbance = 0.0
    @Published var escapedCounter = 0.0
    
    ///takes in an x and y coordinate and returns true if that point is inside the wall
    func calculateInsideWall(xPoint: Double, yPoint: Double) async -> Bool{
        var isItInside = false
        
        if (xPoint<wallThickness && xPoint>0.0 && yPoint<wallHeight && yPoint>0.0){
            isItInside = true
        }
        
        if (isItInside == false){
           let escape = await escapedCounter(xPoint: xPoint, yPoint: yPoint)
           await updateEscapedCounter(escaped: escape)
        }
        
        return isItInside
    }
    
    ///if the neutron has escaped, then by looking at its end point it either counts it or dosen't. We dont not care if it escapes from the back
    
    func escapedCounter(xPoint: Double, yPoint:Double) async -> Double{
        var doWeCare = true
        
        ///check if it escapes from the back
        if (xPoint < 0.0) {
            doWeCare = false
        }
        
        var escaped = 0.0
        if (doWeCare){
            escaped = 1.0
        }
        
        return escaped
    }
    
    @MainActor func updateEscapedCounter(escaped: Double){
        escapedCounter += escaped
    }

    
    
}
