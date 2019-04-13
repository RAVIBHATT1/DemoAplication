//
//  shippingorder.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/14/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit


class shippingorder: UIViewController {
    @IBAction func btnaction(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "OrderingVC")
        self.present(second, animated: true, completion: nil)
    }
    
    @IBAction func btncheckoutAction(_ sender: Any) {
        if txtName.text == ""
        {
            print("Please enter full name !")
        }
        else if txtPhoneNo.text == ""
        {
            print( "Please enter phone number !")
        }
        else if txtAddress.text == ""
        {
            print("Please enter shipping address !")
        }
        else if txtName.text != "" || txtPhoneNo.text != "" || txtAddress.text != ""
        {
           // JustHUD.shared.showInView(view: view)
            callPlaceOrder()
        }
    }
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPhoneNo: UITextField!
    @IBOutlet var txtAddress: UITextField!
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var BtnCHeckout: UIButton!
    var lat  = Double()
    var log = Double()
    var totalAmount = String()
    var Cart = [CART_ITEM]()
    let cartArr = NSMutableArray()
     var outputmsg = String()
    var item_id = "pId"
    //var name = "pName"
    var price = "pPrice"
    var qnty = "pQnty"
    var custId = String()
    var myPrice = String()
    var locationManager = CLLocationManager()
    var myvc2txt : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let price = UserDefaults.standard.value(forKey: "MyPrice"){
            self.myPrice = price as! String
            print(myPrice)
        }
        self.lblTotalAmount.text = self.myPrice
  
        
    }
    
    @IBAction func selectLocationAction(_ sender: Any) {
        let viewController = LocationPickerController(success:
        {
            [weak self] (coordinate: CLLocationCoordinate2D) -> Void in
            //self?.txtAddress.text = "".appendingFormat("%.4f, %.4f",
            //  coordinate.latitude, coordinate.longitude)
            self?.getAddress(lat: coordinate.latitude, log: coordinate.longitude)
            
            self?.lat = coordinate.latitude
            self?.log = coordinate.longitude
            
            print("data=\(self?.lat,self?.log)")
        })
        
        
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    func getAddress(lat : Double, log :Double)
    {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            // Location name
            if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                address += locationName + ", "
            }
            
            // Street address
            if let street = placeMark?.addressDictionary?["Thoroughfare"] as? String {
                address += street + ", "
            }
            
            // City
            if let city = placeMark?.addressDictionary?["City"] as? String {
                address += city + ", "
            }
            
            // Zip code
            if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
                address += zip + ", "
            }
            
            // Country
            if let country = placeMark?.addressDictionary?["Country"] as? String {
                address += country
            }
            //print("address :\(address)")
            
            self.txtAddress.text = address
            // Passing address back
            //handler(address)
        })
    }
    


    func callPlaceOrder()
    {
        let cartArr = NSMutableArray()
        //var jsonData = String()
        if Cart.count > 0
        {
            for i in 0...Cart.count - 1
            {
                let cartDic = NSMutableDictionary()
                cartDic.setValue(Cart[i].pId!, forKey: "id")
                //cartDic.setValue(Cart[i].pName!, forKey: "name")
                cartDic.setValue(Cart[i].pPrice!, forKey: "price")
                cartDic.setValue(Cart[i].pQnty!, forKey: "qnty")
                cartArr.add(cartDic)
                
            }
            //print("jsonData :\(cartArr)")
        }
        // print("item_id :\(item_id)")
        
        let jsonObject = NSMutableDictionary()
        let innerDic = NSMutableDictionary()
        innerDic.setValue(item_id, forKey: "id")
        //innerDic.setValue(name, forKey: "name")
        innerDic.setValue(price, forKey: "price")
        innerDic.setValue(qnty, forKey: "qnty")
        jsonObject.setValue(cartArr, forKey: "CART_ITEM")
        
        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let str = String(data: data, encoding: .utf8)
        {
            print(str)
            callPlaceOrder(prod_json: str)
        }
    }
    
    func callPlaceOrder(prod_json: String)
    {
        //thread avti hati etle aa comment ma mukyu che !!! 
      custId =  UserDefaults.standard.value(forKey: "custId") as! String
        let url = URL(string: API_URL.PLACE_PRODUCT_ORDER)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "customer_id=\(custId)&product_json=\(prod_json)&shipping_name=\(txtName.text!)&shipping_mobile_number=\(txtPhoneNo.text!)&shipping_address=\(txtAddress.text!)&long=\(log)&lat=\(lat)"
        
        print("prodJson :\(postString)")
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {// check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            print("Your order has been placed successful!")
            
            DispatchQueue.main.sync
                {
                    let alert = UIAlertController(title: "", message: "Your order has been placed successfull.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler:
                    { (alert) in
                        let OrderPlaced = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderedPlacedVC")
                        
                        DispatchQueue.main.async {
                            self.deleteData()
                        }
                       self.present(OrderPlaced, animated: true)
                      //  JustHUD.shared.hide()
                        self.txtName.text = ""
                        self.txtPhoneNo.text = ""
                        self.txtAddress.text = ""
                       // self.lblTotalAmount.text = ""
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
            }
            
        }
        task.resume()
    }
    
    
    func fetchCartData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            Cart = try context.fetch(CART_ITEM.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    func deleteData()
    {
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CART_ITEM")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }
}
