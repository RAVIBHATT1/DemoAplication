//
//  Offer.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/23/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class Offer: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var imageArr = [String]()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return imageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")as! OfferTableViewCell
        //cell.ivOfferImage.image = UIImage(named: imageArr[indexPath.row])
        
        if let imageURL = URL(string: imageArr[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            //cell.ivProductImage.layer.cornerRadius = 8.0
                            //cell.ivProductImage.clipsToBounds = true
                            cell.ivOfferImage.image = image
                        }
                    }
            }
        }
        
        
        print("imageArr:\(imageArr)")
        return cell
    }
    

    @IBOutlet var tvOffers: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        fetch_category_list()
        tvOffers.delegate = self
        tvOffers.dataSource = self
        tvOffers.tableFooterView = UIView()

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
    func fetch_category_list()
    {
        let url = URL(string: "http://localhost/fotofeast/api/special-offers-api.php")
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
           // JustHUD.shared.showInView(view: view)
            imageArr.removeAll()
            if let arrayJson = adata["Feedback"] as? NSArray
            {
                print("arrayJson:\(arrayJson)")
                for index in 0...(adata["Feedback"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_cat_img_path = (object["offer_image"]as! String)
                    imageArr.append(arr_cat_img_path)
                }
            }
        }
        catch{
            print("error=\(error)")
        }
       // JustHUD.shared.hide()
    }
    

}
