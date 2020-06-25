//
//  DetailedPersonView.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/24/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct DetailedPersonView: View {
    @State private var editScreenPresented = false
    let person: Person
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: UIImage(data: person.photoData)!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                MapView(latitude: person.latitude, longitude: person.longitude)
                    .frame(height: 150)
                    .cornerRadius(20)
                HStack(alignment: .bottom) {
                    Text(person.name)
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(person.emailAddress ?? "Unavailable")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text(person.phoneNumber ?? "Unavailable")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: Button("Edit") {
                self.editScreenPresented.toggle()
            })
            .sheet(isPresented: $editScreenPresented, content: {
                EditPersonScreen(person: self.person)
        })
        }
    }
}



struct DetailedPersonView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let examplePerson = Person(context: context)
        examplePerson.emailAddress = "test@test.com"
        examplePerson.id = UUID()
        examplePerson.phoneNumber = "1233455678"
        examplePerson.name = "Test Person"
        examplePerson.photoData = Data.init(capacity: 0)
        return DetailedPersonView(person: examplePerson)
    }
}
