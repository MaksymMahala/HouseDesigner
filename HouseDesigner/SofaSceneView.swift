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
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .black // Default background
        
        if let scene = SCNScene(named: sceneString) {
            sceneView.scene = scene
            applyHDRIBackground(to: scene)
        } else {
            print("🚨 Scene file not found: \(sceneString)")
        }

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        if let scene = SCNScene(named: sceneString) {
            uiView.scene = scene
            applyHDRIBackground(to: scene)
        }
    }

    private func applyHDRIBackground(to scene: SCNScene) {
        guard let hdriPath = Bundle.main.path(forResource: "small_empty_room", ofType: "hdr") else {
            print("🚨 HDRI file not found in bundle.")
            return
        }
        
        let hdriURL = URL(fileURLWithPath: hdriPath)
        
        // ✅ Set HDRI as SceneKit background
        scene.background.contents = hdriURL
        
        // ✅ Set HDRI as Lighting Environment
        scene.lightingEnvironment.contents = hdriURL
        scene.lightingEnvironment.intensity = 2.5
    }
}
