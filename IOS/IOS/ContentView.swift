//
//  ContentView.swift
//  IOS
//
//  Created by te4 on 2021-11-22.
//

import SwiftUI

struct ContentView: View {
    @State private var isDisplayed = false

    var body: some View {
        Button(action: {
            self.isDisplayed = true
        }) {
            Text("Get activity")
        }
        .actionSheet(isPresented: $isDisplayed) {
            ActionSheet(title: Text("Your Activity Is.."), buttons: [.default(Text("Do My Activity!"))])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

