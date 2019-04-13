import UIKit

class ViewBookedEvent: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return JSONArray.arr_view_event_name.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")as! BookedEventCell
        cell.lblEventName.text = JSONArray.arr_view_event_name[indexPath.row]
        cell.lblEventCname.text = JSONArray.arr_view_event_Cname[indexPath.row]
        cell.lblEventEname.text = JSONArray.arr_view_event_Ename[indexPath.row]
        cell.lblEventDate.text = JSONArray.arr_view_event_date[indexPath.row]
        cell.lblEventTIme.text = JSONArray.arr_view_event_time[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tvEventView.deselectRow(at: indexPath, animated:  true)
    }

    var custId = String()
    @IBOutlet var tvEventView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvEventView.delegate = self
        tvEventView.dataSource = self
        
        tvEventView.tableFooterView = UIView()
        
        tvEventView.reloadData()
        
        callViewBookedEvent()
      
    }
    

   
    func callViewBookedEvent()
    {
        custId = UserDefaults.standard.value(forKey: "custId") as! String
        let url = URL(string: API_URL.VIEW_BOOKED_EVENT + custId)
        do{
            print("url=\(url)")
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            JSONArray.arr_view_event_id.removeAll()
            JSONArray.arr_view_event_name.removeAll()
            JSONArray.arr_view_event_Cname.removeAll()
            JSONArray.arr_view_event_Ename.removeAll()
            JSONArray.arr_view_event_date.removeAll()
            
            if let arrayJson = adata["ViewEvent"] as? NSArray
            {
                for index in 0...(adata["ViewEvent"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let arr_view_event_id = (object["event_id"]as! String)
                    JSONArray.arr_view_event_id.append(arr_view_event_id)
                    
                    let arr_view_event_name = (object["event_category_name"]as! String)
                    JSONArray.arr_view_event_name.append(arr_view_event_name)
                    
                    let arr_view_event_Cname = (object["customer_name"]as! String)
                    JSONArray.arr_view_event_Cname.append(arr_view_event_Cname)
                    
                    let arr_view_event_Ename = (object["employee_name"]as! String)
                    JSONArray.arr_view_event_Ename.append(arr_view_event_Ename)
                    
                    let arr_view_event_date = (object["booking_date"]as! String)
                    JSONArray.arr_view_event_date.append(arr_view_event_date)
                    
                    let arr_view_event_time = (object["booking_time"]as! String)
                    JSONArray.arr_view_event_time.append(arr_view_event_time)
                    
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }

}
