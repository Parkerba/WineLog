//
//  WineLog.swift
//  Wine Log
//
//  Created by parker amundsen on 8/24/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import SwiftUI

class WineLog: ObservableObject {

    @Published private var winesTasted: [Wine]
    
    init() {
        winesTasted = WineLogArchiver.readWineLog()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
        
    func updateWinesTasted(_ wine: Wine) {
        if let index = (winesTasted.firstIndex { $0.id == wine.id }) {
            winesTasted[index] = wine
        } else {
            winesTasted.append(wine)
        }
    }
    
    func getWinesTasted() -> [Wine] {
        return winesTasted
    }
    
    func removeWine(_ wine: Wine) {
        if let indexToRemove = (winesTasted.firstIndex { $0.id == wine.id }) {
            winesTasted.remove(at: indexToRemove)
        }
    }
    
    @objc func appMovedToBackground() {
        WineLogArchiver.saveWineLog(wineLog: winesTasted)
    }
    
}
