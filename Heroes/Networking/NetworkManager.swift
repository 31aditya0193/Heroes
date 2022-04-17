//
//  HttpUtility.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import Foundation

class NetworkManager {
    static let shared : NetworkManager = NetworkManager()
    private init() {}
    
    func getApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { responseData, httpUrlResponse, error in
            if (error == nil && responseData != nil && responseData?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(result)
                }
                catch let error {
                    debugPrint("Error occured while decoding: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    func getApiData(requestUrl: URL, completionHandler: @escaping() -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { responseData, httpUrlResponse, error in
            if (error == nil && responseData != nil && responseData?.count != 0) {
                print(responseData)
                completionHandler()
            }
        }.resume()
    }
}
