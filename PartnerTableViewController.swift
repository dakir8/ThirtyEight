//
//  PartnerTableViewController.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/19.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class Partner {
    let partnerId: String?
    let name: String?
    let imageUrl: String?
    let thumbnailUrl: String?
    let desc: String?
    
    init(json: JSON) {
        self.partnerId = json["partner_id"].string
        self.name = json["partner_name"].string
        self.desc = json["partner_desc"].string
        self.imageUrl = json["image_url"].string
        self.thumbnailUrl = json["thumbnail_url"].string
    }
}

class PartnerTableViewController: UITableViewController {
    
    let reusableIdentifier = "PartnerCell"
    var partnerList = [Partner]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "合作伙伴"
        
        self.tableView.registerNib(UINib(nibName: "PartnerCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)

        refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        refresh(self)
    }
    
    func refresh(sender: AnyObject) {
        
        Alamofire.request(.GET, IConstant.baseUrl, parameters: ["c":"partner", "m":"getPartners"])
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.refreshControl?.endRefreshing()
                    var json = JSON(json!)
                    self.partnerList.removeAll(keepCapacity: false)
                    for partner in json["partners"].arrayValue {
                        self.partnerList.append(Partner(json: partner))
                    }
                    
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
        return partnerList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableIdentifier, forIndexPath: indexPath) as! PartnerCell

        // Configure the cell...
        
        cell.title?.text = partnerList[indexPath.row].name
        
        let partner = self.partnerList[indexPath.row]
        
        if let thumbnailUrl = partner.thumbnailUrl {
            cell.imageView?.sd_setImageWithURL(NSURL(string: thumbnailUrl), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            cell.imageView?.image = UIImage(named: "placeholder.png")
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("partnerDetail", sender: self)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "partnerDetail") {
            if let vc = segue.destinationViewController as? PartnerDetailViewController {
                vc.partner = self.partnerList[self.tableView.indexPathForSelectedRow()!.row]
            }
        }
        
    }

    
}
