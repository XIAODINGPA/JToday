//
//  AboutViewController.swift
//  JDateWidget
//
//  Created by 开发者 on 16/6/23.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

let email = "hi@jinxiansen.com"

class AboutViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于"
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()

        let versionString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as!String
        versionLabel.text = NSString.init(format: " Version \(versionString)") as String
    }


    @IBAction func emailButtonClick(sender: UIButton) {

        self .copyEmail()
    }

    func copyEmail ()  {
        let board = UIPasteboard.generalPasteboard()
        board.string = email

        let alert = UIAlertController.init(title: "已复制邮箱", message: nil, preferredStyle: UIAlertControllerStyle.Alert)

        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default) { (action) in

        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
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
