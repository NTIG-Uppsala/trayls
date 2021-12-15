
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

        VStack() {
            
            Text("Trayls")
                .frame(width: 400, height: 100)
                .foregroundColor(.black)
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .cornerRadius(15)
                .shadow(radius: 20)
                .font(.custom("Times New Roman", size:50))
            
            NavigationView{
            NavigationLink(destination: SecondContentView() .navigationBarBackButtonHidden(true)){
                Text("Ny task")
                   

                    .frame(width: 180, height: 40)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                    .cornerRadius(15)
                    .shadow(radius: 20)
                    .font(.custom("Times New Roman", size:30))
            }

            }

            Spacer()
            Text(verbatim:"Inloggad som:\ntest@mail.com")
                .frame(width: 400, height: 80)
                .foregroundColor(.black)
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .cornerRadius(15)
                .shadow(radius: 20)
                .font(.custom("Times New Roman", size:30))
            
        
                
         // or .top
        
        }
        .blendMode(.darken)
        .edgesIgnoringSafeArea(.vertical)
    } // End body
     

    func GetTask(){
        if let url = URL(string: "netlabua.se/task") {
        do {
           contents = try String(contentsOf: url)
            
        } catch {
            
        }
    } else {
        print("Invalid URL")
    }

        struct Task{
            var contents:String
        }
 
        


 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}

struct SecondContentView: View{
        var body: some View{
            Text()
        }
    }
}
