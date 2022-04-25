//
//  URLManager.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import Foundation
import CryptoKit

struct MvlURLManager {
    var path : String = ""
    let privateKey = Bundle.main.object(forInfoDictionaryKey: "PRIVATE_KEY") as? String
    let publicKey = Bundle.main.object(forInfoDictionaryKey: "PUBLIC_KEY") as? String
    
    func prepareUrlRequest(toSearch searchString: String = "") -> URLRequest? {
        guard let privateKey = privateKey, !privateKey.isEmpty, let publicKey = publicKey, !publicKey.isEmpty else {
            print("Keys not found")
            return nil
        }

        let ts = getEpochTime()
        
        var components = URLComponents(string: String.baseEndPoint + ContentType.characters.rawValue)!
        components.queryItems = [
            URLQueryItem(name: String.apiKeyStr, value: publicKey),
            URLQueryItem(name: String.timeStampStr, value: ts),
            URLQueryItem(name: String.hashStr, value: getMd5(of: ts + privateKey + publicKey))
        ]
        if !searchString.isEmpty {
            components.queryItems?.append(URLQueryItem(name: String.nameQueryStr, value: searchString))
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = HttpMethod.get.rawValue
        return request
    }
    
    func getEpochTime() -> String {
        String(Date().timeIntervalSince1970)
    }
    
    func getMd5(of seed: String) -> String {
        let digest = Insecure.MD5.hash(data: seed.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
