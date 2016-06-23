//
//  ScrollViewController.swift
//  JDateWidget
//
//  Created by 开发者 on 16/6/22.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "使用说明"
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.configScrollViewSubViewData()
    }
 

    func configScrollViewSubViewData() {

        let imageViewHeight:CGFloat = 500
        let imageViewWidth:CGFloat = 280
        let padding:CGFloat = 30

        if let scroll = scrollView {
        for index in 1..<5
        {
            let imageView = UIImageView.init(image: UIImage.init(named:"\(index)"))
            imageView.frame = CGRectMake((self.view.frame.size.width - imageViewWidth) / 2 ,padding + (imageViewHeight + padding) * CGFloat(index - 1),imageViewWidth,imageViewHeight)

            scroll.addSubview(imageView)

         }
            scroll.contentSize = CGSizeMake(0, 4 * (imageViewHeight + padding)+50)
    }

    }
 


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
