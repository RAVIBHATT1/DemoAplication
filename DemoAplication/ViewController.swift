//
//  ViewController.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/5/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var lblscrollview: UILabel!
    var uId = String()
    var loginStatus = Int()
    var status = Int()
    
    @IBAction func submitAction(_ sender: Any) {
        //submity buttun link
       // let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //let HOME = storyBoard.instantiateViewController(withIdentifier: "HomeVC")as! Home
        
       // self.present(HOME,animated: true,completion: nil)
    
        print("clicked ")
        let email = txtEmail.text
        let pass = txtPassword.text
        
        if txtEmail.text == ""
        {
           print( "Please enter email !")
        }
        else if txtPassword.text == ""
        {
            print("Please enter password !")
        }
        else if email != "" && pass != ""{
            
          self.loginData()
           // JustHUD.shared.showInView(view: view)
        }
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        
        //registration button link
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let SIGNUP = storyBoard.instantiateViewController(withIdentifier: "SignupVC")as! Signup
        self.present(SIGNUP,animated: true,completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         btnLogin.layer.cornerRadius = 18.0
        UIView.animate(withDuration: 8.0, delay:0, options: [.repeat], animations: {
            self.lblscrollview.frame = CGRect(x: Double(self.lblscrollview.frame.origin.x - 500), y: Double(self.lblscrollview.frame.origin.y - 0), width: Double(self.lblscrollview.frame.size.width), height: Double(self.lblscrollview.frame.size.height))
        }, completion: nil)

        // Do any additional setup after loading the view, typically from a nib.
    }
    func loginData()
    {
        let url = URL(string: API_URL.LOGIN_URL)
        var request = URLRequest(url:url!)
        request.httpMethod = "POST"
        let postString = "e_mail=\(txtEmail.text!)&password=\(txtPassword.text!)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            
            guard let data = data, error == nil else{
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode  should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                
                self.status = json["success"] as! Int
                print("Status \(self.loginStatus)")
                
                self.loginStatus = self.status
                print("loginStatus: \(self.loginStatus)")
                DispatchQueue.main.async
                    {
                        if self.loginStatus == 1
                        {
                            //for the change password
                            let uid = json["userdata"]!["customer_id"]
                            self.uId = uid as! String
                            UserDefaults.standard.set(self.uId, forKey: "custId")
                            print("uId:\(self.uId)")
                            UserDefaults.standard.set(1, forKey: "success")
                            
                            print("Status:=\(self.status)")
                            // SKToast.show(withMessage: "Login successfull!")
                            let createAccount = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")as! Home
                         //self.appDelegate.loginLogout = true
                        //    JustHUD.shared.hide()
                            self.navigationController?.pushViewController(createAccount, animated: true)
                            self.txtEmail.text = ""
                            self.txtPassword.text = ""
                        }
                        else if self.loginStatus == 0
                        {
                         //  self.appDelegate.loginLogout = false
                         //   JustHUD.shared.hide()
                            self.txtEmail.becomeFirstResponder()
                           print("Login fail!")
                        }
                }
            }
            catch{print(error)
            }
        }
        task.resume()
    }

}

