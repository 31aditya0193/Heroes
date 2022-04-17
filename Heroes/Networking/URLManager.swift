//
//  URLManager.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import Foundation
import CryptoKit

struct URLManager {
    var path : String = ""
    let privateKey = Bundle.main.object(forInfoDictionaryKey: "PRIVATE_KEY") as? String
    let publicKey = Bundle.main.object(forInfoDictionaryKey: "PUBLIC_KEY") as? String
    
    func getApiPath() -> URL? {
        guard let privateKey = privateKey, !privateKey.isEmpty, let publicKey = publicKey, !publicKey.isEmpty else {
            print("Keys not found")
            return nil
        }
        let timeStamp = getEpochTime()
        let urlString = String.baseEndPoint + ContentType.characters.rawValue + String.apiKeyStr + publicKey + .hashStr + getMd5(of: timeStamp + privateKey + publicKey)
        return URL(string: urlString)
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
