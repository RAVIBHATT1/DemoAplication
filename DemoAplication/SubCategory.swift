//
//  SubCategory.swift
//  DemoAplication
//
//  Created by Akash Padhiyar on 07/03/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class SubCategory: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var MyLabel2: UILabel!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return JSONArray.arr_sub_cat_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MyCell")as! SubCategoryCell
        
       cell.MyLabel.text = JSONArray.arr_sub_cat_title[indexPath.row]
        MyLabel2.text = JSONArray.arr_s_cat_title[indexPath.row]
        
        
        if let imageURL = URL(string: JSONArray.arr_sub_cat_img[indexPath.row])
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
                            cell.MyImageView.image = image
                            cell.MyImageView.clipsToBounds = true
                        }
                    }
            }
        }
        
        //JustHUD.shared.hide()
        return cell
    }
    @IBAction func btnBack(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "HomeVC")
        self.present(second, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        subCatTable.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let HOME = storyBoard.instantiateViewController(withIdentifier: "ProductVC")as! Product
        selected_subCate_Id = JSONArray.arr_sub_cat_id[indexPath.row]
        HOME.selected_subCate_Id = selected_subCate_Id
        self.present(HOME,animated: true,completion: nil)
       // print("clicked in row")
    }

    @IBOutlet weak var subCatTable: UITableView!
    var selected_cat_id  = String()
    
    var selected_subCate_Id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subCatTable.reloadData()
        subCatTable.tableFooterView = UIView()
        
        subCatTable.delegate = self
        subCatTable.dataSource = self
        
        fetch_sub_category_list()

        // Do any additional setup after loading the view.
    }
    
    func fetch_sub_category_list()
    {
        let url = URL(string: API_URL.SUB_CATEGORY_URL + selected_cat_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            
            JSONArray.arr_sub_cat_id.removeAll()
            JSONArray.arr_sub_cat_title.removeAll()
            JSONArray.arr_sub_cat_img.removeAll()
            JSONArray.arr_s_cat_title.removeAll()
            
            
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                for index in 0...(adata["subcategory"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let eventIdJson = (object["sub_category_id"]as! String)
                    JSONArray.arr_sub_cat_id.append(eventIdJson)
                    
                    let arr_sub_cat_title = (object["sub_category_name"]as! String)
                    JSONArray.arr_sub_cat_title.append(arr_sub_cat_title)
                    
                    let arr_sub_cat_img = (object["sub_category_image"]as! String)
                    JSONArray.arr_sub_cat_img.append(arr_sub_cat_img)
                    
                    let arr_cat_title = (object["category_name"]as! String)
                    JSONArray.arr_s_cat_title.append(arr_cat_title)
                    
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
