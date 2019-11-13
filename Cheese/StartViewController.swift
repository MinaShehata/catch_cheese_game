//
//  StartViewController.swift
//  Cheese
//
//  Created by Mac Shop on 10/31/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "openGameScene", sender: nil)
        
    }

}
