//
//  Model.swift
//  Heroes
//
//  Created by Aditya on 21/04/22.
//

import Foundation

// MARK: - READ ME
// Some Keys in this Model are commented out because they're not needed right away, but commented
// code is there to understand the structure of the response.
// Uncomment whichever key is needed.

struct MvlResponseModel: Decodable {
//    let code: Int
//    let status, copyright, attributionText, attributionHTML: String
    let data: DataClass
//    let etag: String
}

// MARK: - DataClass
struct DataClass: Decodable {
//    let offset, limit, total, count: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
//    let id: Int
    let name : String?
//    let resultDescription, modified, resourceURI: String?
//    let urls: [URLElement]
    let thumbnail: Thumbnail
//    let comics: Comics
//    let stories: Stories
//    let events, series: Comics

//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case resultDescription = "description"
//        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
//    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

 /*
// MARK: - Comics
struct Comics: Codable {
    let available, returned: Int
    let collectionURI: String
    let items: [ComicsItem]
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI, name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available, returned: Int
    let collectionURI: String
    let items: [StoriesItem]
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String
}

// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String
}
*/
