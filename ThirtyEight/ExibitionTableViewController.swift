//
//  ExibitionTableViewController.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/19.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit

class ExibitionTableViewController: UITableViewController {
    
    class Product {
        let name: String?
        let videoUrl: String?
        let imageUrl: String?
        
        init(name: String, videoUrl: String, imageUrl: String) {
            self.name = name
            self.videoUrl = videoUrl
            self.imageUrl = imageUrl
        }
    }
    
    let reusableIdentifier = "PartnerCell"
    
    var products = Array<Product>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "PartnerCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)
        
        products.append(Product(name: "东莞光明眼科医院宣传片", videoUrl: "http://v.qq.com/page/d/6/p/d0145wj3l6p.html", imageUrl: "guangming.jpg"));
        products.append(Product(name: "金爸爸网络科技有限公司 1", videoUrl: "http://v.qq.com/page/v/e/1/v0146yozbe1.html", imageUrl: "jinbaba1.jpg"));
        products.append(Product(name: "金爸爸网络科技有限公司 2", videoUrl: "http://v.qq.com/page/r/o/l/r01469jisol.html", imageUrl: "jinbaba2.jpg"));
        products.append(Product(name: "悦港汇商场宣传视频", videoUrl: "http://v.qq.com/page/x/g/m/x0146te63gm.html", imageUrl: "yuegang.jpg"));
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
        cell.thumbnail.image = UIImage(named: products[indexPath.row].imageUrl!)
        
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
