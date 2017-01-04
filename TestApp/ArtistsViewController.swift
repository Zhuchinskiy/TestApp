//
//  ArtistsViewController.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/4/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class ArtistsViewController: UITableViewController {

    let selectedCountry = "Spain"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.sharedMangaer.getTopArtistsForCountry(selectedCountry) { artistsModel, error in

        }
        
    }


}

