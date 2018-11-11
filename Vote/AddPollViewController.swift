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
    
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
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
