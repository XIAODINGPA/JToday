//
//  ViewController.swift
//  JDateWidget
//
//  Created by 开发者 on 16/6/21.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

let itunesAddress = "https://itunes.apple.com/cn/app/id1127154449"

class ViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var tableViewLayoutHeight: NSLayoutConstraint!
    var dataArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "今儿"
        tableView.scrollEnabled = false
        dataArray = ["使用","评价","关于"];

    }
 

    // UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var  cell = tableView?.dequeueReusableCellWithIdentifier("cellID")
        if cell==nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "cellID")

        }
        cell?.textLabel?.text = dataArray[(indexPath?.row)!] as? String
        cell?.textLabel?.textColor = UIColor.lightGrayColor()
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        switch indexPath.row {
        case  0:
            let scrollVC = self.storyboard?.instantiateViewControllerWithIdentifier("ScrollViewController") as! ScrollViewController
            self.navigationController?.pushViewController(scrollVC, animated: true)
            break

        case  1:

            let url = NSURL.init(string: itunesAddress)
            UIApplication.sharedApplication().openURL(url!)
            
            break

        case  2:

            let aboutVC = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController")
            self.navigationController?.pushViewController(aboutVC!, animated: true)

            break

        default: break

        }


    }






    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

