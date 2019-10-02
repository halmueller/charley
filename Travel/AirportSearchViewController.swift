import Foundation
import UIKit

/**
 `AirportSearchViewController` provides an interface for searching and selecting an airport. Upon selection the controller call's it's callback block `didSelectAirport` with the
 selection and then dismisses itself.
 */
public final class AirportSearchViewController: UITableViewController {

    // MARK: UIViewController

    public override func viewDidLoad() {
        super.viewDidLoad()
        airports = AirportDataSource.shared.airportsMatching(nil)
    }

    // MARK: UITableViewDataSource
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search-id", for: indexPath)
        let airport = airports[indexPath.row]
        cell.textLabel?.text = airport.name
        cell.detailTextLabel?.text = airport.shortCode
        return cell
    }

    // MARK: UITableViewDelegate

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectAirport(airports[indexPath.row])
        dismiss(animated: true, completion: nil)
    }

    /// Completion block called when user select's an airport from the tableview
    public var didSelectAirport: (Airport) -> Void = { _ in }

    private var airports = [Airport]()
}

extension AirportSearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.airports = AirportDataSource.shared.airportsMatching(searchText)
        self.tableView.reloadData()
    }
}
