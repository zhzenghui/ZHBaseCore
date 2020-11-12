//
//  PrefsTableViewCell.swift
//  PrefsMate
//
//  Created by 蔡越 on 28/09/2017.
//

import UIKit

class PrefsTableViewCell: UITableViewCell {
//    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
//    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
