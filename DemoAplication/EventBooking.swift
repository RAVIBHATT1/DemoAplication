//
//  EventBooking.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/22/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class EventBooking: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var txtEvent: UITextField!
    @IBOutlet var txtEmployee: UITextField!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtForTime: UITextField!
    @IBOutlet var txtNotes: UITextField!
    @IBOutlet var btnBook: UIButton!
    
    var picker = UIDatePicker()
    var EventPickerView = UIPickerView()
    var EmployeePickerView =  UIPickerView()
    
    var selected_event_id = String()
    var selected_emp_id = String()
    var custId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmployeePickerView.dataSource = self
        fetch_event_list()
        fetch_employee_list()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bookedaction(_ sender: Any) {
        if txtEvent.text == ""
        {
          print( "Please select event !")
        }
        else if txtEmployee.text == ""
        {
            print( "Please select employee !")
        }
        else if txtDate.text == ""
        {
           print("Please select date !")
        }
        else if txtForTime.text == ""
        {
            print( "Please select time !")
        }
        else if txtEvent.text != "" || txtEmployee.text != "" || txtDate.text != "" || txtForTime.text != ""
        {
            inser_event_booking_details()
           // JustHUD.shared.showInView(view: view)
        }
        
    }
    
    @IBAction func ForTime(_ sender: Any) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeSelected))
        toolbar.setItems([done], animated: false)
        
        txtForTime.inputAccessoryView = toolbar
        txtForTime.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .time
    }
    @objc func timeSelected() {
        // format date
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        
        //formatter.dateFormat = " h:mm a"
        let dateString = formatter.string(from: picker.date)
        
        txtForTime.text = "\(dateString)"
        //toTime.text = "\(dateString)"
        self.view.endEditing(true)
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == EventPickerView
        {
            return JSONArray.arr_event_title.count
        }
        else if pickerView == EmployeePickerView
        {
            return JSONArray.arr_emp_title.count
        }
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == EventPickerView
        {
            return JSONArray.arr_event_title[row]
        }
        else if pickerView == EmployeePickerView
        {
            return JSONArray.arr_emp_title[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == EventPickerView
        {
            selected_event_id = JSONArray.arr_event_id[pickerView.selectedRow(inComponent: 0)]
            txtEvent.text = JSONArray.arr_event_title[row]
        }
        else if pickerView == EmployeePickerView
        {
            selected_emp_id = JSONArray.arr_event_id[pickerView.selectedRow(inComponent: 0)]
            txtEmployee.text = JSONArray.arr_emp_title[row]
        }
        
    }
    @IBAction func selectevent(_ sender: Any) {
        EventPickerView.delegate = self
        txtEvent.inputView = EventPickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(doneClicked))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtEvent.inputView = EventPickerView
        txtEvent.inputAccessoryView = toolBar
    }
    @IBAction func employvaluexhange(_ sender: Any) {
        EmployeePickerView.delegate = self
        txtEmployee.inputView = EmployeePickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(doneClicked))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtEmployee.inputView = EmployeePickerView
        txtEmployee.inputAccessoryView = toolBar
    }
    @objc func doneClicked() {
        txtEvent.resignFirstResponder()
        txtEmployee.resignFirstResponder()
        txtDate.resignFirstResponder()
    }
    
    func fetch_event_list()
    {
        let url = URL(string: API_URL.EVENT_LIST)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            print("ADATA:\(adata)")
            //JSON_FIELD.arr_event_id.removeAll()
            //JSON_FIELD.arr_event_title.removeAll()
            if let arrayJson = adata["event"] as? NSArray
            {
                for index in 0...(adata["event"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_event_id = (object["event_id"]as! String)
                    JSONArray.arr_event_id.append(arr_event_id)
                    
                    let arr_event_title = (object["event_category_name"]as! String)
                    JSONArray.arr_event_title.append(arr_event_title)
                    
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    
    
    func fetch_employee_list()
    {
        let url = URL(string: API_URL.EMPLOYEE_LIST)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            //JSON_FIELD.arr_emp_id.removeAll()
            // JSON_FIELD.arr_event_title.removeAll()
            if let arrayJson = adata["employeee"] as? NSArray
            {
                for index in 0...(adata["employeee"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_emp_id = (object["employee_id"]as! String)
                    JSONArray.arr_emp_id.append(arr_emp_id)
                    
                    let arr_emp_title = (object["employee_name"]as! String)
                    JSONArray.arr_emp_title.append(arr_emp_title)
                    
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    
    
    func inser_event_booking_details()
    {
        
        custId = UserDefaults.standard.value(forKey: "custId") as! String
        let url = URL(string: API_URL.EVENT_BOOKING)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "event_id=\(selected_event_id)&customer_id=\(custId)&employee_id=\(selected_emp_id)&booking_date=\(txtDate.text!)&booking_time=\(txtForTime.text!)&note=\(txtNotes.text!)"
        
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
            print("Registration Successful!")
            
            DispatchQueue.main.async
                {
                    let alert = UIAlertController(title: "", message: "Event Booking Successfull", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler:
                    { (alert) in
                        
                     //   let createAccount = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewBookedEventVC")as!  ViewBookedEvent
                      //  JustHUD.shared.hide()
                        self.txtForTime.text = ""
                        self.txtEvent.text = ""
                        self.txtDate.text = ""
                        self.txtEmployee.text = ""
                        self.txtNotes.text = ""
                       // self.navigationController?.pushViewController(createAccount, animated: true)
                    })
                    alert.addAction(okAction)
                   // self.present(alert, animated: true, completion: nil)
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let second = main.instantiateViewController(withIdentifier: "ViewBookedEventVC")
                    self.present(second, animated: true, completion: nil)
            }
        }
        task.resume()
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


