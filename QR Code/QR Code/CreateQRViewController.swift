//
//  CreateQRViewController.swift
//  QR Code
//
//  Created by Dinesh Guptha Bavirisetti on 15/09/20.
//  Copyright © 2020 Dinesh Guptha Bavirisetti. All rights reserved.
//

import UIKit

class CreateQRViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var qrImageView: UIImageView!
    
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        textfield.layer.borderWidth = 1.0
        qrImageView.layer.borderWidth = 1.0

        textfield.layer.borderColor = UIColor.black.cgColor
        qrImageView.layer.borderColor = UIColor.black.cgColor

        textfield.layer.cornerRadius = 4.0
        qrImageView.layer.cornerRadius = 4.0

        textfield.attributedPlaceholder = NSAttributedString(string: "Enter Your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)])

        self.navigationItem.title = "Create QR Code"
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
    }

    @IBAction func createqrButtonAction(_ sender: Any) {
        if let text = textfield.text {
            let image = generateQRCode(from: text)
            qrImageView.image = image
        }
    }

    func generateQRCode(from string: String) -> UIImage? {
        let dict = ["name": string,"message":"Hello, Dinesh Guptha Bavirisetti"]
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]) else {
            return nil
        }

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
}
