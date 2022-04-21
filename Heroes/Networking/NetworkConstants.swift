//
//  NetworkConstants.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import Foundation

extension String {
    static let baseEndPoint = "https://gateway.marvel.com/v1/public"
}

enum ContentType : String {
    case characters = "/characters"
    case comics = "/comics"
    case creators = "/creators"
    case events = "/events"
    case series = "/series"
    case stories = "/stories"
}
