//
//  ApiCall.swift
//  IOS
//
//  Created by te4 on 2021-11-23.
//

import Foundation

if let url = URL(string: "http://netlabua.se/task") {
    do {
        let contents = try String(contentsOf: url)
        print(contents)
    } catch {
        // contents could not be loaded
    }
} else {
    // the URL was bad!
}
