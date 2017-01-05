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
    
    func getTopAlbumsForArtist(_ name: String, _ completionHandler: @escaping (_ model: Albums?, _ error: Error?) -> Void) {
        
        let params = ["artist": name, "api_key": apiKey, "format": "json"]
        let albumURL = baseURL.appending(RequestPath.topAlbum.stringValue)
        
        Alamofire.request(albumURL, method: .get, parameters: params).validate().responseJSON { (response) in
        
            switch response.result {
            case .success:
                let artistModel = Albums(object: response.data!)
                completionHandler(artistModel, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
    }
    
    func getDetailsForAlbum(_ album: String, artist: String, _ completionHandler: @escaping (_ model: AlbumDetails?, _ error: Error?) -> Void) {
        
        let params = ["artist": artist, "api_key": apiKey, "album": album ,"format": "json"]
        let albumURL = baseURL.appending(RequestPath.AlbumDetails.stringValue)
        
        Alamofire.request(albumURL, method: .get, parameters: params).validate().responseJSON { (response) in
            
            switch response.result {
            case .success:
                let albumDetails = AlbumDetails(object: response.data!)
                completionHandler(albumDetails, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
        
    }
                        
}
