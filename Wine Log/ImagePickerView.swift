//
//  ImagePickerView.swift
//  Wine Log
//
//  Created by parker amundsen on 8/27/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var showImagePicker: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(showImagePicker: .constant(false), image: .constant(nil))
    }
}
