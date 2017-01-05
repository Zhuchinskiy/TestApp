//
//  ArtistsViewController.swift
//  TestApp
//
//  Created by Alexandr Zhuchinskiy on 1/4/17.
//  Copyright © 2017 Alexandr Zhuchinskiy. All rights reserved.
//

import UIKit

class ArtistsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedCountry = "Spain"
    var selectedArtist = ""
    
    var artistsModel: ArtistModel?
    let pickerData = ["Spain", "Germany", "France", "Norway", "Sweden"]
    
    lazy var pickerView: UIPickerView = { [unowned self] in
        return UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchDataAndReloadUI()
    }
    
    private func setupUI() {
        title = "Back"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        navigationItem.titleView = NavigationItemView.itemView()

        if let titleView = navigationItem.titleView as? NavigationItemView {
            titleView.countryButton.setTitle(selectedCountry, for: .normal)
            titleView.countryButton.addTarget(self, action: #selector(presentPickerView), for: .touchUpInside)
        }
    
    }
    
    private func fetchDataAndReloadUI() {
        startLoading()
        
        NetworkManager.sharedMangaer.getTopArtistsForCountry(selectedCountry) { artistsModel, error in
            self.stopLoading()
            self.artistsModel = artistsModel
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Action
    
    private dynamic func presentPickerView() {
        pickerView.backgroundColor = UIColor.lightGray
        
        if view.subviews.contains(pickerView) {
            tableView.isScrollEnabled = true
            
            pickerView.removeFromSuperview()
            pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)

        } else {
            tableView.isScrollEnabled = false

            UIView.animate(withDuration: 0.4, animations: {
                self.view.addSubview(self.pickerView)
                self.pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
            })
            
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistsModel?.topartists?.artist?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TopArtistTableViewCell.identifier()) as! TopArtistTableViewCell
        let artist = artistsModel?.topartists?.artist?[indexPath.row]
        
        if let artist = artist {
            
            if let imageURLString = artist.image?[2].text {
                cell.artistImageView.downloadedFrom(link: imageURLString, contentMode: .scaleAspectFill)
            }
            
            cell.artistName.text = artist.name
            cell.artistListener.text = "(\(artist.listeners ?? "0") listeners)"
        }
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArtist = (artistsModel?.topartists?.artist?[indexPath.row].name)!
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ArtistToAlbumsSegueID", sender: self)
    }
    
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = pickerData[row]
        
        if let titleView = navigationItem.titleView as? NavigationItemView {
            titleView.countryButton.setTitle(selectedCountry, for: .normal)
        }
        
        fetchDataAndReloadUI()
    }
    
    
    // MARK: - Segue 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ArtistToAlbumsSegueID" {
            let albumVC = segue.destination as? AlbumsViewController
            albumVC?.artist = selectedArtist
        }
    }
    
}

extension UIViewController {
    
    func startLoading() {
        let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        indicatorView.activityIndicatorViewStyle = .gray
        indicatorView.center = view.center
        indicatorView.startAnimating()
        view.addSubview(indicatorView)
    }
    
    func stopLoading() {
        view.subviews.forEach { (view) in
            if let indicatorView = view as? UIActivityIndicatorView {
                indicatorView.stopAnimating()
                indicatorView.hidesWhenStopped = true
            }
        }
    }
    
}


