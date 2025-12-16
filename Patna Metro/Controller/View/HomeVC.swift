//
//  HomeVC.swift
//  Patna Metro
//
//  Created by Rohit on 20/09/25.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func findRouteBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlanYourJournyVC") as! PlanYourJournyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func mapBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MetroMapVC") as! MetroMapVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
