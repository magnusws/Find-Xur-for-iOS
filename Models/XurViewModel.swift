//
//  XurClass.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 08/01/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let xurViewModel = try XurViewModel(json)

import Foundation
import SwiftUI
import Alamofire
import CoreData

// MARK: - XurViewModel
class XurViewModel: ObservableObject, Codable {
    static let xurURL = XUR_API_URL

    @Published var xur: XurClass
    @Published var inventory: InventoryClass?
    @Published var invItems: Array<InventoryItem>
    @Published var secondsUntilNext: Int
    
    enum CodingKeys: CodingKey {
        case xur, inventory
    }
    
    // Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("xurVM")
    
    // Initializers
    
    init() {
        // Laster om mulig data fra fil, hvis ikke: default values
        self.xur = loadXur()
        self.inventory = loadInventory()
        self.invItems = []
        self.secondsUntilNext = 0
        updateInventoryItems()
    }
    
    init(testData: Bool) {
        
        self.xur = defaultXurData()
        self.inventory = defaultInventoryData()
        self.invItems = []
        self.secondsUntilNext = 800
    }

    init(xur: XurClass, inventory: InventoryClass?) {
        self.xur = xur
        self.inventory = inventory
        self.invItems = []
        self.secondsUntilNext = 0
        // ??? usikkert om update inv items skal vare mer her
        updateInventoryItems()
        updateSecondsUntilNext()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        xur = try container.decode(XurClass.self, forKey: .xur)
        inventory = try container.decode(InventoryClass.self, forKey: .inventory)
        self.invItems = []
        self.secondsUntilNext = 0
        updateSecondsUntilNext()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(xur, forKey: .xur)
        try container.encode(inventory, forKey: .inventory)
    }
}

// MARK: XurViewModel convenience initializers and mutators

extension XurViewModel {
    convenience init(data: Data) {
        do {
            let me = try xJSONDecoder().decode(XurViewModel.self, from: data)
            self.init(xur: me.xur, inventory: me.inventory)
        } catch {
            self.init(xur: defaultXurData(), inventory: defaultInventoryData())
        }
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        self.init(data: try Data(contentsOf: url))
    }

    func with(
        xur: XurClass?? = nil,
        inventory: InventoryClass?? = nil
    ) -> XurViewModel {
        return XurViewModel(
            xur: self.xur,
            inventory: inventory ?? self.inventory
        )
    }

    func jsonData() throws -> Data {
        return try xJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    //MARK: Save data
    func save() {
        self.xur.save()
        if self.inventory?.id != "0" {
            self.inventory!.save()
        }
    }
    
    func load() {
            self.xur = loadXur()
            self.inventory = loadInventory()
    }
    
    // MARK: Fetch data (fra Xur API)
    func fetch()  {
        
        // kontrollerer at url er gyldig
        guard let url = URL(string: XurViewModel.xurURL) else {
          print("Missing a valid API base URL.")
            return
        }
        
        // Xur API Request
        AF.request(url, method: .get, parameters:nil)
        .validate()
        .responseJSON { response in
            
            // kontrollerer at respons inneholdt noen verdi
            guard response.value != nil else {
                print("Error while fetching item")
                return
            }
            
            // kontrollerer at data ble mottatt i respons
            guard let JsonData = response.data as Data? else {
                print("Malformed data received from fetchXur service")
                return
            }
            
            // dekoder json-data
            let newData = try? xJSONDecoder().decode(XurViewModel.self, from: JsonData)
            print("Json Data Recieved:\n\(JsonData)")
            print("New Data ID: \(String(describing: newData?.xur.id ?? "0"))")
            
            // hvis json-data ble dekodet
            if newData != nil {
                
                // xur-objekt oppdateres med nye verdier
                self.xur = newData!.xur
                self.inventory = newData!.inventory!
                self.updateInventoryItems()
                
                // lagrer nye verdier til fil
                newData!.xur.save()
                newData!.inventory!.save()
                
                let defaults = UserDefaults.standard
                
                if newData!.xur.nextUpdate != nil {
                    var nextString = newData!.xur.nextUpdate!
                    // ordner saa dato string er paa riktig format
                    nextString.insert(contentsOf: ":", at: nextString.index(nextString.endIndex, offsetBy: -2))
                    defaults.set(nextString, forKey: "nextUpdate")
                }
                
            }
        }
        
    }
    
    private func updateInventoryItems() {
        
        if self.inventory?.itemHash1 != nil {
            
            let itemHashes = [
                Int(self.inventory!.itemHash1!)!,
                Int(self.inventory!.itemHash2!)!,
                Int(self.inventory!.itemHash3!)!,
                Int(self.inventory!.itemHash4!)!,
                Int(4285666432)
            ]
            
            self.invItems = []
                
            for hash in itemHashes {
                for item in items {
                    if hash == item.hash! {
                        self.invItems.append(item)
                    }
                }
            }
            
        }
    }
    
    // Returnerer array med item objekter i naavarende inventory
    
    func inventoryItems()-> [InventoryItem] {
        var invItems: Array<InventoryItem> = []
        
        let itemHashes = [
            Int(self.inventory!.itemHash1!)!,
            Int(self.inventory!.itemHash2!)!,
            Int(self.inventory!.itemHash3!)!,
            Int(self.inventory!.itemHash4!)!,
            Int(4285666432)
        ]
            
        for hash in itemHashes {
            for item in items {
                if hash == item.hash! {
                    invItems.append(item)
                }
            }
        }
        return invItems
    }
    
    func inventoryItemHashes()-> [Int] {
        
        var itemHashes: [Int] = []
        
        itemHashes = [
            Int(self.inventory!.itemHash1!)!,
            Int(self.inventory!.itemHash2!)!,
            Int(self.inventory!.itemHash3!)!,
            Int(self.inventory!.itemHash4!)!,
            Int(4285666432)
        ]
        
        return itemHashes
    }
    
    func updateSecondsUntilNext() {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM d yyyy HH:mm:ss ZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 7200)
        
        let now = Date()
        var nextString = "December 24 2020 19:00:00 GMT+0200"
        
        if self.xur.nextUpdate != nil {
            // String med dato for neste oppdatering
            nextString = self.xur.nextUpdate!
            // ordner saa dato string er paa riktig format
            nextString.insert(contentsOf: ":", at: nextString.index(nextString.endIndex, offsetBy: -2))
        }
        
        // string med naavarende dato
        let nowString = formatter.string(from: now)
                 
        let nowDate = formatter.date(from: nowString)!
        let nextDate = formatter.date(from: nextString)!
                 
        let timeSinceReferenceNow = nowDate.timeIntervalSinceReferenceDate
        let timeSinceReferenceNext = nextDate.timeIntervalSinceReferenceDate
        
        // diff i tid til/siden neste oppdatering og naa
        self.secondsUntilNext = Int(timeSinceReferenceNext - timeSinceReferenceNow)
    }
    
    
}


// MARK: - Helper functions for creating encoders and decoders

func xJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func xJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: Data functions

func loadXur() -> XurClass {
    // returnerer lagret data som nytt Xur objekt
    return (NSKeyedUnarchiver.unarchiveObject(withFile: XurClass.ArchiveURL.path) as? XurClass)
        // hvis ikke det finnes noen fil med data, returnerer default values
        ?? defaultXurData()
}

// MARK: Load Inventory data
// Hvis inventory data finnes på enhet, laster inn lagret data
// Hvis det ikke finnes inventory data pa enhet: default verdier

func loadInventory() -> InventoryClass {
    // returnerer lagret data som nytt Xur objekt
    
    return (NSKeyedUnarchiver.unarchiveObject(withFile: InventoryClass.ArchiveURL.path) as? InventoryClass)
        // hvis ikke det finnes noen fil med data, returnerer default values
        ?? defaultInventoryData()
}

func defaultXurData() -> XurClass {
    // returnerer generisk data som nytt Xur objekt
    return XurClass(
            id: "10",
            dateTime: "0",
            locationID: "0",
            inventoryID: "106",
            isHere: "0",
            nextUpdate: "January 24 2020 19:00:00 GMT+0200"
    )
}

func defaultInventoryData() -> InventoryClass {
    // returnerer lagret data som nytt Xur objekt
    
    return InventoryClass(
            id: "0",
            itemHash1: "0",
            itemHash2: "0",
            itemHash3: "0",
            itemHash4: "0"
    )
}
