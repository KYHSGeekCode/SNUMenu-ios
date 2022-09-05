//
//  LocalRestaurantDataSource.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import Foundation

class LocalRestaurantDataSource: RestaurantDataSource {
    func fetchMenus(of: Date) async throws -> [Menu]? {
        return nil
    }

    func fetchRestaurants() async throws -> [Restaurant]? {
        return nil

    }
}
