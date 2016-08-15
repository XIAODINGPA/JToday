//
//  TodayViewController.swift
//  JDateTarget
//
//  Created by 开发者 on 16/6/21.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit
import NotificationCenter

let screenWidth  =  UIScreen.mainScreen().bounds.size.width
let screenHeight =  UIScreen.mainScreen().bounds.size.width

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var lastMonthButton: UIButton!

    @IBOutlet weak var nextMonthButton: UIButton!

    @IBOutlet weak var titleButton: UIButton!

    @IBOutlet weak var weekNameContainerView: UIView!

    @IBOutlet weak var detailContainerView: UIView!
    
    @IBOutlet weak var detailContainerLayoutWidth: NSLayoutConstraint!

    var tempDate = NSDate()

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

    var dataArray = NSMutableArray()
    var imageView = UIImageView()
    var today = NSDate()
    var dateTodayComponents = NSDateComponents()
    var currentMonthComponents = NSDateComponents()
    let holidayArray = NSArray()
    let workArray = NSArray()
    let dateFormatter = NSDateFormatter()

    let chineseArray = NSMutableArray()

    var currentCalendar = NSCalendar?()

    var localeCalendar = NSCalendar?()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.configDayViews(false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSizeMake(0, 365)

        imageView = UIImageView.init(image: UIImage.init(named:"选中当日"))

        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()

        self.reloadWidgetView()

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(TodayViewController.jumpToApp))
        detailContainerView.addGestureRecognizer(tap)

    }

    func jumpToApp()
    {
        self.extensionContext?.openURL(NSURL.init(string: "today://com.jinxiansen.today")!, completionHandler: { (result) in
            print("open url result :\(result)")
        })

    }

    func loadData() {
        if currentCalendar == nil {
            currentCalendar = NSCalendar.currentCalendar()
        }

        dateTodayComponents = currentCalendar!.components([.Year,.Month,.Day], fromDate: tempDate)

        currentMonthComponents = currentCalendar!.components([.Year,.Month,.Day], fromDate: NSDate())

        today = currentCalendar!.dateFromComponents(currentMonthComponents)!

        let title = NSString.init(string: "\(dateTodayComponents.year) 年 \(dateTodayComponents.month) 月") as String
        titleButton.setTitle(title, forState: UIControlState.Normal)

        currentCalendar!.firstWeekday = 2 // 2是周一
        dateTodayComponents.day = 1

        let firstDay = currentCalendar!.dateFromComponents(dateTodayComponents)

        let firstWeekDay = currentCalendar!.components([.Weekday], fromDate: firstDay!).weekday

        let firstDayPosition = (firstWeekDay + 8)%8

        var dayDiff = 1 - firstDayPosition + 1 // + isMondayFirst

        dateTodayComponents.day = dayDiff

        dataArray.removeAllObjects()

        chineseArray.removeAllObjects()

        for _ in 0...42
        {
             dateTodayComponents.day = dayDiff

            let date = currentCalendar!.dateFromComponents(dateTodayComponents)
            if (date != nil)
            {
                dataArray.addObject(date!)
                chineseArray.addObject(self.chineseDayWithDate(date!))
            }
           dayDiff += 1
        }

    }

    //上个月
    @IBAction func lastButtonClick(sender: UIButton) {

        tempDate = self.newDate(tempDate,month: -1)
        self.reloadWidgetView()
    }
    //下个月
    @IBAction func nextButtonClick(sender: UIButton) {

        tempDate = self.newDate(tempDate,month: +1)
        self.reloadWidgetView()
    }

    //当前月
    @IBAction func titleButtonClick(sender: UIButton) {

        tempDate = self.newDate(NSDate(),month:0)
        self.reloadWidgetView()

    }

    func reloadWidgetView() {
        self.loadData()
        self.configDayViews(true)
    }

    func newDate(date:NSDate,month:NSInteger) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = month;

        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: NSCalendarOptions.init(rawValue: 0))
        return newDate!
    }

    func chineseDayWithDate(date:NSDate) -> NSString {

      let chineseDays = NSArray.init(objects:
            "初一","初二","初三","初四","初五","初六","初七","初八","初九","初十",
            "十一","十二","十三","十四","十五","十六","十七","十八","十九","二十",
            "廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十")

        if (localeCalendar == nil) {
            localeCalendar =  NSCalendar.init(calendarIdentifier: NSCalendarIdentifierChinese)!
        }

        let unitFlags: NSCalendarUnit = [.Year, .Month, .Day, .Weekday]

        let localComponents = localeCalendar!.components(unitFlags, fromDate: date)

        let stringDate = chineseDays.objectAtIndex(localComponents.day - 1)

        return stringDate as! NSString
    }


    func configDayViews (showAnimated:Bool) {
        var changeFrame = false

        for var view in detailContainerView.subviews  {
            view.removeFromSuperview()
        }

        if showAnimated {
            UIView.animateWithDuration(0.15) {
                self.detailContainerView.alpha = 0
            }
        }

        for index in 0..<dataArray.count {
            let date = dataArray.objectAtIndex(index)
            let dateComponents = currentCalendar!.components([.Year,.Month,.Day,.Weekday], fromDate: date as! NSDate)

            if dateComponents.month != dateTodayComponents.month {
                continue
            }

            let dayView = DateWidgetView.init(frame: CGRectMake( (CGFloat)(index % 7) * detailContainerView.bounds.width / 7, (CGFloat)( index / 7)*50, detailContainerView.bounds.width / 7, 50))
            dayView.dayLabel?.text = NSString.init(string: "\(dateComponents.day)") as String
            if chineseArray.count == dataArray.count {
                dayView.classLabel?.text = chineseArray.objectAtIndex(index) as? String
            }

            let currentDateString = dateFormatter.stringFromDate(date as! NSDate)
            if holidayArray.containsObject(currentDateString) {
                dayView.tipImageView?.backgroundColor = UIColor.redColor()
            }else if workArray.containsObject(currentDateString)
            {
                dayView.tipImageView?.backgroundColor = UIColor.lightGrayColor()
            }else
            {
                dayView.tipImageView?.removeFromSuperview()
                dayView.tipImageView = nil
            }

            if dateComponents.weekday == 1 || dateComponents.weekday == 7 {
                dayView.classLabel?.textColor = UIColor.init(red: 0.9987, green: 0.9438, blue: 0.5976, alpha: 1.0)
                dayView.dayLabel?.textColor = dayView.classLabel?.textColor
            }

            if dateComponents.month == currentMonthComponents.month {

                if today.isEqualToDate(date as! NSDate) {
                    dayView.addSubview(imageView)
                    imageView.center = CGPointMake(dayView.bounds.size.width / 2,dayView.bounds.size.width / 2)  // CGRectGetWidth(dayView.bounds)/2
                }
            }
            detailContainerView.addSubview(dayView)

            if index/7 >= 5 {
                changeFrame = true
            }
        }

        if changeFrame {
 
           UIView.animateWithDuration(0.3) {
                self.preferredContentSize = CGSizeMake(0, 365)
                self.detailContainerView.bounds = CGRectMake(0, 0,screenWidth, 50 * 6)
            }
        }
        else{

            UIView.animateWithDuration(0.3) {
                self.preferredContentSize = CGSizeMake(0, 315)
                self.detailContainerView.bounds = CGRectMake(0, 0,screenWidth, 50 * 6)
            }

        }
        UIView.animateWithDuration(0.3) {
            self.detailContainerView.alpha = 1
        }

    }


    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.NewData)
    }

    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
}



















