//
//  Data.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 31/12/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire

// MARK: Globale Variable
let destinyClassTypes = ["Titan", "Hunter", "Warlock", ""]
let weaponStatDict: Dictionary = [
    "155624089": "Stability",
    "943549884": "Handling",
    "1240592695": "Range",
    "1345609583": "Aim Assistance",
    "2715839340": "Recoil Direction",
    "2961396640": "Charge Time",
    "3555269338": "Zoom",
    "3871231066": "Magazine",
    "4043523819": "Impact",
    "4188031367": "Reload Speed",
    "4284893193": "Rounds Per Minute",
    "447667954": "Draw Time",
    "1591432999": "Accuracy",
    "3614673599": "Blast Radius",
    "2523465841": "Velocity"
]

let locationDict: Dictionary = [0: "Verifying location", 1: "The Tower", 2: "EDZ", 3: "IO", 4: "Titan", 5: "Nessus", 10: "Roaming the Universe"]

let locDict: Dictionary<Int, String> = [
    0: "One moment please..",
    1: "Hangar, The Last City",
    2: "Winding Cove, EDZ",
    3: "Giant's Scar, Echo Mesa",
    4: "The Rig, New Pacific Arcology",
    5: "The Barge, Watcher's Grave",
    10: "Xur has left."
]


let guideDict: Dictionary<Int, String> = [
    0: "Xur arrived moments ago. Please wait while we verify his location this weekend in D2.",
    1: "This weekend in Destiny 2 Xur is standing behind Dead Orbit in the Tower Hangar.",
    2: "This weekend in Destiny 2 Xur is standing high up on a ledge in Winding cove in the EDZ.",
    3: "This weekend in Destiny 2 Xur is standing in a cave at Giant's Scar on IO.",
    4: "This weekend in D2 Xur is standing in a building near the dock at The Rig on Titan.",
    5: "This weekend in D2 Xur is standing on board the barge at Watchers Grave on Nessus.",
    10: "Xur will arrive again next weekend."
]

let items: [InventoryItem] = loadJsonData("exotics_data.json")
let itemPerks: [InventoryItem] = loadJsonData("perks.json")
let exotics: [InventoryItem] = getExoticItems(items: items)
let titanExotics: [InventoryItem] =  getExoticItems(items: items, type: 0)
let hunterExotics: [InventoryItem] = getExoticItems(items: items, type: 1)
let warlockExotcs: [InventoryItem] = getExoticItems(items: items, type: 2)
let weaponExotics: [InventoryItem] = getExoticItems(items: items, type: 3)

let exoticEngram = getOneItem(items: items, hash: 3875551374)!
let fiveOfSwords = getOneItem(items: items, hash: 4285666432)!

// MARK: Device Token Server Sync

func sendDeviceToken(token: String) {
    
    let apiURL = API_URL

    struct DeviceParameters: Encodable {
        let token: String
    }
    
    let param = DeviceParameters(token: token)
    
            guard let url = URL(string: apiURL) else {
              print("Missing a valid API base URL.")
                return
            }
            
            AF.request(url, method: .get, parameters: param)
            .validate()
            .responseJSON { response in
            
                print("Response value:\n\(response.value ?? "Device offline")")
                
                guard response.value != nil else {
                    print("Error while fetching item")
                    return
                }
                
            }
        
    
}


// MARK: Load / Store Help functions

func loadJsonData<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


func getOneItem(items: [InventoryItem], hash: Int)-> InventoryItem? {
    for item in items {
        if item.hash == hash {
            return item
        }
    }
    return nil
}

func getExoticItems(items: [InventoryItem])-> [InventoryItem] {
    var exotics: [InventoryItem] = []
    
    for item in items {
        if(item.hash != 3875551374 && item.hash != 4285666432) {
            exotics.append(item)
        }
    }
    return exotics
}

func getExoticItems(items: [InventoryItem], type: Int)-> [InventoryItem] {
    var exotics: [InventoryItem] = []
    
    let selectedClass = type
    
    for item in items {
        if(item.hash != 3875551374 && item.hash != 4285666432) {
            if item.classType == selectedClass {
            exotics.append(item)
            }
        }
    }
    return exotics
}

