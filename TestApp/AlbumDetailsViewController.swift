//
//  AlbumDetailsViewController.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/5/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    var artist: String?
    var album: String?
    
    var albumDetails: AlbumDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        fetchDataAndReloadUI()
    }
    
    func setupUI() {
        title = album
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func fetchDataAndReloadUI() {
        
        startLoading()
        guard let album = album, let artist = artist else { return }
        
        NetworkManager.sharedMangaer.getDetailsForAlbum(album, artist: artist) { (albumDetails, error) in
            self.stopLoading()
            
            if let imageURLString = albumDetails?.album?.image?[3].text {
                self.albumImageView.downloadedFrom(link: imageURLString)
            }
            
            self.albumDetails = albumDetails
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumDetails?.album?.tracks?.track?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCellIIdentifier")
        
        if let track = albumDetails?.album?.tracks?.track?[indexPath.row], let trackName = track.name  {
            cell?.textLabel?.text = "\(indexPath.row + 1). \(trackName)"
            
            if let duration = track.duration, let sec = Int(duration) {
                let minutes = sec / 60
                let seconds = sec % 60
                cell?.detailTextLabel?.text = "\(minutes) : \(seconds)"
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
