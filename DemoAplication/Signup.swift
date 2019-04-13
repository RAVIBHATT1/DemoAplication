//
//  Signup.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/5/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class Signup: UIViewController {

    @IBAction func btnSubmitAaction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let LOGIN = storyBoard.instantiateViewController(withIdentifier: "LoginVC")as! ViewController
        self.present(LOGIN,animated: true,completion: nil)

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
