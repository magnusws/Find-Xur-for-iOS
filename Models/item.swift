//
//  item.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 03/01/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI

// MARK: - InventoryItem
class InventoryItem: Codable, Identifiable {
    let hash, index: Int?
    let perks: [JSONAny]?
    let stats: Stats?
    let action: Action?
    let preview: Preview?
    let quality: Quality?
    let sockets: Sockets?
    let itemType, loreHash: Int?
    let redacted: Bool?
    let classType: Int?
    let inventory: Inventory?
    let isWrapper, equippable: Bool?
    let screenshot: String?
    let talentGrid: TalentGrid?
    let blacklisted: Bool?
    let breakerType, itemSubType: Int?
    let allowActions: Bool?
    let displaySource: String?
    let equippingBlock: EquippingBlock?
    let backgroundColor: BackgroundColor?
    let collectibleHash: Int?
    let investmentStats: [InvestmentStat]?
    let specialItemType, summaryItemHash: Int?
    let nonTransferrable: Bool?
    let translationBlock: TranslationBlock?
    let acquireUnlockHash, defaultDamageType: Int?
    let displayProperties: DisplayProperties?
    let itemCategoryHashes: [Int]?
    let uiItemDisplayStyle, itemTypeDisplayName: String?
    let tooltipNotifications: [JSONAny]?
    let acquireRewardSiteHash: Int?
    let itemTypeAndTierDisplayName: String?
    let doesPostmasterPullHaveSideEffects: Bool?

    init(hash: Int?, index: Int?, perks: [JSONAny]?, stats: Stats?, action: Action?, preview: Preview?, quality: Quality?, sockets: Sockets?, itemType: Int?, loreHash: Int?, redacted: Bool?, classType: Int?, inventory: Inventory?, isWrapper: Bool?, equippable: Bool?, screenshot: String?, talentGrid: TalentGrid?, blacklisted: Bool?, breakerType: Int?, itemSubType: Int?, allowActions: Bool?, displaySource: String?, equippingBlock: EquippingBlock?, backgroundColor: BackgroundColor?, collectibleHash: Int?, investmentStats: [InvestmentStat]?, specialItemType: Int?, summaryItemHash: Int?, nonTransferrable: Bool?, translationBlock: TranslationBlock?, acquireUnlockHash: Int?, defaultDamageType: Int?, displayProperties: DisplayProperties?, itemCategoryHashes: [Int]?, uiItemDisplayStyle: String?, itemTypeDisplayName: String?, tooltipNotifications: [JSONAny]?, acquireRewardSiteHash: Int?, itemTypeAndTierDisplayName: String?, doesPostmasterPullHaveSideEffects: Bool?) {
        
        self.hash = hash
        self.index = index
        self.perks = perks
        self.stats = stats
        self.action = action
        self.preview = preview
        self.quality = quality
        self.sockets = sockets
        self.itemType = itemType
        self.loreHash = loreHash
        self.redacted = redacted
        self.classType = classType
        self.inventory = inventory
        self.isWrapper = isWrapper
        self.screenshot = screenshot
        self.equippable = equippable
        self.talentGrid = talentGrid
        self.blacklisted = blacklisted
        self.breakerType = breakerType
        self.itemSubType = itemSubType
        self.allowActions = allowActions
        self.displaySource = displaySource
        self.equippingBlock = equippingBlock
        self.backgroundColor = backgroundColor
        self.collectibleHash = collectibleHash
        self.investmentStats = investmentStats
        self.specialItemType = specialItemType
        self.summaryItemHash = summaryItemHash
        self.nonTransferrable = nonTransferrable
        self.translationBlock = translationBlock
        self.acquireUnlockHash = acquireUnlockHash
        self.defaultDamageType = defaultDamageType
        self.displayProperties = displayProperties
        self.itemCategoryHashes = itemCategoryHashes
        self.uiItemDisplayStyle = uiItemDisplayStyle
        self.itemTypeDisplayName = itemTypeDisplayName
        self.tooltipNotifications = tooltipNotifications
        self.acquireRewardSiteHash = acquireRewardSiteHash
        self.itemTypeAndTierDisplayName = itemTypeAndTierDisplayName
        self.doesPostmasterPullHaveSideEffects = doesPostmasterPullHaveSideEffects

    }
    
    func hash(into hasher: inout Hasher) { return hasher.combine(self.hash) }
    
}

// MARK: - Action
class Action: Codable {
    let verbName: String?
    let isPositive, useOnAcquire: Bool?
    let requiredItems: [JSONAny]?
    let deleteOnAction: Bool?
    let rewardItemHash, rewardSiteHash: Int?
    let actionTypeLabel: String?
    let rewardSheetHash: Int?
    let verbDescription: String?
    let consumeEntireStack: Bool?
    let progressionRewards: [JSONAny]?
    let requiredCooldownHash, requiredCooldownSeconds: Int?

    init(verbName: String?, isPositive: Bool?, useOnAcquire: Bool?, requiredItems: [JSONAny]?, deleteOnAction: Bool?, rewardItemHash: Int?, rewardSiteHash: Int?, actionTypeLabel: String?, rewardSheetHash: Int?, verbDescription: String?, consumeEntireStack: Bool?, progressionRewards: [JSONAny]?, requiredCooldownHash: Int?, requiredCooldownSeconds: Int?) {
        self.verbName = verbName
        self.isPositive = isPositive
        self.useOnAcquire = useOnAcquire
        self.requiredItems = requiredItems
        self.deleteOnAction = deleteOnAction
        self.rewardItemHash = rewardItemHash
        self.rewardSiteHash = rewardSiteHash
        self.actionTypeLabel = actionTypeLabel
        self.rewardSheetHash = rewardSheetHash
        self.verbDescription = verbDescription
        self.consumeEntireStack = consumeEntireStack
        self.progressionRewards = progressionRewards
        self.requiredCooldownHash = requiredCooldownHash
        self.requiredCooldownSeconds = requiredCooldownSeconds
    }
}

// MARK: - BackgroundColor
class BackgroundColor: Codable {
    let red, blue, alpha, green: Int?
    let colorHash: Int?

    init(red: Int?, blue: Int?, alpha: Int?, green: Int?, colorHash: Int?) {
        self.red = red
        self.blue = blue
        self.alpha = alpha
        self.green = green
        self.colorHash = colorHash
    }
}

// MARK: - DisplayProperties
class DisplayProperties: Codable {
    let icon, name: String?
    let hasIcon: Bool?
    let displayPropertiesDescription: String?

    enum CodingKeys: String, CodingKey {
        case icon, name, hasIcon
        case displayPropertiesDescription = "description"
    }

    init(icon: String?, name: String?, hasIcon: Bool?, displayPropertiesDescription: String?) {
        // lagrer ikon path paa riktig format
        if icon != nil {
            let temp = icon!
            let startOfTemp = temp.lastIndex(of: "/")!
            let endOfTemp = temp.lastIndex(of: ".")!
            self.icon = String(temp[startOfTemp...endOfTemp])
        } else { self.icon = icon }
    
        self.name = name
        self.hasIcon = hasIcon
        self.displayPropertiesDescription = displayPropertiesDescription
    }
}

// MARK: - EquippingBlock
class EquippingBlock: Codable {
    let ammoType, attributes: Int?
    let uniqueLabel: String?
    let hornSoundHash: Int?
    let displayStrings: [String]?
    let uniqueLabelHash, equippingSoundHash, equipmentSlotTypeHash: Int?

    init(ammoType: Int?, attributes: Int?, uniqueLabel: String?, hornSoundHash: Int?, displayStrings: [String]?, uniqueLabelHash: Int?, equippingSoundHash: Int?, equipmentSlotTypeHash: Int?) {
        self.ammoType = ammoType
        self.attributes = attributes
        self.uniqueLabel = uniqueLabel
        self.hornSoundHash = hornSoundHash
        self.displayStrings = displayStrings
        self.uniqueLabelHash = uniqueLabelHash
        self.equippingSoundHash = equippingSoundHash
        self.equipmentSlotTypeHash = equipmentSlotTypeHash
    }
}

// MARK: - Inventory
class Inventory: Codable {
    let tierType, maxStackSize, tierTypeHash: Int?
    let tierTypeName: String?
    let bucketTypeHash: Int?
    let isInstanceItem: Bool?
    let expirationTooltip, expiredInOrbitMessage: String?
    let recoveryBucketTypeHash: Int?
    let expiredInActivityMessage: String?
    let nonTransferrableOriginal, suppressExpirationWhenObjectivesComplete: Bool?

    init(tierType: Int?, maxStackSize: Int?, tierTypeHash: Int?, tierTypeName: String?, bucketTypeHash: Int?, isInstanceItem: Bool?, expirationTooltip: String?, expiredInOrbitMessage: String?, recoveryBucketTypeHash: Int?, expiredInActivityMessage: String?, nonTransferrableOriginal: Bool?, suppressExpirationWhenObjectivesComplete: Bool?) {
        self.tierType = tierType
        self.maxStackSize = maxStackSize
        self.tierTypeHash = tierTypeHash
        self.tierTypeName = tierTypeName
        self.bucketTypeHash = bucketTypeHash
        self.isInstanceItem = isInstanceItem
        self.expirationTooltip = expirationTooltip
        self.expiredInOrbitMessage = expiredInOrbitMessage
        self.recoveryBucketTypeHash = recoveryBucketTypeHash
        self.expiredInActivityMessage = expiredInActivityMessage
        self.nonTransferrableOriginal = nonTransferrableOriginal
        self.suppressExpirationWhenObjectivesComplete = suppressExpirationWhenObjectivesComplete
    }
}

// MARK: - InvestmentStat
class InvestmentStat: Codable {
    let value, statTypeHash: Int?
    let isConditionallyActive: Bool?

    init(value: Int?, statTypeHash: Int?, isConditionallyActive: Bool?) {
        self.value = value
        self.statTypeHash = statTypeHash
        self.isConditionallyActive = isConditionallyActive
    }
}

// MARK: - Preview
class Preview: Codable {
    let screenStyle: String?
    let previewVendorHash: Int?
    let previewActionString: String?

    init(screenStyle: String?, previewVendorHash: Int?, previewActionString: String?) {
        self.screenStyle = screenStyle
        self.previewVendorHash = previewVendorHash
        self.previewActionString = previewActionString
    }
}

// MARK: - Quality
class Quality: Codable {
    let itemLevels: [JSONAny]?
    let qualityLevel, infusionCategoryHash: Int?
    let infusionCategoryName: String?
    let infusionCategoryHashes: [Int]?
    let progressionLevelRequirementHash: Int?

    init(itemLevels: [JSONAny]?, qualityLevel: Int?, infusionCategoryHash: Int?, infusionCategoryName: String?, infusionCategoryHashes: [Int]?, progressionLevelRequirementHash: Int?) {
        self.itemLevels = itemLevels
        self.qualityLevel = qualityLevel
        self.infusionCategoryHash = infusionCategoryHash
        self.infusionCategoryName = infusionCategoryName
        self.infusionCategoryHashes = infusionCategoryHashes
        self.progressionLevelRequirementHash = progressionLevelRequirementHash
    }
}

// MARK: - Sockets
class Sockets: Codable {
    let detail: String?
    let socketEntries: [SocketEntry]?
    let intrinsicSockets: [IntrinsicSocket]?
    let socketCategories: [SocketCategory]?

    init(detail: String?, socketEntries: [SocketEntry]?, intrinsicSockets: [IntrinsicSocket]?, socketCategories: [SocketCategory]?) {
        self.detail = detail
        self.socketEntries = socketEntries
        self.intrinsicSockets = intrinsicSockets
        self.socketCategories = socketCategories
    }
}

// MARK: - IntrinsicSocket
class IntrinsicSocket: Codable {
    let plugItemHash: Int?
    let defaultVisible: Bool?
    let socketTypeHash: Int?

    init(plugItemHash: Int?, defaultVisible: Bool?, socketTypeHash: Int?) {
        self.plugItemHash = plugItemHash
        self.defaultVisible = defaultVisible
        self.socketTypeHash = socketTypeHash
    }
}

// MARK: - SocketCategory
class SocketCategory: Codable {
    let socketIndexes: [Int]?
    let socketCategoryHash: Int?

    init(socketIndexes: [Int]?, socketCategoryHash: Int?) {
        self.socketIndexes = socketIndexes
        self.socketCategoryHash = socketCategoryHash
    }
}

// MARK: - SocketEntry
class SocketEntry: Codable {
    let plugSources: Int?
    let defaultVisible: Bool?
    let socketTypeHash: Int?
    let reusablePlugItems: [ReusablePlugItem]?
    let reusablePlugSetHash: Int?
    let overridesUIAppearance: Bool?
    let singleInitialItemHash: Int?
    let hidePerksInItemTooltip, preventInitializationWhenVersioning, preventInitializationOnVendorPurchase: Bool?

    enum CodingKeys: String, CodingKey {
        case plugSources, defaultVisible, socketTypeHash, reusablePlugItems, reusablePlugSetHash
        case overridesUIAppearance = "overridesUiAppearance"
        case singleInitialItemHash, hidePerksInItemTooltip, preventInitializationWhenVersioning, preventInitializationOnVendorPurchase
    }

    init(plugSources: Int?, defaultVisible: Bool?, socketTypeHash: Int?, reusablePlugItems: [ReusablePlugItem]?, reusablePlugSetHash: Int?, overridesUIAppearance: Bool?, singleInitialItemHash: Int?, hidePerksInItemTooltip: Bool?, preventInitializationWhenVersioning: Bool?, preventInitializationOnVendorPurchase: Bool?) {
        self.plugSources = plugSources
        self.defaultVisible = defaultVisible
        self.socketTypeHash = socketTypeHash
        self.reusablePlugItems = reusablePlugItems
        self.reusablePlugSetHash = reusablePlugSetHash
        self.overridesUIAppearance = overridesUIAppearance
        self.singleInitialItemHash = singleInitialItemHash
        self.hidePerksInItemTooltip = hidePerksInItemTooltip
        self.preventInitializationWhenVersioning = preventInitializationWhenVersioning
        self.preventInitializationOnVendorPurchase = preventInitializationOnVendorPurchase
    }
}

// MARK: - ReusablePlugItem
class ReusablePlugItem: Codable {
    let plugItemHash: Int?

    init(plugItemHash: Int?) {
        self.plugItemHash = plugItemHash
    }
}

// MARK: - Stats
class Stats: Codable, Identifiable{
    let id = UUID()
    let stats: [String: Stat]?
    let statGroupHash: Int?
    let hasDisplayableStats: Bool?
    let primaryBaseStatHash: Int?
    let disablePrimaryStatDisplay: Bool?

    init(stats: [String: Stat]?, statGroupHash: Int?, hasDisplayableStats: Bool?, primaryBaseStatHash: Int?, disablePrimaryStatDisplay: Bool?) {
        self.stats = stats
        self.statGroupHash = statGroupHash
        self.hasDisplayableStats = hasDisplayableStats
        self.primaryBaseStatHash = primaryBaseStatHash
        self.disablePrimaryStatDisplay = disablePrimaryStatDisplay
    }
    
    func getStats()-> Array<Stat> {
        var statArray: Array<Stat> = []
        
        stats!.forEach() { key, stat in
            statArray.append(stat)
        }
        
        return statArray
        
    }
    
    func getKeys()-> Array<String> {
        var keyArray: Array<String> = []
        
        stats!.forEach() { key, stat in
            keyArray.append(key)
        }
        
        return keyArray
        
    }
}

// MARK: - Stat
class Stat: Codable, Identifiable, Hashable{
    
    let value, maximum, minimum, statHash: Int?
    let id = UUID()

    init(value: Int?, maximum: Int?, minimum: Int?, statHash: Int?) {
        self.value = value
        self.maximum = maximum
        self.minimum = minimum
        self.statHash = statHash
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Stat, rhs: Stat) -> Bool {
        return lhs.id == rhs.id
    }
    
}

// MARK: - TalentGrid
class TalentGrid: Codable {
    let hudDamageType, talentGridHash: Int?
    let itemDetailString: String?

    init(hudDamageType: Int?, talentGridHash: Int?, itemDetailString: String?) {
        self.hudDamageType = hudDamageType
        self.talentGridHash = talentGridHash
        self.itemDetailString = itemDetailString
    }
}

// MARK: - TranslationBlock
class TranslationBlock: Codable {
    let customDyes, lockedDyes: [JSONAny]?
    let defaultDyes: [DefaultDye]?
    let hasGeometry: Bool?
    let arrangements: [Arrangement]?
    let weaponPatternHash: Int?

    init(customDyes: [JSONAny]?, lockedDyes: [JSONAny]?, defaultDyes: [DefaultDye]?, hasGeometry: Bool?, arrangements: [Arrangement]?, weaponPatternHash: Int?) {
        self.customDyes = customDyes
        self.lockedDyes = lockedDyes
        self.defaultDyes = defaultDyes
        self.hasGeometry = hasGeometry
        self.arrangements = arrangements
        self.weaponPatternHash = weaponPatternHash
    }
}

// MARK: - Arrangement
class Arrangement: Codable {
    let classHash, artArrangementHash: Int?

    init(classHash: Int?, artArrangementHash: Int?) {
        self.classHash = classHash
        self.artArrangementHash = artArrangementHash
    }
}

// MARK: - DefaultDye
class DefaultDye: Codable {
    let dyeHash, channelHash: Int?

    init(dyeHash: Int?, channelHash: Int?) {
        self.dyeHash = dyeHash
        self.channelHash = channelHash
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


func getItemClassType(type: Int)-> String {
    return destinyClassTypes[type]
}

// henter ut kun filnavn til ett bilde fra en url
func getImageName(image: String)-> String{
    
    // Fjerner url før filnavn
    let startTemp = image.lastIndex(of: "/")!
    let endTemp = image.lastIndex(of: ".")!
    let start = image.index(after: startTemp)
    let end = image.index(before: endTemp)
    let nameTemp = String(image[start...end])
    
    return nameTemp
}
