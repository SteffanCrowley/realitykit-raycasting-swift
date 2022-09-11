//
//  ContentView.swift
//  raycasting-reality-kit-swift
//
//  Created by steffan crowley on 9/10/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> ARView {
        
        //Create AR Scene
        let arView = ARView(frame: .zero)
        
        
        //add gesture to view, targets our coordinator and selects the proper function from the coordinator
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        //Make sure that the coordinator knows about the view
        context.coordinator.view = arView
             
        //Return AR Scene
        return arView
        
    }
    
    //create function that returns our Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
