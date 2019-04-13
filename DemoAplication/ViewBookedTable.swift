//
//  ViewBookedTable.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/22/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class ViewBookedTable: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tvTableBookingView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONArray.arr_tbl_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MyCell")as! BookedtableCell
        cell.lblTblName.text = JSONArray.arr_tbl_name[indexPath.row]
        cell.lblTblCustName.text = JSONArray.arr_tbl_customer_name[indexPath.row]
        cell.lblTblDesc.text = JSONArray.arr_tbl_desc[indexPath.row]
        cell.lblTblDate.text  = JSONArray.arr_tbl_date[indexPath.row]
        cell.lblTblTime.text = JSONArray.arr_tbl_time[indexPath.row]
        cell.lblNoOfPerson.text = JSONArray.arr_tbl_noOfperson[indexPath.row]
        
        return cell
    }
    
  var custId = String()
    @IBOutlet var tvTableBookingView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tvTableBookingView.delegate = self
      
        tvTableBookingView.dataSource = self
        tvTableBookingView.reloadData()
        tvTableBookingView.tableFooterView = UIView()
        
        callTableBookingData()

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
    func callTableBookingData()
     {
        custId = UserDefaults.standard.value(forKey: "custId") as! String
        let url = URL(string: API_URL.FETCH_TABLE_BOOKING_DATA + custId)
        do{
            print("url :\(url)")
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSONArray.arr_tbl_Booking_id.removeAll()
             JSONArray.arr_tbl_name.removeAll()
             JSONArray.arr_tbl_desc.removeAll()
             JSONArray.arr_tbl_customer_name.removeAll()
             JSONArray.arr_tbl_date.removeAll()
             JSONArray.arr_tbl_time.removeAll()
            
            if let arrayJson = adata["tblBookingView"] as? NSArray
            {
                for index in 0...(adata["tblBookingView"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_tbl_Booking_id = (object["table_booking_id"]as! String)
                     JSONArray.arr_tbl_Booking_id.append(arr_tbl_Booking_id)
                    
                    let arr_tbl_name = (object["table_name"]as! String)
                     JSONArray.arr_tbl_name.append(arr_tbl_name)
                    
                    let arr_tbl_desc = (object["table_description"]as! String)
                     JSONArray.arr_tbl_desc.append(arr_tbl_desc)
                    
                    let arr_tbl_customer_name = (object["customer_name"]as! String)
                     JSONArray.arr_tbl_customer_name.append(arr_tbl_customer_name)
                    
                    let arr_tbl_date = (object["date"]as! String)
                     JSONArray.arr_tbl_date.append(arr_tbl_date)
                    
                    let arr_tbl_noOfperson = (object["Number_of_persons"]as! String)
                     JSONArray.arr_tbl_noOfperson.append(arr_tbl_noOfperson)
                    
                    let arr_tbl_time = (object["time"]as! String)
                     JSONArray.arr_tbl_time.append(arr_tbl_time)
                    
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    
    

}
