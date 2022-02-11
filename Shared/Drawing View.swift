//
//  Drawing View.swift
//  Shielding
//
//  Created by Daksh Patel on 2/9/22.
//


import SwiftUI

struct drawingView: View{
    
    var path: [[(xPoint: Double, yPoint:Double)]]
    
    var body: some View{
        
        ZStack{
            drawWall()
                .stroke(Color.black)
            
            drawPath(drawingPoints: path)
                .stroke(Color.red)
            
        }
        .background(Color.white)
        .aspectRatio(1, contentMode: .fill)
        
        
    }
}


struct drawWall: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
        
    }
    
}

struct drawPath: Shape {
    
    var drawingPoints: [[(xPoint:Double, yPoint:Double)]]
    
    func path(in rect: CGRect) -> Path {
        
     //let origin = CGPoint(x: rect.width, y: rect.width)
        let scale = rect.width/5
        
        var path = Path()
        
        for neutronPaths in drawingPoints{
            let pathArray = neutronPaths
            for item in pathArray{
                path.addRect(CGRect(x: item.xPoint*Double(scale), y: item.yPoint*Double(scale), width: 5.0 , height: 5.0))
            }
        }
        return path
    }
}
