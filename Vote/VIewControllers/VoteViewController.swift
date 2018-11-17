//
//  ViewController.swift
//  Vote
//
//  Created by Jacob Haff on 11/10/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    private func setupViews(){
        topImageView.layer.cornerRadius = 22
        bottomImageView.layer.cornerRadius = 22
        topImageView.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 10, blur: 11)
        bottomImageView.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: 10, blur: 11)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        
    }


}

