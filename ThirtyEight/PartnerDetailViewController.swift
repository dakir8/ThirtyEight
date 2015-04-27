//
//  PartnerDetailViewController.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/19.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

import UIKit

class PartnerDetailViewController: UIViewController {

    @IBOutlet weak var imgThumbnail: UIImageView! {
        didSet {
            if let imageUrl = self.partner?.imageUrl {
                imgThumbnail.sd_setImageWithURL(NSURL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            } else {
                imgThumbnail.image = UIImage(named: "placeholder.png")
            }
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            if let name = self.partner?.name {
                lblTitle.text = name
            }
        }
    }
    
    @IBOutlet weak var tvDesc: UITextView! {
        didSet {
            if let desc = self.partner?.desc {
                tvDesc.text = desc
            }
        }
    }
    
    
    var partner: Partner?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
