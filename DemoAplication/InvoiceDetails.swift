//
//  InvoiceDetails.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/19/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class InvoiceDetails: UIViewController , UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return JSONArray.arr_view_Ord_Name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")as! InvoiceTableCell
        
        cell.lblOrdTitle.text = JSONArray.arr_view_Ord_Name[indexPath.row]
        cell.lblOrdPrice.text = JSONArray.arr_view_Ord_price[indexPath.row]
        cell.lblOrdQnty.text = JSONArray.arr_view_Ord_qnty[indexPath.row]
        
        return cell
    }
    
    
    @IBOutlet var tvOrdView: UITableView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var lblCustomerName: UILabel!
    @IBOutlet var lblMobileNo: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblTotalPrice: UILabel!
    var cutId = String()
    var orderId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        tvOrdView.delegate = self
        tvOrdView.dataSource = self
        
        tvOrdView.tableFooterView = UIView()
        print("orderId:- \(orderId)")
        
        fetchOrderDetails()
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
    func fetchOrderDetails()
    {
        
        //cutId = UserDefaults.standard.value(forKey: "custId") as! String
        
        let url = URL(string: API_URL.DISPLAY_ORDER_DETAILS + orderId)
        do{
            print("selectedOrderId:\(url)")
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            //print("adata:\(adata)")
            JSONArray.arr_view_order_id.removeAll()
            JSONArray.arr_view_order_date.removeAll()
            JSONArray.arr_view_order_time.removeAll()
            JSONArray.arr_view_order_shippingname.removeAll()
           JSONArray.arr_view_order_shippingmobile.removeAll()
            JSONArray.arr_view_order_shippingaddress.removeAll()
            JSONArray.arr_view_order_total_amount.removeAll()
            
            
            if let arrayJson = adata["ord_data"] as? NSArray
            {
                print("arrayJson:\(arrayJson)")
                for index in 0...(adata["ord_data"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_view_order_id = (object["order_id"]as! String)
                    JSONArray.arr_view_order_id.append(arr_view_order_id)
                    
                    let arr_view_order_date = (object["order_date"]as! String)
                    JSONArray.arr_view_order_date.append(arr_view_order_date)
                    
                    let arr_view_order_time = (object["order_time"]as! String)
                    JSONArray.arr_view_order_time.append(arr_view_order_time)
                    
                    let arr_view_order_shippingname = (object["shippingname"]as! String)
                    JSONArray.arr_view_order_shippingname.append(arr_view_order_shippingname)
                    
                    let arr_view_order_shippingmobile = (object["shippingmobile"]as! String)
                    JSONArray.arr_view_order_shippingmobile.append(arr_view_order_shippingmobile)
                    
                    let arr_view_order_shippingaddress = (object["shippingaddress"]as! String)
                    JSONArray.arr_view_order_shippingaddress.append(arr_view_order_shippingaddress)
                    
                    let arr_view_order_total_amount = (object["total_amount"]as! String)
                    JSONArray.arr_view_order_total_amount.append(arr_view_order_total_amount)
                    
                    JSONArray.arr_view_Ord_Prd_id.removeAll()
                    JSONArray.arr_view_Ord_qnty.removeAll()
                    JSONArray.arr_view_Ord_price.removeAll()
                    JSONArray.arr_view_Ord_Name.removeAll()
                    
                    if let arrJson = object["prd"] as? NSArray
                    {
                        print("ProdData :\(arrJson)")
                        for index in 0...(object["prd"]?.count)! - 1
                        {
                            let object = arrJson[index]as! [String:AnyObject]
                            
                            let arr_view_Ord_Prd_id = (object["prd_id"]as! String)
                            JSONArray.arr_view_Ord_Prd_id.append(arr_view_Ord_Prd_id)
                            
                            let arr_view_Ord_Name = (object["prd_name"]as! String)
                            JSONArray.arr_view_Ord_Name.append(arr_view_Ord_Name)
                            
                            let arr_view_Ord_price = (object["prd_price"]as! String)
                            JSONArray.arr_view_Ord_price.append(arr_view_Ord_price)
                            
                            let arr_view_Ord_qnty = (object["prd_qty"]as! String)
                           JSONArray.arr_view_Ord_qnty.append(arr_view_Ord_qnty)
                            
                        }
                    }
                    
                }
                
            }
        }
        catch
        {print("error=\(error)")
        }
        printData()
    }
    
    func printData()
    {
        lblCustomerName.text = JSONArray.arr_view_order_shippingname
        lblDateTime.text = "\(JSONArray.arr_view_order_date), \(JSONArray.arr_view_order_time)"
        lblAddress.text = JSONArray.arr_view_order_shippingaddress
        lblMobileNo.text = JSONArray.arr_view_order_shippingmobile
        lblTotalPrice.text = JSONArray.arr_view_order_total_amount
        
        
    }
    

}
