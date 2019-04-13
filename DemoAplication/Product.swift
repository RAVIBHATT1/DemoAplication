//
//  Product.swift
//  DemoAplication
//
//  Created by Akash Padhiyar on 07/03/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class Product: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var MyLabel2: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONArray.arr_item_name.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemTable.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let HOME = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsVC")as! ProductDetails
        HOME.productTitle = JSONArray.arr_item_name[indexPath.row]
        HOME.productPrice = JSONArray.arr_item_price[indexPath.row]
        HOME.productId = JSONArray.arr_item_id[indexPath.row]
        HOME.productImage = JSONArray.arr_item_image[indexPath.row]
        selected_subCate_Id = JSONArray.arr_sub_cat_id[indexPath.row]
        HOME.selected_subCate_Id = selected_subCate_Id
        self.present(HOME,animated: true,completion: nil)
        print("clicked in row")
    }
    
    @IBAction func btnback(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "SubCategoryVC")
        self.present(second, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MyCell")as! ProductCell
        
        //cell.lblSubCatTitle.text = JSON_FIELD.arr_sub_cat_title[indexPath.row]
        //cell.lblCatTitle.text = JSON_FIELD.arr_s_cat_title[indexPath.row]
        
        cell.MyLabel.text = JSONArray.arr_item_name[indexPath.row]
        MyLabel2.text = JSONArray.arr_item_subCatTitle[indexPath.row]
        //cell.lblPrice.text = JSON_FIELD.arr_item_price[indexPath.row]
        
        if let imageURL = URL(string: JSONArray.arr_item_image[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.MyImageView.layer.cornerRadius = 8.0
                            cell.MyImageView.clipsToBounds = true
                            cell.MyImageView.image = image
                        }
                    }
            }
        }
        
        //JustHUD.shared.hide()
        return cell
    }
    
    @IBOutlet weak var itemTable: UITableView!
    
var selected_subCate_Id = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTable.delegate = self
        itemTable.dataSource = self
        
        itemTable.reloadData()
        itemTable.tableFooterView = UIView()
        
       fetch_item_list()
        // Do any additional setup after loading the view.
    }
    
    
    func fetch_item_list()
    {
        let url = URL(string:API_URL.PRODUCT_LIST_URL + selected_subCate_Id)
        do{
            
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            print("adata:\(adata)")
            JSONArray.arr_item_id.removeAll()
            JSONArray.arr_item_name.removeAll()
            JSONArray.arr_item_image.removeAll()
            JSONArray.arr_item_price.removeAll()
            JSONArray.arr_item_subCatId.removeAll()
            JSONArray.arr_item_subCatTitle.removeAll()
            
            if let arrayJson = adata["product"] as? NSArray
            {
                for index in 0...(adata["product"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_item_id = (object["item_id"]as! String)
                    JSONArray.arr_item_id.append(arr_item_id)
                    
                    let arr_item_image = (object["item_image"]as! String)
                    JSONArray.arr_item_image.append(arr_item_image)
                    
                    let arr_item_name = (object["item_name"]as! String)
                    JSONArray.arr_item_name.append(arr_item_name)
                    
                    let arr_item_price = (object["price"]as! String)
                    JSONArray.arr_item_price.append(arr_item_price)
                    
                    let arr_item_subCatId = (object["sub_category_id"]as! String)
                    JSONArray.arr_item_subCatId.append(arr_item_subCatId)
                    
                    let arr_item_subCatTitle = (object["sub_category_name"]as! String)
                    JSONArray.arr_item_subCatTitle.append(arr_item_subCatTitle)
                    
                }
            }
        }
        catch
        {print("error=\(error)")
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
