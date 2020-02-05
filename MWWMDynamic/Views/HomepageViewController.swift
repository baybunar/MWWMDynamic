//
//  HomepageViewController.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 13.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import CoreLocation

class HomepageViewController: UIViewController {
    
    @IBOutlet var locationTableView: UITableView!
    @IBOutlet var currentLocation: UILabel!
    @IBOutlet var currentLocationTemperature: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var resultsController = UISearchController()
    
    lazy var viewModel: HomepageViewModel = {
        return HomepageViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableView.tableFooterView = UIView(frame: .zero)
        activityIndicator.isHidden = true
        
        resultsController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            locationTableView.tableHeaderView = controller.searchBar
            
            return controller
        }()
        
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.requestLocation()
        }
        
        viewModel.getLocallySavedLocations()
    }
    
    func bindUI() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.locationTableView.reloadData()
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    if let currentLocationText = self?.viewModel.currentLocationText {
                        self?.currentLocation.text = currentLocationText
                    }
                    if let currentLocationTemperature = self?.viewModel.currentLocationTemperature {
                        self?.currentLocationTemperature.text = currentLocationTemperature
                    }
                }
            }
        }
        
        viewModel.navigateToDetail = { [weak self] () in
            if let locationName = self?.viewModel.selectedLocation?.locationText,
                let locationTemperature = self?.viewModel.selectedLocation?.locationTemperature {
                let locationDetailViewModel = LocationDetailViewModel(locationName: locationName, locationTemperature: locationTemperature)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let locationDetailViewController = storyBoard.instantiateViewController(withIdentifier: "LocationDetailViewController") as! LocationDetailViewController
                locationDetailViewController.locationDetailViewModel = locationDetailViewModel
                self?.navigationController?.pushViewController(locationDetailViewController, animated: true)
            }
        }
    }
}

extension HomepageViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension HomepageViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        viewModel.getCurrentLocationWeather(lon: Float(locValue.longitude), lat: Float(locValue.latitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension HomepageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedLocation(at: indexPath)
    }
}

extension HomepageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowCount = viewModel.savedLocationViewModels?.count {
            return rowCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomepageLocationCell", for: indexPath) as? HomepageLocationCell, let cellViewModel = viewModel.savedLocationViewModels?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.locationCellViewModel = cellViewModel
        
        return cell
    }
    
}
