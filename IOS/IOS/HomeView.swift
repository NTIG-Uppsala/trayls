//
//  HomeView.swift
//  IOS
//
//  Created by te4 on 2021-11-24.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    @Published var tasks = [Activity]()
    
    func getHomeData() {
        NetworkManager.shared.getData(endpoint: .flights, type: Activity.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] flightsData in
                self?.tasks = flightsData
            }
            .store(in: &cancellables)
        }
}
