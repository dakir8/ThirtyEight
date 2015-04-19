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
            imgThumbnail.image = UIImage(named: partnerImage!)
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.text = partnerName
        }
    }
    
    @IBOutlet weak var tvDesc: UITextView! {
        didSet {
            tvDesc.text = partnerDesc
        }
    }
    
    
    var partnerName: String?
    
    var partnerImage: String?
    
    var partnerDesc: String?
    
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
