//
//  IndividualEventTableViewCell.swift
//  Event_App
//
//  Created by Vik Denic on 12/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class IndividualEventTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photographerImageView: UIImageView!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var likesCountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
