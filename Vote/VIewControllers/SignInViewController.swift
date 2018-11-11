//
//  SignInViewController.swift
//  Vote
//
//  Created by Jacob Haff on 11/11/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignInViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().signInAnonymously { (result, error) in
            guard let result = result, error == nil else {
                print("Unable to sign in: \(error?.localizedDescription ?? "No error"))")
                return
            }
            
            print("Signed In with userid: \(result.user.uid)")
            self.performSegue(withIdentifier: "signInSegue", sender: self)
        }
    }
}
