//
//  MyOrderView.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/16/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class MyOrderView: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBAction func btnactioninvoicedetails(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "InvoiceDetailsVC")
        self.present(second, animated: true, completion: nil)
    }
    
    @IBOutlet var tvMyOrder: UITableView!
    var custId = String()
    var selectedOrderId = String()
    
    var orderId =  String()
    override func viewDidLoad() {
        super.viewDidLoad()
         fetchMyOrderDetails()
        tvMyOrder.delegate = self
        tvMyOrder.dataSource = self
        tvMyOrder.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONArray.arr_myOrder_id.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")as! MyOrderCell
        cell.orderId.text = JSONArray.arr_myOrder_id[indexPath.row]
        cell.orderDate.text = JSONArray.arr_myOrder_date[indexPath.row]
        cell.orderTime.text = JSONArray.arr_myOrder_time[indexPath.row]
        cell.price.text = JSONArray.arr_myOrder_price[indexPath.row]
        return cell
    }
    func fetchMyOrderDetails()
    {
        custId = UserDefaults.standard.value(forKey: "custId") as! String
        let url = URL(string: API_URL.FETCH_MYORDER_DETAILS + custId)
        do{
            print("url :\(url)")
            // print("arr_myOrder_id=\(JSON_FIELD.arr_myOrder_id)")
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSONArray.arr_myOrder_id.removeAll()
            JSONArray.arr_myOrder_date.removeAll()
            JSONArray.arr_myOrder_time.removeAll()
            JSONArray.arr_myOrder_price.removeAll()
            
            if let arrayJson = adata["ord_data"] as? NSArray
            {
                for index in 0...(adata["ord_data"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_myOrder_id = (object["order_id"]as! String)
                    JSONArray.arr_myOrder_id.append(arr_myOrder_id)
                    
                    let arr_myOrder_date = (object["order_date"]as! String)
                    JSONArray.arr_myOrder_date.append(arr_myOrder_date)
                    
                    let arr_myOrder_time = (object["order_time"]as! String)
                    JSONArray.arr_myOrder_time.append(arr_myOrder_time)
                    
                    let arr_myOrder_price = (object["total_amount"]as! String)
                    JSONArray.arr_myOrder_price.append(arr_myOrder_price)
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    

    
}
