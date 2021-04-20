//
//  ViewController.swift
//  Mercado
//
//  Created by Mayar Adel on 4/20/21.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
