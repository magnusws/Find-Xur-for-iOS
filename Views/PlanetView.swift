//
//  PlanetView.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 02/01/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI
import SceneKit

struct PlanetView : UIViewRepresentable {
    @ObservedObject var xurVM : XurViewModel

    func makeUIView(context: Context) -> SCNView {
        
        let planet = SCNView()
        
        let scene = SCNScene()
        
              // oppretter scenekit node (for a definere kamera node)
              let cameraNode = SCNNode()
                  
              // child node -> camera
              cameraNode.camera = SCNCamera()
              
              if xurVM.xur.isHere == "1" {
                // cameraNode.camera?.wantsHDR = true
                cameraNode.camera?.wantsDepthOfField = true
                cameraNode.camera?.focusDistance = 0.98
                
                cameraNode.camera?.vignettingIntensity = 1.2
                cameraNode.camera?.vignettingPower = 0.1
                
                cameraNode.camera?.bloomIntensity = 0.4
                cameraNode.camera?.bloomThreshold = 1
                cameraNode.camera?.bloomBlurRadius = 10
                  
                cameraNode.camera?.colorFringeStrength = 0.2
                cameraNode.camera?.colorFringeIntensity = 2
                cameraNode.position = SCNVector3( x:-0.70, y:-0.14, z:2.9 )
                
              } else {
                cameraNode.camera?.colorFringeStrength = 0.2
                cameraNode.camera?.colorFringeIntensity = 20
                cameraNode.position = SCNVector3( x:0, y:0, z:4 )
              }
                  
              // add child node (camera node)
              scene.rootNode.addChildNode(cameraNode)
              
              
              if xurVM.xur.isHere == "1" {
                  
                  let lightNode = SCNNode()
                  lightNode.light = SCNLight()
                  lightNode.light?.type = .omni
                  lightNode.light?.shadowRadius = 0
                  lightNode.light?.intensity = 20
                  lightNode.position = SCNVector3( x:-1000, y:-1500, z:1000 )
                  lightNode.rotation = SCNVector4(0, 1, 0, -45)
                  lightNode.light?.castsShadow = false
                  cameraNode.addChildNode(lightNode)
                  
                  
                  let rightLightNode = SCNNode()
                  rightLightNode.light = SCNLight()
                  rightLightNode.light?.type = .omni
                  rightLightNode.light?.intensity = 1100
                  rightLightNode.light?.shadowRadius = 300
                  rightLightNode.position = SCNVector3( x:1000, y:400, z:1600 )
                  rightLightNode.rotation = SCNVector4(0, 1, 0, 0.8)
                  cameraNode.addChildNode(rightLightNode)
                  
                  
                  let centerLightNode = SCNNode()
                  centerLightNode.light = SCNLight()
                  centerLightNode.light?.type = .omni
                  // centerLightNode.light?.color = CGColor(srgbRed: 231, green: 92, blue: 16, alpha: 1)
                  centerLightNode.light?.intensity = 600
                  centerLightNode.position = SCNVector3( x:-0.2, y:-0.04, z:-1.2 )
                  centerLightNode.rotation = SCNVector4(0, 1, 0, -0.8)
                  centerLightNode.light?.castsShadow = false
                  cameraNode.addChildNode(centerLightNode)
                  
                  // let stars = SCNParticleSystem(named: "StarsParticles.scnp", inDirectory: nil)!
                  // scene.rootNode.addParticleSystem(stars)
                  
                  let planetNode = PlanetNode(id: Int(xurVM.xur.locationID!)!)
                  scene.rootNode.addChildNode(planetNode)
              }else {
                  let stars = SCNParticleSystem(named: "StarsParticlesRoaming.scnp", inDirectory: nil)!
                  scene.rootNode.addParticleSystem(stars)
              }
              // assign en scene
              planet.scene = scene
        
        return planet
    }

    func updateUIView(_ planet: SCNView, context: Context) {
            
        // se fps og timing
        planet.showsStatistics = false
            
        // sort bakgrunn
        planet.backgroundColor = UIColor.clear
        
        // planet.autoenablesDefaultLighting = true
        
            
        // mulighet til a kontrollere kamera
        planet.allowsCameraControl = false
        
        planet.preferredFramesPerSecond = xurVM.xur.isHere == "1" ? 30 : 30
    }
    
    func dismantleUIView(_ planet: SCNView, context: Context) {
        planet.scene?.rootNode.enumerateChildNodes { (node, stop) in
             node.removeFromParentNode()
        }
    }
}


#if DEBUG
struct ScenekitView_Previews : PreviewProvider {
    
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return PlanetView(xurVM: xurPreviewVM)
    }
}
#endif

