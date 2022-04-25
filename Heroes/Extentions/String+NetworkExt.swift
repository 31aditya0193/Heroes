//
//  NetworkConstants.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import Foundation

// MARK: Network Constants
extension String {
    static let baseEndPoint = "https://gateway.marvel.com/v1/public"
    static let apiKeyStr = "apikey"
    static let timeStampStr = "ts"
    static let hashStr = "hash"
    static let nameQueryStr = "nameStartsWith"
}


// MARK: Content Type Constants
enum ContentType : String {
    case characters = "/characters"
    case comics = "/comics"
    case creators = "/creators"
    case events = "/events"
    case series = "/series"
    case stories = "/stories"
}

// HTTP Method Enum
enum HttpMethod : String {
    case get = "GET"
}
