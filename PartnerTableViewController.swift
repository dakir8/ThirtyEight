//
//  PartnerTableViewController.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/19.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit

class PartnerTableViewController: UITableViewController {
    
    class Partner {
        let name: String?
        let imageUrl: String?
        let desc: String?
        
        init(name: String, imageUrl: String, desc: String = "") {
            self.name = name
            self.imageUrl = imageUrl
            self.desc = desc
        }
    }
    
    let reusableIdentifier = "PartnerCell"
    var partnerList = Array<Partner>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partnerList.append(Partner(name: "东莞电视台", imageUrl: "dgtv_icon.jpeg", desc: "东莞广播电视台成立于2005年3月28日，整合了东莞人民广播电台、东莞电视台、东莞阳光网三大媒体，是中共东莞市委宣传部领导下的正处级事业单位，是南方广播影视传媒集团的成员单位。现有员工500多人，设办公室、总编室、人力资源部、财务部、总工办、新闻中心、广播中心、文艺中心、阳光网站、技术中心、广告经营中心、网络经营部等16个机构。"))
        
        partnerList.append(Partner(name: "东莞城市学院", imageUrl: "city_u.jpeg", desc: "东莞理工学院城市学院是2004年6月经国家教育部批准成立的独立学院。2009年，由东莞理工学院和广东鸿发投资集团有限公司合作举办，并于2011年，按照“创办一流大学、办百年名校”的办学目标，择址东莞市寮步镇建设新校区。当年9月，5000名大一新生入驻。"))
        
        self.title = "合作伙伴"
        
        self.tableView.registerNib(UINib(nibName: "PartnerCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        cell.thumbnail?.image = UIImage(named: partnerList[indexPath.row].imageUrl!)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("partnerDetail", sender: self)
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
                vc.partnerName = partnerList[tableView.indexPathForSelectedRow()!.row].name
                vc.partnerImage = partnerList[tableView.indexPathForSelectedRow()!.row].imageUrl
                vc.partnerDesc = partnerList[tableView.indexPathForSelectedRow()!.row].desc
            }
        }
        
    }

    
}
