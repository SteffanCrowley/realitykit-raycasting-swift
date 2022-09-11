//
//  Coordinator.swift
//  raycasting-reality-kit-swift
//
//  Created by steffan crowley on 9/10/22.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject {
    
    //creates weak reference to view, can be nil, sets default to ARView
    weak var view: ARView?
    
    //create function to handle taps, pass UITapGestureRecognizer to it
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        //getting access to view, unwrapping optional otherwise return
        guard let view = self.view else { return }
        
        //getting the tap location in the view
        let tapLocation = recognizer.location(in: view)
        
        //casts ray and returns array of results starting with nearest from camera that targets "estimatedPlane" on horizontal.
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        //unwraps optional that is the first array position of the result of raycast
        if let result = results.first {

            //Create anchor using the first result from the previous raycast
            let anchorEntity = AnchorEntity(raycastResult: result)
            
            //create a box model entity using size 0.1
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.1))
            
            //update the boxes material to metallic blue
            modelEntity.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]
            
            //this allows us to interact with entity
            modelEntity.generateCollisionShapes(recursive: true)
            
            //Add the model to the anchor as a child
            anchorEntity.addChild(modelEntity)
            
            //Add the anchor we built to the scene
            view.scene.addAnchor(anchorEntity)
            
            //install basic translation, rotation, and scale gestures to our model
            view.installGestures(for: modelEntity)
            
        }
        
    }
    
}
