//
//  Wine.swift
//  Wine Log
//
//  Created by parker amundsen on 8/23/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import Foundation
import SwiftUI

enum GeneralizedRanking: String, Codable {
    case none = "-"
    case low = "low"
    case medium = "medium"
    case high = "high"
}

enum WineColor: String, Codable {
    case white = "white"
    case red = "red"
    case rosé = "rosé"
}

enum WineBody: String, Codable {
    case none = "-"
    case lightBody = "light-bodied"
    case mediumBody = "medium-bodied"
    case fullBody = "full-bodied"
}

struct Wine: Identifiable, Codable {
    var id: String = UUID().uuidString
    var color: WineColor = .red
    var body: WineBody = .lightBody
    var tannin: GeneralizedRanking = .none
    var acidity: GeneralizedRanking = .none
    var sweetness: GeneralizedRanking = .none
    var ABV: Double = 0
    var name: String = ""
    var type: String = ""
    var region: String = ""
    var notes: String = ""
    var overallRating: Double = 0
    var image: Data?
    var imageOrientation: Int = 0
    var aspectRatio: CGFloat? = nil
    
    mutating func setImage(_ image: UIImage) {
        self.image = image.jpegData(compressionQuality: 1)
    }
    
    func getImage() -> Image {
        if let data = image {
            if let uiImage = UIImage(data:data) {
                let cgImage = uiImage.cgImage!
                let correctImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: UIImage.Orientation(rawValue: imageOrientation)!)
                if (imageOrientation == 3) {
                    return Image(uiImage: correctImage)
                }
                return Image(uiImage: correctImage)
            }
        }
        switch self.color {
        case .white:
            return Image(SystemConstants.whiteWineImageName)
        case .rosé:
            return Image(SystemConstants.roséWineImageName)
        default:
            return Image(SystemConstants.redWineImageName)
        }
    }
    
}
