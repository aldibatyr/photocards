//
//  PersonImageAvailableView.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/23/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//

import SwiftUI

struct PersonImageAvailableView: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.secondary, lineWidth: 5)
        )
        .padding()
        .shadow(radius: 20)
    }
}

struct PersonImageAvailableView_Previews: PreviewProvider {
    static let image = Image("examplePerson")
    static var previews: some View {
        PersonImageAvailableView(image: image)
    }
}
