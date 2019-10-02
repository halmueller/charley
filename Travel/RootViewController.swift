import UIKit

/// RootViewController is the home/first landing view controller of the app, responsible for launching AirportSearchViewControllers and handling "booking".
class RootViewController: UIViewController {

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let navigationController = segue.destination as? UINavigationController,
            let picker = navigationController.topViewController as? AirportSearchViewController
        else {
            fatalError("Shouldn't ever happen!")
        }
        picker.title = segue.identifier == "from" ? "Departing from" : "Arriving at"
        picker.didSelectAirport = { [weak self] in
            if segue.identifier == "from" {
                self?.fromAirport = $0
            } else {
                self?.toAirport = $0
            }
        }
    }

    // MARK: Booking

    @IBAction
    private func submitAction(_ sender: Any) {
        if let from = fromAirport, let to = toAirport {
            presentAlert("Booked!", message: "Book flight from '\(from.name)' to '\(to.name)'")
        } else if fromAirport == nil {
            presentAlert("Error!", message: "Please select an airport to fly from.")
        } else if toAirport == nil {
            presentAlert("Error!", message: "Please select an airport to fly from.")
        }
    }

    private func presentAlert(_ title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }

    // MARK: From/To Buttons

    @IBOutlet private var fromButton: UIButton!
    private var fromAirport: Airport? {
        didSet {
            let title = fromAirport?.shortCode ?? "SELECT"
            fromButton.setTitle(title, for: .normal)
        }
    }

    @IBOutlet private var toButton: UIButton!
    private var toAirport: Airport? {
        didSet {
            let title = toAirport?.shortCode ?? "SELECT"
            toButton.setTitle(title, for: .normal)
        }
    }
}
