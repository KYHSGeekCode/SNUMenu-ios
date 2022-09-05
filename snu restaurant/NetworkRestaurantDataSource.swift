//
//  NetworkRestaurantDataSource.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import Foundation
import Alamofire

struct Restaurant: Decodable {
    var code: String
    var name: String // name

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "restaurant"
    }
}

struct RestaurantList: Decodable {
    var content: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case content = "GRD_SNUCO_RESTAURANT"
    }
}


struct MOBI024: Decodable {

}

struct SSO: Decodable {
    let status: String
    let requestURL: String
    let requestURI, authURL, userAuth, userAuthName: String
    let userAuthEngName, userSsoCount, userStatus, userStatusName: String
    let pageAuthYn, lang, ssoCheckYn, saEngName: String
    let saName, saUID: String

    enum CodingKeys: String, CodingKey {
        case status
        case requestURL = "requestUrl"
        case requestURI = "requestUri"
        case authURL = "authUrl"
        case userAuth, userAuthName, userAuthEngName, userSsoCount, userStatus, userStatusName, pageAuthYn, lang, ssoCheckYn
        case saEngName = "sa_eng_name"
        case saName = "sa_name"
        case saUID = "sa_UID"
    }
}

struct Menu: Decodable, Hashable {
    let ptalUserID, cafeCD, cafeKorNm, cafeEngNm: String?
    let inptDttm, inptID, inptIP, prnOrd: String?
    let date: String?
    let code, restaurant: String
    let gubun, tel, locationEng, editDate: String?
    let menuDate: String?
    let breakfast, lunch, dinner: String?

    enum CodingKeys: String, CodingKey {
        case ptalUserID = "ptalUserId"
        case cafeCD = "cafeCd"
        case cafeKorNm, cafeEngNm, inptDttm
        case inptID = "inptId"
        case inptIP = "inptIp"
        case prnOrd, date, code, restaurant, gubun, tel, locationEng, editDate, menuDate, breakfast, lunch, dinner
    }
}

struct MenuList: Decodable {
    var MOBI024: [MOBI024]
    var SSO: [SSO]
    var api: [Menu]
}

class NetworkRestaurantDataSource: RestaurantDataSource {
    func fetchRestaurants() async throws -> [Restaurant]? {
        let request = AF.request("https://mob.snu.ac.kr/api/M/new/findRestList.action", method: .post)
        let task = request.serializingDecodable(RestaurantList.self)
        let response = await task.response
        guard let restaurants = response.value else {
            print("Failed to load restaurent list: \(String(describing: response.error))")
            return nil
        }
        return restaurants.content
    }

    func fetchMenus() async throws -> [Menu]? {
        let parameters: [String: Any] = [
            "requestUrl": "http://mob.snu.ac.kr/mob/mcin/mfood/todayFood.html",
            "requestUri": "/mob/mcin/mfood/todayFood.html",
            "ssoCheckYn": "Y",
            "authUrl": "/mob/mcin/mfood/todayFood.html"
        ]
        let request = AF.request("https://mob.snu.ac.kr/api/findRestMenuList.action?date=2020-07-27", method: .post, parameters: parameters, encoding: JSONEncoding.default)

        let task = request.serializingDecodable(MenuList.self)
        let response = await task.response

        guard let restaurants = response.value else {
            print("Failed to load menu list: \(String(describing: response.error))")
            return nil
        }
        return restaurants.api
    }
}

