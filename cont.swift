//
//  cont.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/23/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit


class cont: UIViewController {
    var mytimer = Timer()
    var mytime = 10
    @IBAction func btnaction(_ sender: Any) {
        //HomeVC
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "HomeVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBOutlet var MyView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let gif = UIImage(gifName: "star.gif")
        let MyView = UIImageView(gifImage: gif, loopCount: 10) // Use -1 for infinite loop
        MyView.frame = view.bounds
        view.addSubview(MyView)
        
        // Do any additional setup after loading the view.
         mytimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(myaction), userInfo: nil, repeats: true)
    }
    
    @objc func myaction()
    {
        mytime -= 1
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let second = main.instantiateViewController(withIdentifier: "HomeVC")
        self.present(second, animated: true, completion: nil)
        
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
