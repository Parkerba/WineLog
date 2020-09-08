//
//  WineDetailView.swift
//  Wine Log
//
//  Created by parker amundsen on 8/24/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import SwiftUI

struct WineDetailView: View {
    @Binding var wine: Wine
    
    @State var showImagePickerView: Bool = false
    @State var image: UIImage? = nil
    
    @State var colorSelection: Int
    var wineType: [WineColor] = [.red, .rosé, .white]
    
    @State var bodySelection: Int
    var wineBody: [WineBody] = [.lightBody, .mediumBody, .fullBody]
    
    @State var aciditySelection: Int
    @State var sweetnessSelection: Int
    @State var tanninSelection: Int
    @Binding var showSelf: Bool
    var generalizedRanking: [GeneralizedRanking] = [.none, .low, .medium, .high]
    
    var displayImage: Image {
        if let image = image {
            print(image.size)
            return Image(uiImage: image)
        }
        return wine.getImage()
    }
    
    var aspectRatio: CGFloat? {
        guard let width = image?.size.width, let height = image?.size.height else {
            return wine.aspectRatio
        }
        return width/height
    }
    
    init(wine: Binding<Wine>, shouldShow: Binding<Bool>) {
        _wine = wine
        _colorSelection = State(initialValue:wineType.firstIndex(of: wine.color.wrappedValue) ?? 0)
        _aciditySelection = State(initialValue: generalizedRanking.firstIndex(of: wine.acidity.wrappedValue) ?? 0)
        _tanninSelection = State(initialValue: generalizedRanking.firstIndex(of: wine.tannin.wrappedValue) ?? 0)
        _aciditySelection = State(initialValue: generalizedRanking.firstIndex(of: wine.acidity.wrappedValue) ?? 0)
        _sweetnessSelection = State(initialValue: generalizedRanking.firstIndex(of: wine.sweetness.wrappedValue) ?? 0)
        _bodySelection = State(initialValue: wineBody.firstIndex(of: wine.body.wrappedValue) ?? 0)
        _showSelf = shouldShow
    }
    
    var body: some View {
        return ScrollView {
            Image(systemName: "camera.circle.fill")
                .resizable()
                .frame(minWidth: 25, maxWidth: 25, minHeight: 25, maxHeight: 25)
                .onTapGesture {
                    self.showImagePickerView.toggle()
            }.sheet(isPresented: $showImagePickerView) {
                 ImagePickerView(showImagePicker: self.$showImagePickerView, image: self.$image)
            }
            displayImage.resizable().aspectRatio(aspectRatio, contentMode: .fit).onTapGesture {
                self.showImagePickerView.toggle()
            }
            VStack (alignment: .leading) {
                TextField("Name...", text: $wine.name)
                TextField("Type...", text: $wine.type)
                TextField("Region...", text: $wine.region)
                Text("Overall Rating: " + String(format: "%.1f", wine.overallRating))
                Slider(value: $wine.overallRating, in: 0...10)
                
                Text("ABV: " + String(format: "%.1f", wine.ABV) + "%")
                Slider(value: $wine.ABV, in: 0...20)
                VStack (alignment: .leading) {
                    Text("Color:")
                    Picker(selection: $colorSelection, label: Text("Wine Color:")) {
                        ForEach(0..<wineType.count) { index in
                            Text(self.wineType[index].rawValue).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("Acidity:")
                    Picker(selection: $aciditySelection, label: Text("Wine Acidity:")) {
                        ForEach(0..<generalizedRanking.count) { index in
                            Text(self.generalizedRanking[index].rawValue).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("Tannin:")
                    Picker(selection: $tanninSelection, label: Text("Wine Tannin:")) {
                        ForEach(0..<generalizedRanking.count) { index in
                            Text(self.generalizedRanking[index].rawValue).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("Sweetness:")
                    Picker(selection: $sweetnessSelection, label: Text("Wine Sweetness:")) {
                        ForEach(0..<generalizedRanking.count) { index in
                            Text(self.generalizedRanking[index].rawValue).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Notes..", text: $wine.notes)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.wine.color = self.wineType[self.colorSelection]
                            self.wine.acidity = self.generalizedRanking[self.aciditySelection]
                            self.wine.tannin = self.generalizedRanking[self.tanninSelection]
                            self.wine.sweetness = self.generalizedRanking[self.sweetnessSelection]
                            self.showSelf.toggle()
                            self.wine.image = self.image?.pngData()
                            self.wine.aspectRatio = self.aspectRatio
                            self.wine.imageOrientation = self.image?.imageOrientation.rawValue ?? 0
                        }) {
                            Text("  Done  ")
                                .font(.system(.title, design: .monospaced))
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(SystemConstants.cornerRadiusSmallElement)
                        }
                        Spacer()
                    }
                }
            }
            .keyboardResponsive()
        }
        .padding()
        .font(.system(.body, design: .monospaced))
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WineDetailView(wine: .constant(Wine(id: "22", color: .rosé, name: "Some wine", type: "Something", region: "WA")), shouldShow: State(initialValue: true).projectedValue)
    }
}
