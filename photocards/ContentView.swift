//
//  ContentView.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/21/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Person.entity() , sortDescriptors: [
        NSSortDescriptor(keyPath: \Person.name, ascending: true),
        NSSortDescriptor(keyPath: \Person.photoData, ascending: true)
    ]) var fetchedPeopleList: FetchedResults<Person>
    
    @State private var addPersonOpen = false
    @State private var isUnlocked = false
    
    var body: some View {
        NavigationView {
            if isUnlocked {
                Group {
                    if fetchedPeopleList.isEmpty {
                        EmptyMainListView(addPersonOpen: $addPersonOpen)
                    } else {
                        List (fetchedPeopleList) { person in
                            NavigationLink(destination: DetailedPersonView(person: person), label: {
                                HStack {
                                    Image(uiImage: (UIImage(data: person.photoData ?? Data.init(capacity: 0)) ?? UIImage(data: Data.init(count: 0)))!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                    Text(person.name)
                                }
                            })
                        }
                    }
                }
                .navigationBarTitle("My Network")
                .navigationBarItems(trailing: Button(action: {
                    self.addPersonOpen = true
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                }))
                .sheet(isPresented: $addPersonOpen, content: {
                    AddPerson().environment(\.managedObjectContext, self.managedObjectContext)
                })
            } else {
                Button("Unlock", action: {
                    self.authenticate()
                })
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to use the features of this application"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked =  true
                    } else {
                        
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


