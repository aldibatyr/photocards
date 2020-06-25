//
//  EditPersonScreen.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/24/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct EditPersonScreen: View {
    let person: Person
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditPersonScreen_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let examplePerson = Person(context: context)
        examplePerson.emailAddress = "test@test.com"
        examplePerson.id = UUID()
        examplePerson.phoneNumber = "1233455678"
        examplePerson.name = "Test Person"
        examplePerson.photoData = Data.init(capacity: 0)
        return EditPersonScreen(person: examplePerson)
    }
}
