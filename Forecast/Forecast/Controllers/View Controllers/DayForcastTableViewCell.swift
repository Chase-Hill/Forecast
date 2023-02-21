//
//  DayForcastTableViewCell.swift
//  Forecast
//
//  Created by Karl Pfister on 1/31/22.
//

import UIKit

class DayForcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var forcastedHighLabel: UILabel!
    
    func updateViews(day: Day) {
        dayNameLabel.text = day.validDate
        iconImageView.image = UIImage(named: day.iconString)
        forcastedHighLabel.text = String(day.highTemp)
    }
} // End of class
