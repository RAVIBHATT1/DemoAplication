//
//  ProductDetails.swift
//  DemoAplication
//
//  Created by Akash Padhiyar on 07/03/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class ProductDetails: UIViewController{
    
    @IBOutlet weak var ivProductImage: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        showAdd_View_Button()
    }
    func showAdd_View_Button()
    {
        FETCH_CART_DATA()
        
        if self.Cart.count > 0
        {
            print("self.productId :\(self.productId)")
            for indexCart in 0..<self.Cart.count
            {
                if Cart[indexCart].pId == self.productId
                {   btnPlaceOrder.isHidden = true
                    btnView.isHidden = false
                    break
                }else {
                    btnPlaceOrder.isHidden = false
                    btnView.isHidden = true
                }
            }
        }else {
            btnPlaceOrder.isHidden = false
            btnView.isHidden = true
        }
    }
    @IBAction func btnaction(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "ProductVC")
        self.present(second, animated: true, completion: nil)
    }
    @IBAction func btnViewAction(_ sender: Any) {
       showAdd_View_Button()
        FETCH_CART_DATA()
        let OrderingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderingVC")as! Ordering
        //OrderingVC.productID = productId
        self.present(OrderingVC, animated: true)
    }
    @IBAction func AddToCart(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let cartData = CART_ITEM(context: context)
        
        count = 0
        //for the count
        count += 1
        
        cartData.pQnty = "\(self.count)"
        cartData.pName = productTitle
        cartData.pPrice = productPrice
        cartData.pImage = productImage
        print(cartData.pImage = productImage)
        cartData.pId = productId
        
        btnPlaceOrder.isHidden = true
        btnView.isHidden =  false
        //save the data into table
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        FETCH_CART_DATA()
        showAdd_View_Button()
        
        let OrderingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderingVC")as! Ordering
        OrderingVC.productID = productId
        OrderingVC.selected_subCate_Id = selected_subCate_Id
        self.present(OrderingVC, animated: true)
        
    }
    var productTitle = String()
    var productImage = String()
    var productQnty = String()
    var productPrice = String()
    var productId = String()
    
    var count = Int()
   var Cart = [CART_ITEM]()
var selected_subCate_Id = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        btnPlaceOrder.layer.cornerRadius = 15.0
        btnView.layer.cornerRadius = 15.0
       print_item_details()
       FETCH_CART_DATA()

        // Do any additional setup after loading the view.
    }
    func print_item_details()
    {
        if let imageURL = URL(string: productImage)
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.ivProductImage.layer.cornerRadius = 8.0
                            self.ivProductImage.clipsToBounds = true
                            self.ivProductImage.image = image
                        }
                    }
            }
        }
        
        lblProductTitle.text = productTitle
        lblProductPrice.text = productPrice
    }
   func FETCH_CART_DATA()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            Cart = try context.fetch(CART_ITEM.fetchRequest())
        }catch{
            print(error)
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

}
