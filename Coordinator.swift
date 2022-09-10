//
//  Coordinator.swift
//  raycasting-reality-kit-swift
//
//  Created by steffan crowley on 9/10/22.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            let material = SimpleMaterial(color: UIColor.random(), isMetallic: true)
            entity.model?.materials = [material]
        }
        
    }
    
}
