//
//  Wall.swift
//  Shielding
//
//  Created by Daksh Patel on 2/8/22.
//

import Foundation
import SwiftUI

class Wall: NSObject, ObservableObject {
    
    @Published  var wallHeight = 5.0
    @Published  var wallThickness = 5.0
    ///in % the amount of energy the neutron will lose per hit(default 10%)
    @Published  var energyAbsorbance = 10.0
    @Published  var escapedCounter = 0.0
    
    ///takes in an x and y coordinate and returns true if that point is inside the wall
    func calculateInsideWall(xPoint: Double, yPoint: Double) async -> Bool{
        var isItInside = false
        
        if (xPoint<wallThickness && xPoint>0.0 && yPoint<wallHeight && yPoint>0.0){
            isItInside = true
        }
        
        
        return isItInside
    }
    
}
