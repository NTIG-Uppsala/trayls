//
//  ApiCall.swift
//  IOS
//
//  Created by te4 on 2021-11-23.
//

import Foundation


extension URLSession {
  func fetchData(at url: URL, completion: @escaping (Result<[Activity], Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let activities = try JSONDecoder().decode([Activity].self, from: data)
          completion(.success(activities))
            print(activities)
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
