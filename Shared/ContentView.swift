//
//  ContentView.swift
//  Shared
//
//  Created by Daksh Patel on 2/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var wall = Wall()
    @ObservedObject var collosion = Collosion()
    @State var percentageEscaped = 0.0
    @State var energyAbsorbanceTemp = 10.0
    @State var energyAbsorbanceTempString = "10.0"
    
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .center){
                Group{
                    HStack{
                        Text("Number of neutrons for simulations: ")
                        TextField("# of neutrons", value: $collosion.numberOfNeutrons, format: .number)
                            .frame(width: 100)
                    }
                    .padding()
                    
                    
                    HStack{
                        Text("mean free path: ")
                        TextField("meanfreepath", value: $collosion.meanFreePath, format: .number)
                            .frame(width: 100)

                    }
                    .padding()
                    
                    HStack{
                        Text("Beam Diameter: ")
                        TextField("beam diameter", value: $collosion.beamDiameter, format: .number)
                            .frame(width: 100)

                    }
                    .padding()
                    
                    HStack{
                        Text("Wall height: ")
                        TextField("wall height", value: $wall.wallHeight, format: .number)
                            .frame(width: 100)

                    }
                    .padding()
                    
                    HStack{
                        Text("Wall Thickness: ")
                        TextField("wall thickness", value: $wall.wallThickness, format: .number)
                            .frame(width: 100)

                    }
                    .padding()
                    
                    HStack{
                        Text("Energy Absorbance of the wall: ")
                        TextField("% energy decrease per hit ", value: $collosion.energyAbsorbance, format: .number)
                            .frame(width: 100)

                    }
//                    HStack {
//                        Text("Energy Absorbance of the wall: ")
//                        TextField("% energy decrease per hit ", value: $self.energyAbsorbanceTempString)
//                    }
//                    .padding()
                    
                }
                
                    Button("RUN Simulation"){
                        
                        Task.init{
                            await runSimulation()

                        }
                    }
                    
                    Button("Clear"){
                        clear()
                    }
                
            }
            
            VStack(alignment: .center){
                
                Text("Percentage of neutrons that escaped: \(percentageEscaped, specifier: "%.2f")")
                
                
                drawingView(path: collosion.neutronPath )
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .drawingGroup()
                
                Spacer()
            }
      
            
        }
    }
                     
    func runSimulation() async {
                    
        var n = 0.0
//        energyAbsorbanceTemp = Double(energyAbsorbanceTempString)
//        wall.energyAbsorbance = energyAbsorbanceTemp
        while (n < collosion.numberOfNeutrons){
            await collosion.calculateRandomWalk()
            n += 1.0
        }
                
        percentageEscaped = wall.escapedCounter/collosion.numberOfNeutrons
    }
    
    func clear(){
                    
        wall.wallHeight = 5.0
        wall.wallThickness = 5.0
        wall.energyAbsorbance = 10.0
        wall.escapedCounter = 0.0
        collosion.meanFreePath = 1.0
        collosion.beamDiameter = 0.5
        collosion.numberOfNeutrons = 1.0
        collosion.neutronPath = [[(xPoint: 0.0, yPoint: 0.0)]]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
