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
    
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        
//        if let entity = view.entity(at: tapLocation) as? ModelEntity {
//            let material = SimpleMaterial(color: UIColor.random(), isMetallic: true)
//            entity.model?.materials = [material]
//        }
        
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
        
//            let anchor = ARAnchor(name: "Plane anchor", transform: result.worldTransform)
//                view.session.add(anchor: anchor)
            
            //ARAnchor is for ARKit
            //AnchorEntity - RealityKit framework
            
            let anchorEntity = AnchorEntity(raycastResult: result)
            
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.1))
            modelEntity.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]
            modelEntity.generateCollisionShapes(recursive: true)
            
            anchorEntity.addChild(modelEntity)
            
            view.scene.addAnchor(anchorEntity)
            
            view.installGestures(for: modelEntity)
            
        }
        
    }
    
}
