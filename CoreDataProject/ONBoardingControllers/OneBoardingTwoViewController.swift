//
//  OneBoardingTwoViewController.swift
//  CoreDataProject
//
//  Created by Cykul Cykul on 21/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import UIKit

class OneBoardingTwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func skipButtonTwo(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "mainVC") as! ViewController
        self.present(mainVC, animated: true, completion: nil)
    }
    
}
