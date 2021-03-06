//
//  HttpUtility.swift
//  Heroes
//
//  Created by Aditya on 17/04/22.
//

import UIKit

class MvlNetworkManager {
    static let shared : MvlNetworkManager = MvlNetworkManager()
    private let imageCache = NSCache<AnyObject, UIImage>()
    private init() {}
    
    func getData<T: Decodable>(with urlRequest: URLRequest, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { responseData, httpUrlResponse, error in
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
    
    func fetchImage(from address: String, completionHandler: @escaping(_ image: UIImage) -> Void) {
        guard let url = URL(string: address) else {
            print("Invalid Image Path")
            return
        }
        
        if let cachedImage = self.imageCache.object(forKey: url as AnyObject)
        {
            completionHandler(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { imageData, httpUrlResponse, error in
            if (error == nil && imageData != nil && imageData?.count != 0) {
                guard let image = UIImage(data: imageData!) else {
                    debugPrint("Error occured while decoding.")
                    return
                }
                self.imageCache.setObject(image, forKey: url as AnyObject)
                completionHandler(image)
            }
        }).resume()
    }
}
