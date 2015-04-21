//
//  ExibitionTableViewController.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/19.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit
import Alamofire

class ExibitionTableViewController: UITableViewController {
    
    class Product: Printable {
        let name: String?
        let videoUrl: String?
        let imageUrl: String?
        
        var description: String {
            return "name:\(self.name), videoUrl:\(self.videoUrl), imageUrl: \(self.imageUrl)"
        }
        
        init(name: String, videoUrl: String, imageUrl: String) {
            self.name = name
            self.videoUrl = videoUrl
            self.imageUrl = imageUrl
        }
        
        init(json: JSON) {
            self.name = json["video_name"].string
            self.videoUrl = json["video_url"].string
            self.imageUrl = json["thumbnail_url"].string
        }
        
        
    }
    
    let reusableIdentifier = "PartnerCell"
    
    var products = Array<Product>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "PartnerCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)
        
        let url = IConstant.baseUrl + "getVideoCollection.php"
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    NSLog("Success: \(url)")
                    var json = JSON(json!)
                    for video in json["video_collections"][0]["videos"].arrayValue {
                        self.products.append(Product(json: video))
                    }
                    
                    println(self.products)
                    
                    self.tableView.reloadData()
                }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return products.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableIdentifier, forIndexPath: indexPath) as! PartnerCell
        
        // Configure the cell...
        
        cell.title?.text = products[indexPath.row].name
        if let imageUrl = products[indexPath.row].imageUrl {
            cell.thumbnail.image = UIImage(named: imageUrl)
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showWeb", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "showWeb") {
            if let vc = segue.destinationViewController as? WebViewController {
                vc.videoUrl = products[tableView.indexPathForSelectedRow()!.row].videoUrl
            }
        }
    }
    

}
