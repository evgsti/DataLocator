//
//  LocationTableViewController.swift
//  DataLocator
//
//  Created by Евгений on 04.09.2024.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var locations: [Location] = []
    
    private let networkManager = NetworkManager.shared
    private let url = URL(string: "https://ipapi.co/json/")!
    private let sectionTitles = [
            "IP", "Network", "Version", "City", "Region", "Region Code",
            "Country", "Country Name", "Country Code", "Country Code ISO 3",
            "Country Capital", "Country TLD", "Continent Code", "In EU",
            "Postal", "Latitude", "Longitude", "Timezone", "UTC Offset",
            "Country Calling Code", "Currency", "Currency Name", "Languages",
            "Country Area", "Country Population", "ASN", "Internet Service Provider"
        ]

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
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
        
        var content = cell.defaultContentConfiguration()

        switch indexPath.section {
        case 0:
            content.text = location?.ip
        case 1:
            content.text = location?.network
        case 2:
            content.text = location?.version
        case 3:
            content.text = location?.city
        case 4:
            content.text = location?.region
        case 5:
            content.text = location?.regionCode
        case 6:
            content.text = location?.country
        case 7:
            content.text = location?.countryName
        case 8:
            content.text = location?.countryCode
        case 9:
            content.text = location?.countryCodeIso3
        case 10:
            content.text = location?.countryCapital
        case 11:
            content.text = location?.countryTld
        case 12:
            content.text = location?.continentCode
        case 13:
            content.text = location!.inEu ? "Yes" : "No"
        case 14:
            content.text = location?.postal
        case 15:
            content.text = "\(location?.latitude ?? 0.0)"
        case 16:
            content.text = "\(location?.longitude ?? 0.0)"
        case 17:
            content.text = location?.timezone
        case 18:
            content.text = location?.utcOffset
        case 19:
            content.text = location?.countryCallingCode
        case 20:
            content.text = location?.currency
        case 21:
            content.text = location?.currencyName
        case 22:
            if let languages = location?.languages {
                content.text = languages.replacingOccurrences(of: ",", with: ", ")
            } else {
                content.text = nil
            }
        case 23:
            if let countryArea = location?.countryArea {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                content.text = "\(numberFormatter.string(from: NSNumber(value: countryArea)) ?? "0") м²"
            } else {
                content.text = "0 м²"
            }
        case 24:
            if let population = location?.countryPopulation {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                content.text = "\(numberFormatter.string(from: NSNumber(value: population)) ?? "0") people"
            } else {
                content.text = "0 people"
            }
        case 25:
            content.text = location?.asn
        default:
            content.text = location?.org
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Networking
extension LocationTableViewController {
    func fetchData() {
        networkManager.fetch(Location.self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let locations):
                self.locations = [locations]
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
