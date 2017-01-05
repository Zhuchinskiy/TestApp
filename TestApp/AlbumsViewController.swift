//
//  AlbumsViewController.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/5/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class AlbumsViewController: UICollectionViewController {
    
    var artist: String?
    var albums: Albums?
    var selectedAlbum: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchDataAndReloadUI()
    }
    
    func setupUI() {
        title = artist
    }
    
    func fetchDataAndReloadUI() {
        startLoading()
        guard let artist = artist else { return }
        
        NetworkManager.sharedMangaer.getTopAlbumsForArtist(artist) { (albums, error) in
            self.stopLoading()
            self.albums = albums
            self.collectionView?.reloadData()
        }
        
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.topalbums?.album?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier(), for: indexPath) as! AlbumCollectionViewCell
        
        if let album = albums?.topalbums?.album?[indexPath.row] {
            
            if let imageURLString = album.image?[1].text {
                albumCell.albumImageView.downloadedFrom(link: imageURLString)
            }
        
            albumCell.albumTitleLabel.text = album.name
        }
        
        return albumCell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAlbum = albums?.topalbums?.album?[indexPath.row].name
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "AlbumToAlbumSegueID", sender: self)
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AlbumToAlbumSegueID" {
            let vc = segue.destination as? AlbumDetailsViewController
            vc?.artist = artist
            vc?.album = selectedAlbum
        }
        
    }

}
