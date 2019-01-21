//
//  ONBoardingOneViewController.swift
//  CoreDataProject
//
//  Created by Cykul Cykul on 21/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import UIKit

class ONBoardingOneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func skipButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "skipscreen", sender: self)
    }
    
}
