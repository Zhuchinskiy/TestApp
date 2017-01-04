//
//  NetworkManager.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/4/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    let baseURL = "http://ws.audioscrobbler.com/2.0"
    let apiKey = "e81f61890b7ff8633ca024d0faa449e7"
    
    static let sharedMangaer = NetworkManager()
    
    func getTopArtistsForCountry(_ country: String, _ completionHandler: @escaping (_ model: ArtistModel?, _ error: Error?) -> Void) {
        
        let params = ["country": country, "api_key": apiKey, "format": "json"]
        let artistURL = baseURL.appending(RequestPath.topArtist.stringValue)
        
        Alamofire.request(artistURL, method: .get, parameters: params).validate().responseJSON { (response) in
            
            switch response.result {
            case .success:
                let artistModel = ArtistModel(object: response.data!)
                completionHandler(artistModel, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
        
    }
    
}
