//
//  Collision.swift
//  Shielding
//
//  Created by Daksh Patel on 2/8/22.
//

import Foundation
import SwiftUI

class Collosion: NSObject, ObservableObject{
    
    
    @Published var neutronPath = [[(xPoint: Double, yPoint: Double)]]()
    @Published var meanFreePath = 1.0
    @Published var beamHeight = 2.5
    @Published var numberOfNeutrons = 1.0
    @Published var energyAbsorbance = 10.0
    @Published var escapedCounter = 0.0
    
    func calculateRandomWalk() async {
        let wall = Wall()
        wall.energyAbsorbance = energyAbsorbance
        var Point = (xPoint: 0.0, yPoint: 0.0)
        var beamPath: [(xPoint: Double, yPoint: Double)] = []
        
        ///figuring out where the neutron will enter(the cordinate of the "entrance"
       // let wallCenter = wall.wallHeight/2
       // Point.yPoint = Double.random(in: (wallCenter-beamRadius)...(wallCenter+beamRadius))
        Point.yPoint = beamHeight
        
        ///calculating the scattering
        var neutronEnergy = 100.0
        let energyAbsorbed = wall.energyAbsorbance
        
            Point.xPoint = Point.xPoint + meanFreePath
            beamPath.append(Point)
            neutronEnergy = neutronEnergy - energyAbsorbed
        
        var check = true
        while (neutronEnergy >= 0 && check){
            let randomAngle = Double.random(in: 0.0...(2.0*Double.pi))
            let directionInX = meanFreePath*cos(randomAngle)
            let directionInY = meanFreePath*sin(randomAngle)
            
            Point.xPoint += directionInX
            Point.yPoint += directionInY
            beamPath.append(Point)
            
            check = await wall.calculateInsideWall(xPoint: Point.xPoint, yPoint: Point.yPoint)
            neutronEnergy = neutronEnergy - energyAbsorbed
          
        }
        
        if (neutronEnergy > 0.0){
            escapedCounter += 1.0
        }
                await updateNeutronPath(path: beamPath)
        
    }
    
    @MainActor func updateNeutronPath(path: [(Double, Double)]){
        neutronPath.append(path)
    }
    
}
