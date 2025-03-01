//
//  File.swift
//  HouseDesigner
//
//  Created by Max on 28.02.2025.
//

import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
    let sceneString: String
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        sceneView.frame = CGRect(x: 20, y: 400, width: 300, height: 200) 
              
        sceneView.backgroundColor = .clear

        if let scene = SCNScene(named: sceneString) {
//            if let sofaNode = scene.rootNode.childNode(withName: "divan", recursively: true) {
//                if let sofaMaterial = sofaNode.geometry?.firstMaterial {
//                    sofaMaterial.diffuse.contents = UIImage(named: "divan_texture.png")
//                }
//            }
            
//            if let tableLegsNode = scene.rootNode.childNode(withName: "table_legs", recursively: true) {
//                if let legsMaterial = tableLegsNode.geometry?.firstMaterial {
//                    legsMaterial.diffuse.contents = UIImage(named: "wood.png") // Інша текстура для ніжок
//                }
//            }
            
            sceneView.scene = scene
            
        }

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}
}

