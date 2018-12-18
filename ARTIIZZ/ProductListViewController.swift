//
//  ProductListViewController.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/17/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import AFNetworking


class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var products: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 200
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 200 //UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight = 0
        self.tableView.sectionFooterHeight = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ProductListViewController.didPullToRefresh(_:)), for: .valueChanged)
        get_all_prod()
        tableView.insertSubview(refreshControl, at: 0)
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        get_all_prod()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath)as! ProductTableViewCell
        let prod = products[indexPath.row]
        
        let artist = prod["artist"] as! String
        cell.artistproduct.text! = "\(artist)"
        
        let title = prod["titleprod"] as! String
        cell.titleproduct.text! = "\(title)"
        
        let createdprod = prod["createdprod"] as! String
        cell.dateproduct.text! = "\(createdprod)"
        
        let descriptionprod = prod["descriptionprod"] as! String
        cell.descproduct.text! = "\(descriptionprod)"
        
    
        //let urlString = "https://congregationdesfrere.ipage.com/artiizz/images/artwork/haitian_artwork.jpg"
        
         let images = prod["images"] as! [[String : AnyObject]]
        let urlString = images[0]["linkimg"] as! String
        //print(img)
        
        
        
        let url = NSURL(string: urlString)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            cell.imgproduct.image = UIImage(data: imageData as Data)
        }
        return cell
    }
    
    func get_all_prod(){
        let url = URL(string: "https://congregationdesfreresromains.org/artiizz/oeuvre/oeuvre.php")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                //print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.products = responseDictionary["data"] as! [[String: Any]]
                //print(self.products)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            }
        }
        task.resume()
        
    }
    
    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
