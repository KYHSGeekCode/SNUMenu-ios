//
//  RestaurantDataSource.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import Foundation

protocol RestaurantDataSource {
    func fetchMenus(of: Date) async throws -> [Menu]?
    func fetchRestaurants() async throws -> [Restaurant]?
}
