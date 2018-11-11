//
//  AddPollViewController.swift
//  Vote
//
//  Created by Jacob Haff on 11/10/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddPollViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var topCard: UIView!
    @IBOutlet weak var bottomCard: UIView!
    
    private var selectedImage: UIImage?
    private var selectedImageView: UIImageView?
    
    // MARK: Actions
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let topImageData = topImageView.image?.jpegData(compressionQuality: 1), let bottomImageData = bottomImageView.image?.jpegData(compressionQuality: 1) else {
            print("images not selected")
            return
        }
        let pollRef = Database.database().reference().child("polls").childByAutoId()

        guard let pollKey = pollRef.key else {
            print("no poll key")
            return
        }
        
        let photosRootRef = Storage.storage().reference().child("photos/\(pollKey)")
        let topPhotoRef = photosRootRef.child("top.jpg")
        let bottomPhotoRef = photosRootRef.child("bottom.jpg")
        
        let dispatchGroup = DispatchGroup()
        var uploadError: Error?
        dispatchGroup.enter()
        
        topPhotoRef.putData(topImageData, metadata: nil) { (metadata, error) in
            defer {
                dispatchGroup.leave()
            }
            
            guard error == nil else {
                print("Unable to upload photo: \(error?.localizedDescription ?? "No error")")
                uploadError = error
                return
            }
        }
        
        dispatchGroup.enter()

        bottomPhotoRef.putData(bottomImageData, metadata: nil) { (metadata, error) in
            defer {
                dispatchGroup.leave()
            }
            
            guard error == nil else {
                print("Unable to upload photo: \(error?.localizedDescription ?? "No error")")
                uploadError = error
                return
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if uploadError != nil {
                let alertController = UIAlertController(title: "Error!", message: "Unable to upload images, please try again 😅", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
                bottomPhotoRef.delete(completion: { error in
                    if let error = error {
                        print(error)
                    }
                })
                topPhotoRef.delete(completion: { error in
                    if let error = error {
                        print(error)
                    }
                })
            } else {
                self.dismiss(animated: true, completion: nil)
                pollRef.setValue(["displayInFeed": true,
                                  "createdAtDate": ServerValue.timestamp(),
                                  "userId": Auth.auth().currentUser?.uid])
            }
        }
        
    
        
        }
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
        topCard.layer.cornerRadius = 22
        bottomCard.layer.cornerRadius = 22
        topCard.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 10, blur: 11)
        bottomCard.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 10, blur: 11)
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
