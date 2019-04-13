//
//  More.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/14/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class More: UIViewController {

    @IBAction func tblbooking(_ sender: Any) {
       
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "TableBookingVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBAction func changaction(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "ChangeVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBAction func orderaction(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "MyorderVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBAction func feedbackaction(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "FeedbackVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBAction func aboutusaction(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "AboutusVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBAction func contactus(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "ContactusVC")
        self.present(second, animated: true, completion: nil)
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
