//
//  Location.swift
//  DataLocator
//
//  Created by Евгений on 31.08.2024.
//

struct Location: Decodable {
    let ip: String
    let network: String
    let version: String
    let city: String
    let region: String
    let regionCode: String
    let country: String
    let countryName: String
    let countryCode: String
    let countryCodeIso3: String
    let countryCapital: String
    let countryTld: String
    let continentCode: String
    let inEu: Bool
    let postal: String
    let latitude: Double
    let longitude: Double
    let timezone: String
    let utcOffset: String
    let countryCallingCode: String
    let currency: String
    let currencyName: String
    let languages: String
    let countryArea: Int
    let countryPopulation: Int
    let asn: String
    let org: String
}

struct LocationData {
    static let sectionTitles = [
        "IP", "Network", "Version", "City", "Region", "Region Code",
        "Country", "Country Name", "Country Code", "Country Code ISO 3",
        "Country Capital", "Country TLD", "Continent Code", "In EU",
        "Postal", "Latitude", "Longitude", "Timezone", "UTC Offset",
        "Country Calling Code", "Currency", "Currency Name", "Languages",
        "Country Area", "Country Population", "ASN", "Internet Service Provider"
    ]
}
