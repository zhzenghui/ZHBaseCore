//
//  SwiftyBeaver.swift
//  RubyChinaPods
//
//  Created by Mac on 2017/12/27.
//  Copyright © 2017年 yuenvshen. All rights reserved.
//

import Foundation

public func LogerDebug(_ items: Any) {
#if DEBUG
    debugPrint(items)
#endif
}

public func LogerError(_ items: Any) {
#if DEBUG
    debugPrint("\(items)")
#endif
    }
//print("\(file) : \(function) : \(line) : \(column) - \(message)")
public func LogerInfo(_ items: Any...) {
#if DEBUG
    var file = #file
    file = (file as NSString).lastPathComponent
    let log =  "\(stringValue(Date()) ?? "")\(file)-L\(#line): \(items)"
    debugPrint(log)
#endif
}

public func LogerRelese(_ items: Any) {
    print("\(items)")
}

func stringValue(_ date:Date) -> String? {
    let dateFormatter = DateFormatter()
    let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm:ss", options: 0, locale: Locale.current)
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.string(from: date)
}
