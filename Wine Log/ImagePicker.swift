//
//  ImagePicker.swift
//  Wine Log
//
//  Created by parker amundsen on 8/27/20.
//  Copyright © 2020 Parker Amundsen. All rights reserved.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image = pickedImage
        isShown = false
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

}

