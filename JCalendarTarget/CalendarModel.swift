//
//  CalendarModel.swift
//  JToday
//
//  Created by 开发者 on 16/6/24.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

class CalendarModel: NSObject {


    var monthDays: Int = 0

    var firstDay: Int = 0

    var monthData: [Monthdata]?
    

}
class Monthdata: NSObject {

    var worktime: Int = 0

    var lunarFestival: String?

    var lunarDayName: String?

    var GanZhiYear: String?

    var lunarDay: Int = 0

    var day: Int = 0

    var solarFestival: String?

    var year: Int = 0

    var term: String?

    var lunarMonthName: String?

    var zodiac: String?

    var month: Int = 0

    var weekFestival: String?

}

