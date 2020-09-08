//
//  WineLogArchiver.swift
//  Wine Log
//
//  Created by parker amundsen on 8/27/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import Foundation

final class WineLogArchiver {
    static let wineLogArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("wineLog.plist")
    }()
    
    @discardableResult
    static func saveWineLog(wineLog: [Wine]) -> Bool {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(wineLog)
            try data.write(to: wineLogArchiveURL, options: [.atomic])
            return true
        } catch {
            return false
        }
    }
    
    static func readWineLog() -> [Wine] {
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: wineLogArchiveURL)
            let wines = try decoder.decode([Wine].self, from: data)
            return wines
        } catch {
            return []
        }
    }
}
