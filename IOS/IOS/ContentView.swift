
//
//  ContentView.swift
//  Testapp
//
//  Created by Cairocoders
//
 import Foundation
import SwiftUI
 
struct ContentView: View {
 
     
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
             
            Text("Nästa Aktivitet är:\n\(TaskCall.task)")
            
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .padding(50)
                .cornerRadius(15)
        
                
        }
    } // End body
     
    struct TaskCall{
        static var task = contents
    }

    func GetTask(){
        if let url = URL(string: "https://walk-api.azurewebsites.net/gettask") {
        do {
            var contents = try String(contentsOf: url)
            print(contents)
        } catch {
            print("Contents cant be loaded")
        }
    } else {
        print("Invalid URL")
    }
        
    }

     

     

 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
