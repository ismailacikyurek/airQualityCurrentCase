//
//  PreviosTableViewCell.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 21.08.2022.
//

import UIKit

class PreviosTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPollutant: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var borderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(content : AirQuality){
        borderView.backgroundColor = .black
        borderView.layer.borderWidth = 0.5
        borderView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        lblCategory.text = content.category
        lblDay.text = content.day
        lblHours.text = content.hour
        lblPollutant.text = content.pollutant
    }

}
