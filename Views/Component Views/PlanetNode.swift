import SceneKit
import SwiftUI

class PlanetNode: SCNNode {
  
  init(id: Int) {
    super.init()
    self.geometry = SCNSphere(radius: 1.1)
    //self.opacity = 0.0
    
    switch id {
    // IO
    case 3:
      self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "IoTexture")
      self.geometry?.firstMaterial?.specular.contents = UIImage(named: "IoTextureSpecular")
      self.geometry?.firstMaterial?.normal.contents = UIImage(named: "IoTextureNormal")
      self.geometry?.firstMaterial?.emission.contents = UIColor.yellow
      self.geometry?.firstMaterial?.emission.intensity = 0.04
      self.geometry?.firstMaterial?.shininess = 40
    // Titan
    case 4:
      self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "titanTexture9")
      self.geometry?.firstMaterial?.specular.contents = UIImage(named: "titanTextureSpecular")
      self.geometry?.firstMaterial?.normal.contents = UIImage(named: "titanTextureNormal")
      self.geometry?.firstMaterial?.emission.contents = UIImage(named: "titanTextureEmission")
      self.geometry?.firstMaterial?.emission.intensity = 0.02
      self.geometry?.firstMaterial?.shininess = 40
    // Earth
    case 2:
      self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "4k_earth_daymap_light")
      self.geometry?.firstMaterial?.specular.contents = UIImage(named: "4k_earth_specular_map")
      // self.geometry?.firstMaterial?.normal.contents = UIImage(named: "4k_earth_normal_map")
      self.geometry?.firstMaterial?.emission.contents = UIImage(named: "4k_earth_emission")
      self.geometry?.firstMaterial?.emission.intensity = 0.6
      self.geometry?.firstMaterial?.shininess = 40
      // Nessus
      case 5:
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "nessusTexture3")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named: "nessusTextureSpecular")
        self.geometry?.firstMaterial?.normal.contents = UIImage(named: "nessusTextureNormal")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named: "nessusEmissionNew")
        self.geometry?.firstMaterial?.emission.intensity = 0.2
        self.geometry?.firstMaterial?.shininess = 40
        
    default:
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "4k_earth_daymap_light")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named: "4k_earth_specular_map")
        // self.geometry?.firstMaterial?.normal.contents = UIImage(named: "4k_earth_normal_map")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named: "4k_earth_emission")
        self.geometry?.firstMaterial?.emission.intensity = 0.6
        self.geometry?.firstMaterial?.shininess = 40
    }
    //self.animateIn()
    var action = SCNAction()
    
    // Correct rotation for Earth
    if id == 2 || id < 2 || id > 5 {
        action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3( 0, 1, 0 ), duration: 220)
    } else {
        action = SCNAction.rotate(by: -360 * CGFloat(Double.pi / 180), around: SCNVector3( 0, 1, 0 ), duration: 220)
    }
    
    let repeatAction = SCNAction.repeatForever(action)
    
    self.runAction(repeatAction)
  }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
}
