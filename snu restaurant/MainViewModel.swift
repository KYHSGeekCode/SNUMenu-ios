//
//  MainViewModel.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    @Published var menus: [Menu] = []
    @Published private(set) var date: Date = Date()

    var restaurantRepository: RestaurantRepository

    init(restaurantRepository: RestaurantRepository) {
        self.restaurantRepository = restaurantRepository
    }

    func refreshData() {
        Task.init {
            do {
                self.menus = try await restaurantRepository.getMenus(of: date) ?? []
            } catch {

            }
        }
    }

    func tomorrow() {
        date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
        refreshData()
    }

    func yesterday() {
        date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
        refreshData()
    }
}
