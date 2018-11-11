//
//  AddPollViewController.swift
//  Vote
//
//  Created by Jacob Haff on 11/10/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation
import UIKit

class AddPollViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    private var selectedImage: UIImage?
    private var selectedImageView: UIImageView?
    
    // MARK: Actions
    
    @IBAction func topImageTapped(_ sender: UITapGestureRecognizer) {
        displayImagePicker()
        
        topImageView.image = selectedImage
        selectedImageView = topImageView
    }
    
    @IBAction func bottomImageTapped(_ sender: UITapGestureRecognizer) {
        displayImagePicker()
        
        bottomImageView.image = selectedImage
        selectedImageView = bottomImageView
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Private Functions
    
    private func displayImagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    private func setupViews(){
        topImageView.layer.cornerRadius = 22
        bottomImageView.layer.cornerRadius = 22
        topImageView.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 10, blur: 11)
        bottomImageView.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 10, blur: 11)
            navBar.shadowImage = UIImage()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension AddPollViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage{
            selectedImageView?.image = selectedImage
        } else {
            selectedImageView?.image = info[.originalImage] as? UIImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
