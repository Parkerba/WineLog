//
//  WineView.swift
//  Wine Log
//
//  Created by parker amundsen on 8/23/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import SwiftUI

struct WineView: View {
    
    enum Constants {
        
        static let nameTitle: String = "Name:"
        static let colorTitle: String = "Color:"
        static let typeTitle: String = "Type:"
        static let regionTitle: String = "Region:"
        static let detailsTitle: String = "Details:"
    }
    
    @EnvironmentObject var wineLog: WineLog
    
    @State private(set) var wine: Wine
    @State var presentDetailView: Bool = false
    @State var presentConfirmDeleteView: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            self.bodyForSize(geo.size)
        }
    }
    
    func bodyForSize(_ size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: SystemConstants.cornerRadiusLargerElement).stroke()
            VStack(alignment: .center) {
                wine.getImage().resizable().aspectRatio(wine.aspectRatio, contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(Constants.detailsTitle)
                        .bold()
                        .underline()
                    Text("\(Constants.nameTitle) \(wine.name)")
                    Text("\(Constants.colorTitle) \(wine.color.rawValue)")
                    Text("\(Constants.typeTitle) \(wine.type)")
                    Text("\(Constants.regionTitle) \(wine.region)")
                }
                Spacer()
                HStack {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .frame(minWidth: 0,
                               maxWidth: 25,
                               minHeight: 0,
                               maxHeight: 25)
                        .onTapGesture {
                            self.presentDetailView.toggle()
                    }
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .frame(minWidth: 0,
                               maxWidth: 25,
                               minHeight: 0,
                               maxHeight: 25)
                        .onTapGesture {
                            self.presentConfirmDeleteView.toggle()
                    }
                }
            }.font(.system(.callout, design: .monospaced))
                .padding()
        }.frame(width: size.width, height: size.height)
            .alert(isPresented: $presentConfirmDeleteView, content: { () -> Alert in
                Alert(title: Text("Delete wine named \(wine.name)?"),
                      primaryButton: .default(Text("Confirm"), action: {
                        self.wineLog.removeWine(self.wine)
                      }), secondaryButton: .cancel())
            })
            .sheet(isPresented: $presentDetailView, onDismiss: {
                self.wineLog.updateWinesTasted(self.wine)
            }) {
                WineDetailView(wine: self.$wine, shouldShow: self.$presentDetailView)
        }
    }
    
}



struct WineView_Previews: PreviewProvider {
    static var previews: some View {
        WineView(wine: Wine(id: UUID().uuidString, color: .white,
                      name: "Parker's Pinot",
                      type: "Pinot Grigio",
                      region: "Sonoma County"))
    }
}
