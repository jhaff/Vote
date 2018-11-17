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
    
    @IBOutlet weak var submitButton: UIButton!
    
    private var selectedImage: UIImage?
    private var selectedImageView: UIImageView?
    private let compressionRatio: CGFloat = 0.5
    
    // MARK: Actions
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        submitButton.isEnabled = false
        guard let topImageData = topImageView.image?.jpegData(compressionQuality: compressionRatio), let bottomImageData = bottomImageView.image?.jpegData(compressionQuality: compressionRatio) else {
            print("images not selected")
            return
        }
        var poll = CreatablePoll(userId: Auth.auth().currentUser!.uid, displayInFeed: false)
        let pollRef = Collection.polls.ref.addDocument(model: poll)

        let photosRootRef = Storage.storage().reference().child("photos/\(pollRef.documentID)")
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
                pollRef.delete()
                self.submitButton.isEnabled = true
            } else {
                self.dismiss(animated: true, completion: nil)
                poll.displayInFeed = true
                pollRef.setData(poll.toDictionary())
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
        displayAlert(title: "Why?", message: "Why are you leaving me?", completion: {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
    }
    
    func displayAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
