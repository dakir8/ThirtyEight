//
//  CollectionTypeTableViewController.swift
//  ThirtyEight
//
//  Created by Daniel on 15/4/22.
//  Copyright (c) 2015年 daniel. All rights reserved.
//



class CollectionTypeTableViewController: UITableViewController {

    let reusableIdentifier = "PartnerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "PartnerCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row) {
        case 0:
            performSegueWithIdentifier("show collection", sender: self)
        case 1:
            fallthrough
        default:
            break
        }

        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableIdentifier, forIndexPath: indexPath) as! PartnerCell
        
        switch(indexPath.row) {
        case 0:
            cell.title?.text = "视频"
        case 1:
            cell.title?.text = "照片"
        default:
            break;
        }
        
        
        return cell

    }
}
