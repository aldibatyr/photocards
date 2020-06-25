//
//  AddPerson.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/21/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct AddPerson: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var personName = ""
    @State private var personEmail = ""
    @State private var personPhoneNumber = ""
    @State private var imagePickerPresented = false
    @State private var image: UIImage?
    @State private var processedImage: Image?
    @State private var minimizeRectangle = false
    @State private var userChosePhotoAlbum = false
    @State private var actionSheetPresented = false
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    let locationFetcher = LocationFetcher()
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color("Accent").opacity(0.5))
                    .frame(height: minimizeRectangle ? 100 : 300)
                if processedImage != nil {
                    PersonImageAvailableView(image: processedImage ?? Image("notAvailable"))
                        .frame(height: minimizeRectangle ? 100 : 300)
                        .offset(x: minimizeRectangle ? -100 : 0, y: 0)
                        .background(Image("8"))
                } else {
                    Button("Add Person Image") {
                        self.actionSheetPresented = true
                    }
                }
            }
            Form {
                TextField("Name", text: $personName)
                    .onTapGesture {
                        withAnimation {
                            self.minimizeRectangle = true
                        }
                }
                TextField("Email", text: $personEmail)
                    .keyboardType(.emailAddress)
                TextField("Phone Number", text: $personPhoneNumber, onCommit: {
                    withAnimation {
                        self.minimizeRectangle = false
                    }
                })
                    .keyboardType(.phonePad)
                HStack {
                    Text("\(latitude)")
                    Spacer()
                    Text("\(longitude)")
                }
                Button("Add Location") {
                    if let location = self.locationFetcher.lastKnownLocation {
                        print(location)
                        self.latitude = location.latitude
                        self.longitude = location.longitude
                    }
                    
                }
                Button("Save") {
                    self.addPerson()
                }
            }
                
            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                ImagePicker(image: self.$image, userChosePhotoAlbum: self.$userChosePhotoAlbum)
                    .edgesIgnoringSafeArea(.bottom)
            })
                .actionSheet(isPresented: $actionSheetPresented, content: {
                    ActionSheet(title: Text("Import Image"), buttons: [
                        .default(Text("Camera"), action: {
                            self.userChosePhotoAlbum = false
                            self.imagePickerPresented = true
                        }),
                        .default(Text("Photo Library"), action: {
                            self.userChosePhotoAlbum = true
                            self.imagePickerPresented = true
                        }),
                        .cancel()
                    ])
                })
            .onAppear(perform: {
                self.locationFetcher.start()
            })
        }
    }
    
    func addPerson() {
        let newPerson = Person(context: self.managedObjectContext)
        
        if let jpegData = self.image?.jpegData(compressionQuality: 0.8) {
            newPerson.name = self.personName
            newPerson.photoData = jpegData
            newPerson.id = UUID()
            newPerson.emailAddress = self.personEmail
            newPerson.phoneNumber = self.personPhoneNumber
            newPerson.latitude = self.latitude
            newPerson.longitude = self.longitude
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    func loadImage() {
        guard let image = image else { return }
        processedImage = Image(uiImage: image)
    }
}

struct AddPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddPerson()
    }
}
