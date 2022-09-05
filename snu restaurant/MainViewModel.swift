//
//  MainViewModel.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import Foundation

@MainActor
final class MainViewModel : ObservableObject {
    @Published var menus: [Menu] = []

    var restaurantRepository : RestaurantRepository

    init (restaurantRepository : RestaurantRepository) {
        self.restaurantRepository = restaurantRepository
    }

    func refreshData() {
        Task.init {
            do {
                self.menus = try await restaurantRepository.getMenus() ?? []
            } catch {

            }
        }
    }
}
