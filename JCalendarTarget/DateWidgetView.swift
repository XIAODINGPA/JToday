//
//  DateWidgetView.swift
//  JDateWidget
//
//  Created by 开发者 on 16/6/21.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

class DateWidgetView: UIView {

    var dayLabel = UILabel?()
    var classLabel = UILabel?()
    var tipImageView = UIImageView?()


    override init(frame: CGRect) {

       super.init(frame: frame)

        let selfWidth = self.frame.size.width
        let selfHeight = self.frame.size.height

        dayLabel = UILabel.init(frame: CGRectMake(0, 8, selfWidth, selfHeight/2 - 8))
        dayLabel?.font = UIFont.systemFontOfSize(15)
        dayLabel?.textColor = UIColor.whiteColor()
        dayLabel?.textAlignment = NSTextAlignment.Center

        classLabel = UILabel.init(frame: CGRectMake(0, CGRectGetMaxY((dayLabel?.frame)!), selfWidth,selfHeight/2 - 10))
        classLabel?.font = UIFont.systemFontOfSize(13)
        classLabel?.textColor = UIColor.whiteColor()
        classLabel?.textAlignment = NSTextAlignment.Center

        tipImageView = UIImageView.init(frame: CGRectMake(CGRectGetWidth(frame) - 12, 0, 12, 12))

        self.addSubview(dayLabel!)
        self.addSubview(classLabel!)
        self.addSubview(tipImageView!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if classLabel?.text?.characters.count <= 0 {
            dayLabel?.center = self.center
        }


    }












}
