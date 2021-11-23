import UIKit

import Foundation
print("hey")


let url = URL(string: "localhost:8080/gettrip/sthlm")!
URLSession.shared.fetchData(at: url) { result in
  switch result {
  case .success(let activities): break
    // Woo, we got our todo list
  case .failure(let error): break
    // Ohno, an error, let's handle it
  }
}

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

