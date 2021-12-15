
//
//  ContentView.swift
//  Testapp
//
//  Created by Albin Eriksson
//
 import Foundation
import SwiftUI
 
struct ContentView: View {
    var body: some View {
        
        VStack() {
            
            Text("Trayls")
                .frame(width: 400, height: 100)
                .foregroundColor(.black)
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .font(.custom("Times New Roman", size:50))
            
            NavigationView{
            NavigationLink(destination: SecondContentView() .navigationBarHidden(true)){
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
                .font(.custom("Times New Roman", size:30))

        
        }
        .blendMode(.darken)
        .edgesIgnoringSafeArea(.vertical)
    } // End body
     
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}

struct SecondContentView: View{
    
    @State private var contents = " "
    @State private var parsedTask = " "
    @State private var parsedPoints = " "
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        var body: some View{
            
            Text(parsedTask)
                .frame(width: 280, height: 200)
                .foregroundColor(.black)
                .padding()
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .cornerRadius(15)
                .shadow(radius: 20)
                .font(.custom("Times New Roman", size:30))
            
                NavigationView{
                    VStack {
                    NavigationLink(destination: ThirdContentView() .navigationBarHidden(true)){
                        Text("Acceptera")
                            .frame(width: 180, height: 40)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                            .cornerRadius(15)
                            .shadow(radius: 20)
                            .font(.custom("Times New Roman", size:30))
                    }
                        Button(action: { self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("Neka")
                                        .frame(width: 180, height: 40)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color(red: 255 / 255, green: 10 / 255, blue: 10 / 255))
                                        .cornerRadius(15)
                                        .shadow(radius: 20)
                                        .font(.custom("Times New Roman", size:30))
                            }
                        )
                    }
        }
                .blendMode(.darken)
        
            .onAppear {
                self.GetTask()
            
            }
        
        }
    
    func GetTask(){
        if let url = URL(string: "http://netlabua.se/task") {
        do {
           contents = try String(contentsOf: url)
            let jsonData = contents.data(using: .utf8)!
            // Convert the JSON object to a Video object
            let parsed: Source = try! JSONDecoder().decode(Source.self, from: jsonData)

            let parsedtask = parsed.task_query
            let parsedPoints = parsed.task_points// Output: JSON Made Simple
            let parsedTaskId = parsed.task_id
            print(parsedTaskId)
            print(parsedPoints)
            print(parsedtask)
            
        } catch {
            
        }
    } else {
        print("Invalid URL")
    }
        
        

        struct Task{
            var contents:NSObject
        }
    
    struct Source: Decodable{
        
        var task_id: Int
        var task_query: String
        var task_points: Int
    
    }



}

struct ThirdContentView: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var contents = " "
    @State private var parsed = " "
    
        var body: some View{
        
                NavigationView{
                    HStack {
                    NavigationLink(destination: EmptyView() .navigationBarBackButtonHidden(true)){
                        Text("Klar")
                            .frame(width: 100, height: 40)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                            .cornerRadius(15)
                            .shadow(radius: 20)
                            .font(.custom("Times New Roman", size:30))
                    }

                        
                            Button(action: { self.presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Text("Avbryt")
                                            .frame(width: 100, height: 40)
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(Color(red: 255 / 255, green: 10 / 255, blue: 10 / 255))
                                            .cornerRadius(15)
                                            .shadow(radius: 20)
                                            .font(.custom("Times New Roman", size:30))
                                })
                        }
                               
                               
                               
                }
                .blendMode(.darken)
            
            }
        
        

struct EmptyContentView: View{
    
    @State private var contents = " "
    
        var body: some View{
        
                Text("")
            
            }
        
        }
    
        
    


}
}


