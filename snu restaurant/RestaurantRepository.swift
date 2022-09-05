//
//  RestaurantRepository.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import Foundation

class RestaurantRepository {
    var networkRestaurantDataSource : RestaurantDataSource
    var localRestaurantDataSource : RestaurantDataSource

    init(networkRestaurantDataSource : RestaurantDataSource, localRestaurantDataSource : RestaurantDataSource) {
        self.networkRestaurantDataSource = networkRestaurantDataSource
        self.localRestaurantDataSource = localRestaurantDataSource
    }

    func getMenus(of: Date) async throws -> [Menu]? {
        return try await networkRestaurantDataSource.fetchMenus(of: of)
    }
}
