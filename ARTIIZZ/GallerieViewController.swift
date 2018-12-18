//
//  GallerieViewController.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/18/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import SwiftyJSON
//import AFNetworking

class GallerieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var products: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.estimatedRowHeight = 136
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 136 //UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight = 0
        self.tableView.sectionFooterHeight = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GallerieViewController.didPullToRefresh(_:)), for: .valueChanged)
        get_all_prod()
        tableView.insertSubview(refreshControl, at: 0)
        self.tableView.reloadData()
    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        get_all_prod()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellgallerie", for : indexPath)as! GallerieTableViewCell
        let prod = products[indexPath.row]
        
        let titlegallerie = prod["titlegallerie"] as! String
        cell.galleriename.text! = "\(titlegallerie)"
        
        let openhours = prod["openhours"] as! String
        cell.openhours.text! = "\(openhours)"
        
        let closehours = prod["closehours"] as! String
        cell.closehours.text! = "\(closehours)"
        
        let adrgallerie = prod["adrgallerie"] as! String
        cell.gallerieadr.text! = "\(adrgallerie)"
        
        let openingdoor = prod["openingdoor"] as! String
        cell.openinghours.text! = "\(openingdoor)"
        
        return cell
    }
    
    func get_all_prod(){
        let url = URL(string: "https://congregationdesfreresromains.org/artiizz/gallerie/gallerie.php")!
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

}
