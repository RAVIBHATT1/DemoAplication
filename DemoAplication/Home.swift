//
//  Home.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/5/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class Home: UIViewController ,UIScrollViewDelegate ,UITableViewDelegate,UITableViewDataSource {
    @IBAction func morebtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let MORE1 = storyBoard.instantiateViewController(withIdentifier: "MoreVC")as! More
         self.present(MORE1,animated: true,completion: nil)
        
    }
    @IBAction func eventbookAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let MORE1 = storyBoard.instantiateViewController(withIdentifier: "EventBookingVC")
        self.present(MORE1,animated: true,completion: nil)
    }
    var selected_cat_id = String()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return JSONArray.arr_cat_title.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeTable.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let HOME = storyBoard.instantiateViewController(withIdentifier: "SubCategoryVC")as! SubCategory
        selected_cat_id = JSONArray.arr_cat_id[indexPath.row]
        HOME.selected_cat_id = selected_cat_id
        self.present(HOME,animated: true,completion: nil)
     print("clicked in row")
    }
    
    @IBAction func btnoffersaction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let MORE2 = storyBoard.instantiateViewController(withIdentifier: "OfferVC")
        self.present(MORE2,animated: true,completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MyCell")as! HomeCell
        cell.MyLabel.text = JSONArray.arr_cat_title[indexPath.row]
        
        if let imageURL = URL(string: JSONArray.arr_cat_img_path[indexPath.row])
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
        
       // JustHUD.shared.hide()
        return cell
    }
   
    
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var page: UIPageControl!
    
    var img = [String]()
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTable.reloadData()
        homeTable.delegate = self
        homeTable.dataSource = self
        homeTable.tableFooterView = UIView()
        
        fetch_category_list()
        fetch_slider_images()
        
        self.navigationController?.isNavigationBarHidden = true
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)


        // Do any additional setup after loading the view.
    }
    @objc func moveToNextPage (){
        let pageWidth:CGFloat = self.bannerScrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.bannerScrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.bannerScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.bannerScrollView.frame.height), animated: true)
        scrollViewDidEndDecelerating(bannerScrollView)
    }

    func fetch_slider_images()
    {
        let url = URL(string: API_URL.SLIDER_IMAGE_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            print("adata:\(adata)")
            
            JSONArray.arr_slider_id.removeAll()
            JSONArray.arr_slider_title.removeAll()
            JSONArray.arr_slider_img.removeAll()
            
            if let arrayJson = adata["slider"] as? NSArray
            {
                for index in 0...(adata["slider"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let sliderIdJson = (object["id"]as! String)
                   JSONArray.arr_slider_id.append(sliderIdJson)
                    
                    let sliderNameJson = (object["title"]as! String)
                    JSONArray.arr_slider_title.append(sliderNameJson)
                    
                    let sliderImgJson = (object["img_path"]as! String)
                    JSONArray.arr_slider_img.append(sliderImgJson)
                }
            }
        }
        catch{print(error)
        }
        self.slider_images()
    }
    
    func slider_images()
    {
        page.currentPage = JSONArray.arr_slider_img.count
        self.page.numberOfPages = JSONArray.arr_slider_img.count
        for index in 0..<JSONArray.arr_slider_img.count
        {
            frame.origin.x = bannerScrollView.frame.size.width * CGFloat(index)
            frame.size = bannerScrollView.frame.size
            imageView = UIImageView(frame: frame)
            
            let imgPath = JSONArray.arr_slider_img[index]
            if URL(string: JSONArray.arr_slider_img[index]) != nil
            {
                
                let sliderUrl = URL(string: imgPath)
                
                if let data = NSData(contentsOf: sliderUrl!)
                {
                    if data != nil{
                        imageView.image = UIImage(data: data as Data)
                    }
                    else{
                        print("Error in ImageView")
                    }
                }
            }
            self.bannerScrollView.addSubview(self.imageView)
        }
        self.bannerScrollView.contentSize = CGSize(width: (bannerScrollView.frame.size.width * CGFloat(JSONArray.arr_slider_img.count)), height: bannerScrollView.frame.size.height)
        self.bannerScrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.page.currentPage = Int(currentPage);
    }
    func fetch_category_list()
    {
        let url = URL(string: API_URL.CATEGORY_LIST)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
        //    JustHUD.shared.showInView(view: view)
            JSONArray.arr_cat_id.removeAll()
            JSONArray.arr_cat_title.removeAll()
            JSONArray.arr_cat_img_path.removeAll()
            
            if let arrayJson = adata["category"] as? NSArray
            {
                for index in 0...(adata["category"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let eventIdJson = (object["category_id"]as! String)
                    JSONArray.arr_cat_id.append(eventIdJson)
                    
                    let arr_cat_title = (object["category_name"]as! String)
                    JSONArray.arr_cat_title.append(arr_cat_title)
                    
                    let arr_cat_img_path = (object["category_image"]as! String)
                    JSONArray.arr_cat_img_path.append(arr_cat_img_path)
                }
            }
        }
        catch
        {
            
            print("error=\(error)")
        }
        // JustHUD.shared.hide()
    }
}
