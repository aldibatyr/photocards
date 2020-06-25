//
//  EmptyMainListView.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/23/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct EmptyMainListView: View {
    @Binding var addPersonOpen: Bool
    
    var body: some View {
        VStack {
            Text("Add Some People")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Image("addPeople")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
        }
        .padding(.all, 20)
        .background(
            Image("5")
                .resizable()
                .blur(radius: 2)
        )
            .cornerRadius(20)
            .shadow(radius: 20)
            .onTapGesture {
                self.addPersonOpen = true
        }
    }
}

struct EmptyMainListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMainListView(addPersonOpen: .constant(false))
    }
}
