//
//  Network.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 02/01/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import Foundation

var manifestBaseURL = MANIFEST_BASE_URL
var exoticsURL = EXOTICS_API_URL
var xurURL = XUR_API_URL
var apiKey = API_KEY
var userName = API_USERNAME

var exoticParameter = "exotics"

struct xurParameters: Encodable {
    let request: String
}

struct ItemParameters: Encodable {
  let request: String
  let table_name: String
  let hash: String
}

struct InventoryParameters: Encodable {
    let request: String
    let id: Int
}
