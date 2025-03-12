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
        sceneView.frame = CGRect(x: 20, y: 400, width: 250, height: 350)
        sceneView.backgroundColor = .clear
        loadScene(into: sceneView, named: sceneString)
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        loadScene(into: uiView, named: sceneString)
    }

    private func loadScene(into sceneView: SCNView, named sceneName: String) {
        if let scene = SCNScene(named: sceneName) {
            sceneView.scene = scene
        }
    }
}

import SwiftUI
import SceneKit

struct SceneDetailsView: UIViewRepresentable {
    let sceneString: String
    @Binding var scaleFactor: Float // Binding for scale control

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .black

        if let scene = SCNScene(named: sceneString) {
            sceneView.scene = scene
            applyHDRIBackground(to: scene)

            // Scale entire scene root node
            scene.rootNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        } else {
            print("🚨 Scene file not found: \(sceneString)")
        }

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        if let rootNode = uiView.scene?.rootNode {
            rootNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        }
    }

    private func applyHDRIBackground(to scene: SCNScene) {
        guard let hdriPath = Bundle.main.path(forResource: "small_empty_room", ofType: "hdr") else {
            print("🚨 HDRI file not found in bundle.")
            return
        }

        let hdriURL = URL(fileURLWithPath: hdriPath)
        scene.background.contents = hdriURL
        scene.lightingEnvironment.contents = hdriURL
        scene.lightingEnvironment.intensity = 2.5
    }
}
