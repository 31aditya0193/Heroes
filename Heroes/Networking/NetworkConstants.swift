//
//  NetworkConstants.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import Foundation

extension String {
    static let baseEndPoint = "https://gateway.marvel.com/v1/public"
    static let apiKeyStr = "?apikey=38079eb7f009738b6e38c5a530ac7a69"
    static let hashStr = "&hash="
}

enum ContentType : String {
    case characters = "/characters"
    case comics = "/comics"
    case creators = "/creators"
    case events = "/events"
    case series = "/series"
    case stories = "/stories"
}
