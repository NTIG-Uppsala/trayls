//
//  ApiCall.swift
//  IOS
//
//  Created by te4 on 2021-11-23.
//

import Foundation

var contents = " "
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
        var contents:NSObject
    }
}
