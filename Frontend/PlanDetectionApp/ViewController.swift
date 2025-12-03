import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "placeholder")
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
        
        styleButton(uploadButton, color: UIColor.systemPurple)
            styleButton(infoButton, color: UIColor.systemTeal)

            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 16
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.systemGray6
        
    }
    
    
    func styleButton(_ button: UIButton, color: UIColor) {
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.15
        button.layer.shadowRadius = 6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    @IBAction func selectImage(_ sender: Any) {
        let alert = UIAlertController(title: "Select Image",
                                             message: nil,
                                             preferredStyle: .actionSheet)

               // Camera option
               if UIImagePickerController.isSourceTypeAvailable(.camera) {
                   alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
                       self.openCamera()
                   })
               }

               // Gallery option
               alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
                   self.openPhotoLibrary()
               })

               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

               present(alert, animated: true)
    }
    
    
    func openPhotoLibrary() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func openCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo",
           let dest = segue.destination as? InfoViewController,
           let dict = sender as? [String: Any] {

            dest.receivedPlantName = dict["name"] as? String
            dest.receivedPlantInfo = dict["info"] as? String
            dest.receivedImage = self.imageView.image
        }
    }
    
    func classifyPlant(image: UIImage, completion: @escaping (String, String) -> Void) {
        print("🚀 FONKSİYON BAŞLADI - İstek gönderiliyor...")

        guard let url = URL(string: "http://127.0.0.1:8000/classify") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Multipart config
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Image convert error")
            return
        }

        var body = Data()

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("REQUEST ERROR:", error)
                return
            }

            if let http = response as? HTTPURLResponse {
                print("STATUS:", http.statusCode)
            }

            guard let data = data else {
                print("No data received")
                return
            }

            print("RAW RESPONSE:", String(data: data, encoding: .utf8) ?? "")

            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                let name = json?["plant_name"] as? String ?? "Unknown"
                let info = json?["info"] as? String ?? "No information available."

                completion(name, info)

            } catch {
                print("JSON PARSE ERROR:", error)
            }

        }.resume()
    }
    
    
    @IBAction func getInfo(_ sender: Any) {

        guard let image = imageView.image else {
            print("No image selected!")
            return
        }

        classifyPlant(image: image) { name, info in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showInfo", sender: [
                    "name": name,
                    "info": info
                ])
            }
        }
    }

    
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }

        provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
            guard let uiImage = image as? UIImage else { return }
            DispatchQueue.main.async {
                self?.imageView.image = uiImage
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let img = info[.originalImage] as? UIImage {
            imageView.image = img
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

