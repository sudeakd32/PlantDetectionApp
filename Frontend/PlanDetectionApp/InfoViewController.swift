import UIKit
import MapKit
import CoreLocation

class InfoViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var aboutThePlant: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var plantImageView: UIImageView!
    
    var receivedPlantName: String?
    var receivedPlantInfo: String?
    var receivedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        populateUI()
        styleUI()
    }

    private func populateUI() {
        plantImageView.image = receivedImage
        plantName.text = receivedPlantName ?? "Unknown Plant"
        
        aboutThePlant.text = "About The Plant:"
        
        textView.text = receivedPlantInfo ?? "No information available."
    }

    private func styleUI() {
        // Image
        plantImageView.layer.cornerRadius = 16
        plantImageView.clipsToBounds = true

        // TextView
        textView.layer.cornerRadius = 12
        textView.backgroundColor = UIColor.systemGray6

    }
}
