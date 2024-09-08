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
    
    init(ip: String, network: String, version: String, city: String, region: String, regionCode: String, country: String, countryName: String, countryCode: String, countryCodeIso3: String, countryCapital: String, countryTld: String, continentCode: String, inEu: Bool, postal: String, latitude: Double, longitude: Double, timezone: String, utcOffset: String, countryCallingCode: String, currency: String, currencyName: String, languages: String, countryArea: Int, countryPopulation: Int, asn: String, org: String) {
        self.ip = ip
        self.network = network
        self.version = version
        self.city = city
        self.region = region
        self.regionCode = regionCode
        self.country = country
        self.countryName = countryName
        self.countryCode = countryCode
        self.countryCodeIso3 = countryCodeIso3
        self.countryCapital = countryCapital
        self.countryTld = countryTld
        self.continentCode = continentCode
        self.inEu = inEu
        self.postal = postal
        self.latitude = latitude
        self.longitude = longitude
        self.timezone = timezone
        self.utcOffset = utcOffset
        self.countryCallingCode = countryCallingCode
        self.currency = currency
        self.currencyName = currencyName
        self.languages = languages
        self.countryArea = countryArea
        self.countryPopulation = countryPopulation
        self.asn = asn
        self.org = org
    }
    
    init (locationDetails: [String: Any]) {
        ip = locationDetails["ip"] as? String ?? ""
        network = locationDetails["network"] as? String ?? ""
        version = locationDetails["version"] as? String ?? ""
        city = locationDetails["city"] as? String ?? ""
        region = locationDetails["region"] as? String ?? ""
        regionCode = locationDetails["region_code"] as? String ?? ""
        country = locationDetails["country"] as? String ?? ""
        countryName = locationDetails["country_name"] as? String ?? ""
        countryCode = locationDetails["country_code"] as? String ?? ""
        countryCodeIso3 = locationDetails["country_code_iso3"] as? String ?? ""
        countryCapital = locationDetails["country_capital"] as? String ?? ""
        countryTld = locationDetails["country_tld"] as? String ?? ""
        continentCode = locationDetails["continent_code"] as? String ?? ""
        inEu = locationDetails["in_eu"] as? Bool ?? false
        postal = locationDetails["postal"] as? String ?? ""
        latitude = locationDetails["latitude"] as? Double ?? 0.0
        longitude = locationDetails["longitude"] as? Double ?? 0.0
        timezone = locationDetails["timezone"] as? String ?? ""
        utcOffset = locationDetails["utc_offset"] as? String ?? ""
        countryCallingCode = locationDetails["country_calling_code"] as? String ?? ""
        currency = locationDetails["currency"] as? String ?? ""
        currencyName = locationDetails["currency_name"] as? String ?? ""
        languages = locationDetails["languages"] as? String ?? ""
        countryArea = locationDetails["country_area"] as? Int ?? 0
        countryPopulation = locationDetails["country_population"] as? Int ?? 0
        asn = locationDetails["asn"] as? String ?? ""
        org = locationDetails["org"] as? String ?? ""
    }
    
    static func getLocation(from value: Any) -> Location {
        guard let locationDetails = value as? [String: Any] else { 
            return Location(locationDetails: [:])
        }
        return Location(locationDetails: locationDetails)
    }
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
