//
//  API_URL.swift
//  DemoAplication
//
//  Created by Akash Technolabs on 3/5/19.
//  Copyright © 2019 Akash Technolabs. All rights reserved.
//

import UIKit

class API_URL: UIViewController {
    static var MAIN_URL = "http://localhost/fotofeast/api/"
    static var image_url = "http://localhost/PhpProject1/images/"
    static var LOGIN_URL = MAIN_URL + "user-login.php"
    static var SIGN_UP_URL = MAIN_URL + "user-signup-api.php"
    
    static var CATEGORY_LIST = MAIN_URL + "category-listing.php"
    static var SUB_CATEGORY_URL =  MAIN_URL + "sub-category-listing.php?category_id="
    static var PRODUCT_LIST_URL = MAIN_URL + "product-item-listing.php?sub_category_id="
    // http://localhost/FotoFeast/product-item-listing.php?sub_category_id=2
    
    
    //static var SLIDER_URL = MAIN_URL + ""
    static var SLIDER_IMAGE_URL = "http://localhost/fotofeast/api/slider-listing.php"
    //http://localhost/FotoFeast/upload/slider-listing.php
    //http://localhost//FotoFeast//upload//slider2.jpg
    
    static var EVENT_LIST = MAIN_URL + "disp_event_list.php"
    static var EMPLOYEE_LIST = MAIN_URL + "display_employee_api.php"
    
    static var EVENT_BOOKING = MAIN_URL + "insert-event-booking.php"
    static var VIEW_BOOKED_EVENT = MAIN_URL + "display-event-booking-listing-api.php?cid="
    
    static var FETCH_TABLE_TITLE = MAIN_URL + "display-table-master.php"
    static var INSERT_TABLE_BOOKING = MAIN_URL + "insert_table_booking_api.php"
    static var FETCH_TABLE_BOOKING_DATA = MAIN_URL + "display-table-booking-listing-api.php?cid="
    
    static var PLACE_PRODUCT_ORDER = MAIN_URL + "place-item-order.php"
    static var FETCH_MYORDER_DETAILS = MAIN_URL + "disp_order.php?customer_id="
    
    static var INSER_USER_FEEDBACK = MAIN_URL + "feedback-api.php"
    
    static var DISPLAY_ORDER_DETAILS = MAIN_URL + "disp_order.php?order_id="
    
    static var offer_image = MAIN_URL + "special-offers-api.php"
    // static var DISPLAY_ORDER_DETAILS = MAIN_URL + "disp_order.php?order_id="
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
