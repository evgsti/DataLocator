//
//  LocationTableViewController.swift
//  DataLocator
//
//  Created by Евгений on 04.09.2024.
//

import UIKit

final class LocationTableViewController: UITableViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var locationRefreshAction: UIRefreshControl!
    
    // MARK: - Private Properties
    private var locations: [Location] = []
    private var isRefreshingData = false
    
    private let sectionTitles = LocationData.sectionTitles
    private let networkManager = NetworkManager.shared
    
    private let url = URL(string: "https://ipapi.co/json/")!
    private let activityIndicator = UIActivityIndicatorView()
    private let loadingView = UIView()
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        configureRefreshControl()
        fetchData()
        
        tableView.isHidden = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let location = locations.first
        let locationDetails: [String?] = [
            location?.ip,
            location?.network,
            location?.version,
            location?.city,
            location?.region,
            location?.regionCode,
            location?.country,
            location?.countryName,
            location?.countryCode,
            location?.countryCodeIso3,
            location?.countryCapital,
            location?.countryTld,
            location?.continentCode,
            location?.inEu != nil ? (location!.inEu ? "Yes" : "No") : "N/A",
            location?.postal,
            formatCoordinate(location?.latitude),
            formatCoordinate(location?.longitude),
            location?.timezone,
            location?.utcOffset,
            location?.countryCallingCode,
            location?.currency,
            location?.currencyName,
            formatLanguages(location?.languages),
            formatNumber(location?.countryArea, unit: "м²"),
            formatNumber(location?.countryPopulation, unit: "people"),
            location?.asn,
            location?.org
        ]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = locationDetails[indexPath.section]
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - Private Methods
    private func formatCoordinate(_ coordinate: Double?) -> String {
        guard let coordinate = coordinate else { return "0.0" }
        return String(format: "%.4f", coordinate)
    }
    
    private func formatNumber(_ number: Int?, unit: String) -> String {
        guard let number = number else { return "0 \(unit)" }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return "\(numberFormatter.string(from: NSNumber(value: number)) ?? "0") \(unit)"
    }
    
    private func formatLanguages(_ languages: String?) -> String {
        return languages?.replacingOccurrences(of: ",", with: ", ") ?? ""
    }
    
    private func configureActivityIndicator() {
        loadingView.frame = view.bounds
        loadingView.isHidden = true
        
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.style = .large
        
        loadingView.addSubview(activityIndicator)
        navigationController?.view.addSubview(loadingView)
    }
    
    private func showLoadingView() {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingView() {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func configureRefreshControl() {
        locationRefreshAction.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        isRefreshingData = true
        fetchData()
    }
}

// MARK: - Networking
extension LocationTableViewController {
    private func fetchData() {
        if !isRefreshingData {
            showLoadingView()
        }
        
        networkManager.fetchData(url: url) { [unowned self] result in
            self.hideLoadingView()
            switch result {
            case .success(let location):
                self.locations = [location]
                self.tableView.isHidden = false
                self.locationRefreshAction.endRefreshing()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
