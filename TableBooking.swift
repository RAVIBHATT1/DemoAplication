//
//  TableBooking.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/22/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class TableBooking: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var txtTableDescription: UITextField!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtTime: UITextField!
    @IBOutlet var txtTableName: UITextField!
    @IBOutlet var txtNo_of_Person: UITextField!
    @IBOutlet var btnTableBooking: UIButton!
    var custId = String()
    var picker = UIDatePicker()
    var tablePickerView = UIPickerView()
    var selected_user_id = String()
    var selected_table_id = String()
    @IBAction func selecttable(_ sender: Any) {
        tablePickerView.delegate = self
        txtTableName.inputView = tablePickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(doneClicked))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtTableName.inputView = tablePickerView
        txtTableName.inputAccessoryView = toolBar
    }
    @objc func doneClicked() {
        txtTableName.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fetch_table_name()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnbooktable(_ sender: Any) {
        if txtTableName.text == ""
        {
            print("Please Select table name !")
        }
        else if txtDate.text == ""
        {
            print( "Please Select date !")
        }
        else if txtTime.text == ""
        {
            print("Please Select time !")
        }
        else if txtDate.text == ""
        {
            print("Please Select date !")
        }
        else if txtTableName.text != "" || txtTableDescription.text != "" || txtDate.text != "" || txtTime.text != "" || txtNo_of_Person.text != ""
        {
            insert_table_booking_details()
           // JustHUD.shared.showInView(view: view)
        }
        
    }
    
    @IBAction func selectDate(_ sender: Any) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .date
    }
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        //formatter.dateFormat = "MMM dd, yyyy h:mm a"
        formatter.dateFormat = "MMM dd, yyyy"
        let dateString = formatter.string(from: picker.date)
        
        txtDate.text = "\(dateString)"
        self.view.endEditing(true)
    }
    @IBAction func selectTime(_ sender: Any) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeSelected))
        toolbar.setItems([done], animated: false)
        
        txtTime.inputAccessoryView = toolbar
        txtTime.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .time
        
    }
    @objc func timeSelected() {
        // format date
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        
        //formatter.dateFormat = " h:mm a"
        let dateString = formatter.string(from: picker.date)
        
        txtTime.text = "\(dateString)"
        //toTime.text = "\(dateString)"
        self.view.endEditing(true)
    }
    func insert_table_booking_details()
    {
        
        custId = UserDefaults.standard.value(forKey: "custId") as! String
        let url = URL(string: API_URL.INSERT_TABLE_BOOKING)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "table_description=\(txtTableDescription.text!)&customer_id=\(custId)&table_id=\(selected_table_id)&date=\(txtDate.text!)&time=\(txtTime.text!)&no_of_person=\(txtNo_of_Person.text!)"
        
        print("postString:\(postString)")
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            print("Table Booking Successful!")
            
            DispatchQueue.main.async
                {
                    let alert = UIAlertController(title: "", message: "Table Booking Successful!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler:
                    { (alert) in
                        
                        
                     //   let createAccount = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewBookedTableVC")as!  ViewBookedTable
                     //   JustHUD.shared.hide()
                        self.txtTableName.text = ""
                        self.txtTime.text = ""
                        self.txtDate.text = ""
                        self.txtTableDescription.text = ""
                       
                     //   self.navigationController?.pushViewController(createAccount, animated: true)
                    })
                    alert.addAction(okAction)
                   // self.present(alert, animated: true, completion: nil)
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let second = main.instantiateViewController(withIdentifier: "ViewBookedTableVC")
                    self.present(second, animated: true, completion: nil)
                    
            }
        }
        task.resume()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return JSONArray.arr_table_title.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return JSONArray.arr_table_title[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_table_id = JSONArray.arr_table_id[pickerView.selectedRow(inComponent: 0)]
        txtTableName.text = JSONArray.arr_table_title[row]
    }
    
    func fetch_table_name()
    {
        let url = URL(string: API_URL.FETCH_TABLE_TITLE)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            //JSON_FIELD.arr_emp_id.removeAll()
            // JSON_FIELD.arr_event_title.removeAll()
            if let arrayJson = adata["Table"] as? NSArray
            {
                for index in 0...(adata["Table"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_table_id = (object["table_id"]as! String)
                    JSONArray.arr_table_id.append(arr_table_id)
                    
                    let arr_table_title = (object["table_name"]as! String)
                    JSONArray.arr_table_title.append(arr_table_title)
                    
                    //let arr_no_of_p = (object["no_of_seat"]as! String)
                    //JSON_FIELD.arr_no_of_p.append(arr_table_title)
                    
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


