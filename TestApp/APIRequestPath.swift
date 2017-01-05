//
//  APIRequestPath.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/4/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    enum RequestPath {
        case topArtist
        case topAlbum
        case AlbumDetails
        
        var stringValue: String {
            switch self {
                case .topArtist : return "/?method=geo.gettopartists"
                case .topAlbum : return "/?method=artist.gettopalbums"
                case .AlbumDetails : return "/?method=album.getinfo"
            }
        }
    }
    
}
