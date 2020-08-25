//
//  ImageNetworkRequest.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 05/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Alamofire

final class ImageNetworkRequest {
    func requestImage(from imageURL: String?, completionHandler: @escaping (UIImage?) -> Void) {
        guard let imageURL = imageURL,
            let stringURL = imageURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
            let url = URL(string: stringURL) else {
            completionHandler(nil)
            return
        }
        AF.request(url).responseData() { response in
            if response.error == nil {
                guard let data = response.data else {
                    completionHandler(nil)
                    return
                }
                completionHandler(UIImage(data: data))
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
