//
//  CameraView.swift
//  ioscamera_project
//
//  Created by Anna Topping on 4/20/26.
//

import Foundation
import SwiftUI
import UIKit
struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage? // bind to parent views state
    @Environment (\.presentationMode) var presentationMode // dismiss when view is done
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController() //create camera picker
        picker.delegate = context.coordinator  // set the coordinator as delegate
        picker.sourceType = .camera //set source to camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // no updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage{
                parent.image = image // pass selected image to parent
            }
            parent.presentationMode.wrappedValue.dismiss() // dismiss the picker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss() // dismiss on cancel
        }
        
    }
    
    
}
