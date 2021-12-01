
//
//  ContentView.swift
//  Testapp
//
//  Created by Albin Eriksson
//
 import Foundation
import SwiftUI
 
struct ContentView: View {
 
    @State private var contents = " "
    
    var body: some View {
         
        VStack {
            Button(action: {GetTask()
            }, label: {
                Text("Ny Uppgift")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            })
                .onAppear(perform: {GetTask()})
            Text("Nästa Aktivitet är:\n\(self.contents)")
            
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .padding(50)
                .cornerRadius(15)
        
                
        }
    } // End body
     

    func GetTask(){
        if let url = URL(string: "https://walk-api.azurewebsites.net/gettask") {
        do {
           contents = try String(contentsOf: url)
            
        } catch {
            
        }
    } else {
        print("Invalid URL")
    }
        
    

     
        struct Task{
            var contents:NSObject
        }
     

 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
}
