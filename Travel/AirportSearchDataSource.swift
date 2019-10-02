import Foundation

/**
 AirportDataSource is the provider of airports that travel app allows bookings to/from. It is intended to be used as a singleton (see `AirportDataSource.shared`)

 For the purposes of this take-home interview do not make any changes to this file.
 */
public final class AirportDataSource {

    /// Singleton access to an instance of `AirportDataSource`.
    public static let shared = AirportDataSource()

    /// Returns an array of airports that match `query`, if `query` is nil or empty, returns all eligible airports.
    public func airportsMatching(_ query: String?) -> [Airport] {
        guard let query = query, !query.isEmpty else { return database }
        let results = database.filter({
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.shortCode.lowercased().contains(query.lowercased())
        })

        // Insert an artificial delay to replicate a network round-trip and provide the main challenge for this problem!
        Thread.sleep(forTimeInterval: Double(arc4random_uniform(100))/50.0)

        return results
    }

    /// Private collection of airports.
    private lazy var database: [Airport] = {
        let url = Bundle.main.url(forResource: "airport-by-iata", withExtension: "csv")!
        let data = try! Data(contentsOf: url)
        let string = String(data: data, encoding: .utf8)!
        return string.components(separatedBy: .newlines).compactMap {
            let components = $0.components(separatedBy: ",")
            guard components.count == 2 else { return nil }
            return Airport(name: components[1], shortCode: components[0])
        }
    }()

    /// Private init to protect access except through singleton.
    private init() {}
}
