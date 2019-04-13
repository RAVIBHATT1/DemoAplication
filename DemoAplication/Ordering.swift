//
//  Ordering.swift
//  DemoAplication
//
//  Created by Akash Padhiyar on 08/03/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class Ordering: UIViewController,cartDelegate ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return Cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")as! OrderingCell
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        cell.lblProductTitle.text = Cart[indexPath.row].pName
        cell.lblProductPrice.text = Cart[indexPath.row].pPrice
        cell.lblProductQnty.text = Cart[indexPath.row].pQnty
        
        return cell
    }
   
    @IBAction func btnorderplc(_ sender: Any) {
       let OrderingVC1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shippingorderVC")as! shippingorder
        let PRC = lblTotalPrice.text
        UserDefaults.standard.setValue(PRC, forKey: "MyPrice")
        //OrderingVC.productID = productId
       self.present(OrderingVC1, animated: true)
     
        
        
    }
    
    
    @IBAction func btnback(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "ProductDetailsVC")
        self.present(second, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderTable.deselectRow(at: indexPath, animated: false)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "", message: "Are you sure want to delete!", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Ok", style: .default)
        { (alert) in
            
            if editingStyle == .delete
            {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                context.delete(self.Cart[indexPath.row])
                self.Cart.remove(at: indexPath.row)
                
                do{
                    try context.save()
                    self.showCartCount()
                } catch{
                    print(Error.self)
                }
                self.orderTable.reloadData()
                self.showCartCount()
                //self.viewDidLoad()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
var Cart = [CART_ITEM]()
    var productID = String()
    var selected_subCate_Id = String()
      var totalPrice :Int = 0
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet var lblTotalPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        btnOrder.layer.cornerRadius = 15.0
        orderTable.delegate = self
        orderTable.dataSource = self
        
        orderTable.tableFooterView = UIView()
        orderTable.reloadData()
        
        FETCH_CART_DATA()
        showCartCount()
        
        if Cart.count > 0
        {
            
        }
        else
        {
            norecord()
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        FETCH_CART_DATA()
    }
  
    func addClick(at index: IndexPath) {
        let qty = Int(Cart[index.row].pQnty!)! + 1
        Cart[index.row].pQnty = String(qty)
        
        //save the data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.orderTable.reloadData()
        self.showCartCount()
    }
    
    func removeClick(at index: IndexPath)
    {
        print("clicked")
        
        let qty = Int(Cart[index.row].pQnty!)! - 1
        print("qty:\(qty)")
        Cart[index.row].pQnty = String(qty)
        
        print("Cart[index.row].pQnty:\(Cart[index.row].pQnty)")
        if Cart[index.row].pQnty == "0"
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let cart = self.Cart[index.row]
            context.delete(cart)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                self.Cart = try context.fetch(CART_ITEM.fetchRequest())
                if Cart.count > 0
                {
                    self.orderTable.reloadData()
                    FETCH_CART_DATA()
                }
                else
                {
                    if Cart.count > 0{
                        orderTable.isHidden = false
                        FETCH_CART_DATA()
                    }
                    else
                    {
                        norecord()
                    }
                }
                
            }catch{
                print(error)
            }
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.orderTable.reloadData()
        showCartCount()
    }
    
    func showCartCount()
    {
        if Cart.count > 0
        {
            totalPrice = 0
            for i in 0...Cart.count - 1{
                let totalAmount = Int(Cart[i].pPrice!)! * Int(Cart[i].pQnty!)!
                totalPrice +=  totalAmount + 50
            }
        }
        print("Total Price1 : \(totalPrice)")
        lblTotalAmount.text = "\(totalPrice)"
        lblTotalPrice.text = "\(totalPrice)"
    }
        //price userdefault
       
     
    
    func FETCH_CART_DATA()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            Cart = try context.fetch(CART_ITEM.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    func norecord()
    {
        let childViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmptyCart")
        self.addChild(childViewController)
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        FETCH_CART_DATA()
        showCartCount()
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
