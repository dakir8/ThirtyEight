//
//  PictureCollectionTableViewController.swift
//  ThirtyEight
//
//  Created by Daniel on 15/4/23.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import Alamofire
import MWPhotoBrowser

class PictureCollectionTableViewController: UITableViewController, MWPhotoBrowserDelegate {
    
    class PictureCollection {
        let collectionId: String?
        let name: String?
        var pictures = [Picture]()
        
        init(json: JSON) {
            collectionId = json["collection_id"].string
            name = json["collection_name"].string
            
            for picture in json["pictures"].arrayValue {
                self.pictures.append(Picture(json: picture))
            }
        }
    }
    
    class Picture: Printable {
        let pictureUrl: String?
        var description: String {
            return "pictureUrl:\(self.pictureUrl)"
        }
        
        init(json: JSON) {
            pictureUrl = json["picture_url"].string
        }
    }
    
    let reusableIdentifier = "LabelCell"
    
    var pictureCollections = [PictureCollection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: reusableIdentifier)
        
        refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        refresh(self)
    }
    
    func refresh(sender: AnyObject) {
        Alamofire.request(.GET, IConstant.baseUrl, parameters: ["c":"picture", "m":"getAllPictures"])
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
                    self.pictureCollections.removeAll(keepCapacity: false)
                    for pictureCollection in json["picture_collections"].arrayValue {
                        self.pictureCollections.append(PictureCollection(json: pictureCollection))
                    }
                    
                    self.tableView.reloadData()
                }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("show picture collection", sender: self)
        openPhotoBrowser()
    }
    
    func openPhotoBrowser() {
        // Create browser (must be done each time photo browser is
        // displayed. Photo browser objects cannot be re-used)
        var browser = MWPhotoBrowser(delegate: self)
        
        // Set options
        browser.displayActionButton = true // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = false // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = false // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = true // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = false // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = true // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = true // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        
        // Optionally set the current visible photo before displaying
        //browser.setCurrentPhotoIndex(1)
        
        self.navigationController?.pushViewController(browser, animated: true)

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictureCollections.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableIdentifier, forIndexPath: indexPath) as! LabelCell
        
        let pictureCollection = self.pictureCollections[indexPath.row]
        cell.nameLabel?.text = pictureCollection.name
        
        return cell
    }
    
    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(self.pictureCollections[self.tableView.indexPathForSelectedRow()!.row].pictures.count)
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        if Int(index) < self.pictureCollections[self.tableView.indexPathForSelectedRow()!.row].pictures.count {
            if let row = self.tableView.indexPathForSelectedRow()?.row {
                return MWPhoto(URL: NSURL(string: self.pictureCollections[row].pictures[Int(index)].pictureUrl!))!
            }
        }
        
        return nil
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, thumbPhotoAtIndex index: UInt) -> MWPhotoProtocol! {
        if Int(index) < self.pictureCollections[self.tableView.indexPathForSelectedRow()!.row].pictures.count {
            if let row = self.tableView.indexPathForSelectedRow()?.row {
                return MWPhoto(URL: NSURL(string: self.pictureCollections[row].pictures[Int(index)].pictureUrl!))!
            }
        }
        
        return nil    }
}
