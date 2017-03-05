//
//  SigninVC.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 2/19/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import UIKit
import FirebaseAuth

class SigninVC: UIViewController {
    
    private let MAP_SEGUE = "MapVC"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
}
