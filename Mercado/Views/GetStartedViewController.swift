//
//  GetStartedViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 4/22/21.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func getStartedBtn(_sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginTableViewController
        self.present(vc, animated: true, completion: nil)
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
