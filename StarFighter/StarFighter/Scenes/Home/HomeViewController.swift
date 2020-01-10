//
//  HomeViewController.swift
//  StarFighter
//
//  Created by Fabiana Montiel on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var BTN_sign_in: UIButton!
    @IBOutlet var BTN_create_account: UIButton!
    
    @IBAction func sign_in(_ sender: Any) {
        
        /*guard let navigationView = self.navigationController?.view else {
            return
        }
        UIView.transition(with: navigationView, duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.navigationController?.pushViewController(StarshipTableViewController(), animated: true)
        })*/
        
    }
    
    @IBAction func create_account(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        BTN_sign_in.titleLabel!.text = NSLocalizedString("sign_in", comment: "")
        BTN_create_account.titleLabel!.text = NSLocalizedString("create_account", comment: "")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
