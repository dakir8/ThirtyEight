//
//  CollectionTypeTableViewController.swift
//  ThirtyEight
//
//  Created by Daniel on 15/4/22.
//  Copyright (c) 2015年 daniel. All rights reserved.
//



class CollectionTypeTableViewController: UITableViewController {

    let reusableIdentifier = "LabelCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row) {
        case 0:
            performSegueWithIdentifier("show video collection", sender: self)
        case 1:
            performSegueWithIdentifier("show picture collection", sender: self)
        default:
            break
        }

        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableIdentifier, forIndexPath: indexPath) as! LabelCell
        
        switch(indexPath.row) {
        case 0:
            cell.nameLabel?.text = "视频"
        case 1:
            cell.nameLabel?.text = "照片"
        default:
            break;
        }
        
        
        return cell

    }
}
