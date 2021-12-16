
//
//  ContentView.swift
//  Testapp
//
//  Created by Albin Eriksson
//
 import Foundation
import SwiftUI

 
struct ContentView: View {
    @State private var email = " "
    var body: some View {
        
        VStack() {
            
            Text("Trayls")
                .frame(width: 400, height: 100)
                .foregroundColor(.black)
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .font(.custom("Times New Roman", size:50))
            
            NavigationView{
            NavigationLink(destination: SecondContentView() .navigationBarBackButtonHidden(true)){
                Text("Ny task") //Set text in cotainer
                   
                    .frame(width: 180, height: 40)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 5, x: 5, y: 10)
                    .font(.custom("Times New Roman", size:30))
            }
            }
            Spacer()
            Text(verbatim:"Inloggad som:\n\(email)")
                .frame(width: 400, height: 80)
                .foregroundColor(.black)
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .font(.custom("Times New Roman", size:30))
                .multilineTextAlignment(.center)

        
        }
        .blendMode(.darken)
        .edgesIgnoringSafeArea(.vertical)
        
        .onAppear{randomMail(of: 10)}
        
    }
        func randomMail(of length: Int) {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            var s = ""
            for _ in 0 ..< length {
                s.append(letters.randomElement()!)
            }
        
            let mailend = "@mail.com"
            
            email = s+mailend
            print(email)

        }
    struct Mail{
        var email = ""
    }
    } // End body
     
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondContentView: View{
    
    @State private var contents = " "
    @State private var task_points = 0
    @State private var task_query = " "
    @State private var email = " "
    @State private var task_id = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        var body: some View{
            
            Text(verbatim:"\(task_query)\n\n\(task_points)‎‎  Poäng")
                .frame(width: 280, height: 200)
                .foregroundColor(.black)
                .padding()
                .background(Color(red: 43 / 255, green: 174 / 255, blue: 102 / 255))
                .cornerRadius(15)
                .shadow(color: .gray, radius: 5, x: 5, y: 10)
                .multilineTextAlignment(.center)
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
                                .shadow(color: .gray, radius: 5, x: 5, y: 10)
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
                                        .shadow(color: .gray, radius: 5, x: 5, y: 10)
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
            let parsed: Source = try! JSONDecoder().decode(Source.self, from: jsonData)
            print(parsed)
            task_query = parsed.task_query
            task_points = parsed.task_points
            task_id = parsed.task_id
            
        } catch {
            
        }
    } else {
        print("Invalid URL")
    }

        struct Task{
            var contents:NSObject
        }
    
    struct Source: Codable{
        
        var task_id: Int
        var task_query: String
        var task_points: Int
    
    }
    }
    }
struct ThirdContentView: View{
    
    @State private var task_query = " "
    @State private var email = " "
    @State private var task_id = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var contents = " "
    
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
                            .shadow(color: .gray, radius: 5, x: 5, y: 10)
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
                                            .shadow(color: .gray, radius: 5, x: 5, y: 10)
                                            .font(.custom("Times New Roman", size:30))
                                })
                        }
                               
                               
                               
                }
                .blendMode(.darken)
        }
            func postMethod() {
                    // Create model
                    struct UploadData: Codable {
                        let user_mail: String
                        let task_id: Int
                    }
                    
                    // Add data to the model
                // prepare json data
                let json: [String: Any] = ["user_mail": email, "task_id": task_id]

                let jsonData = try? JSONSerialization.data(withJSONObject: json)

                // create post request
                let url = URL(string: "http://netlabua.se/acctask")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"

                // insert json data to the request
                request.httpBody = jsonData

                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                    }
                }

                task.resume()
            }

        
}

struct EmptyContentView: View{
    
    @State private var contents = " "
    
        var body: some View{
        
                Text("")
            
            }
        
        }
    
        
    







