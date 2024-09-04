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
