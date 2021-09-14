//
//  ViewController.swift
//  MarsPictures
//
//  Created by Alex Cannizzo on 14/09/2021.
//

import UIKit

class ViewController: UIViewController, MarsManagerDelegate {
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var marsManager = MarsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marsManager.delegate = self
        marsManager.performRequest()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        textView.isHidden = true
        imageView.isUserInteractionEnabled = false
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if textView.isHidden {
            textView.isHidden = false
        } else {
            textView.isHidden = true
        }
    }
    
    func didRetrieveData(_ marsManager: MarsManager, mars: MarsModel) {
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: mars.imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                let toImage = image
                UIView.transition(with: self.imageView, duration: 0.3, options: .transitionCrossDissolve, animations: { self.imageView.image = toImage }, completion: nil)
                self.imageView.isUserInteractionEnabled = true
                self.textView.isHidden = false
                self.imageView.image = image
                self.textView.text = mars.explanation
            }
        }
        
    }
    
    func didRetrieveWithError(error: Error) {
        print(error)
    }
    
}

