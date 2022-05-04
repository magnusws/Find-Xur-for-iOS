//
//  InventoryClass.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 08/01/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Alamofire
import os.log

// MARK: - Inventory
class InventoryClass:NSObject, NSCoding, Codable {
    var id, itemHash1, itemHash2, itemHash3: String?
    var itemHash4: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemHash1 = "item_hash_1"
        case itemHash2 = "item_hash_2"
        case itemHash3 = "item_hash_3"
        case itemHash4 = "item_hash_4"
    }
    
    struct PropertyKey {
        static let id = "id"
        static let itemHash1 = "item_hash_1"
        static let itemHash2 = "item_hash_2"
        static let itemHash3 = "item_hash_3"
        static let itemHash4 = "item_hash_4"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("inventory")

    init(id: String?, itemHash1: String?, itemHash2: String?, itemHash3: String?, itemHash4: String?) {
        self.id = id
        self.itemHash1 = itemHash1
        self.itemHash2 = itemHash2
        self.itemHash3 = itemHash3
        self.itemHash4 = itemHash4
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(itemHash1, forKey: PropertyKey.itemHash1)
        aCoder.encode(itemHash2, forKey: PropertyKey.itemHash2)
        aCoder.encode(itemHash3, forKey: PropertyKey.itemHash3)
        aCoder.encode(itemHash4, forKey: PropertyKey.itemHash4)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The id is required. If we cannot decode a id string, the initializer should fail.
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? String else {
            os_log("Unable to decode the id for a inventory object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let itemHash1 = aDecoder.decodeObject(forKey: PropertyKey.itemHash1) as? String
        let itemHash2 = aDecoder.decodeObject(forKey: PropertyKey.itemHash2) as? String
        let itemHash3 = aDecoder.decodeObject(forKey: PropertyKey.itemHash3) as? String
        let itemHash4 = aDecoder.decodeObject(forKey: PropertyKey.itemHash4) as? String
        
        // Must call designated initializer.
        self.init(id: id, itemHash1: itemHash1, itemHash2: itemHash2, itemHash3: itemHash3, itemHash4: itemHash4)
    }
}

// MARK: Inventory convenience initializers and mutators

extension InventoryClass {
    convenience init(data: Data) throws {
        let me = try xJSONDecoder().decode(InventoryClass.self, from: data)
        self.init(id: me.id, itemHash1: me.itemHash1, itemHash2: me.itemHash2, itemHash3: me.itemHash3, itemHash4: me.itemHash4)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        itemHash1: String?? = nil,
        itemHash2: String?? = nil,
        itemHash3: String?? = nil,
        itemHash4: String?? = nil
    ) -> InventoryClass {
        return InventoryClass(
            id: id ?? self.id,
            itemHash1: itemHash1 ?? self.itemHash1,
            itemHash2: itemHash2 ?? self.itemHash2,
            itemHash3: itemHash3 ?? self.itemHash3,
            itemHash4: itemHash4 ?? self.itemHash4
        )
    }

    func jsonData() throws -> Data {
        return try xJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    func save() {
        do {
            let data = try NSKeyedArchiver.archivedData(
                withRootObject: self,
                requiringSecureCoding: false
            )
            try data.write(to: InventoryClass.ArchiveURL)
            print("Saved Inventory")
        } catch {
            print(error)
        }
    }
}
