//
//  ContentView.swift
//  ioscamera_project
//
//  Created by Anna Topping on 4/14/26.
// tutorial https://www.youtube.com/watch?v=hB8MTEJj3CA
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItem:
        PhotosPickerItem? // holds selected photo
    @State private var selectedImage:
        UIImage? // holds loaded image
    @State private var showingCamera = false // control camera sheet visibility

    var body: some View {
        VStack {
    // display the selected image or placeholder
           if let selectedImage =
                selectedImage {
               Image(uiImage: selectedImage)
                   .resizable()
                   .scaledToFit()
                   .frame(height: 300)
                   .cornerRadius(25)
           }else {
               Text("No image selected :(")
                   .padding()
                   .foregroundStyle(
                    .gray
                   )
           }

            
            Button(action: {
                showingCamera = true // show the camera view
            }){
                Text("Take Photo")
                    .font(.headline)  .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(25)
            }
            .sheet(isPresented: $showingCamera){
                CameraView(image: $selectedImage)
            }
            
           //photo picker button
            
            PhotosPicker(
                selection: $selectedItem,
                // bind to the selected item
                matching: .images, //show only images
                photoLibrary: .shared()
            ){
                Text("Select Photo")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(25)
            }
            .onChange(of:
                    selectedItem){
                    newItem in
                // handle selected item
                if let newItem = newItem{
                    Task{
                        if let data = try? await newItem.loadTransferable(type: Data.self),
                           let image = UIImage(data: data){
                            selectedImage = image} // update the selected image

                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
