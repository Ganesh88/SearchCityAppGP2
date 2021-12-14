//
//  SearchTableViewCell.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 14/12/21.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityLocationLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var cityImageView: SDAnimatedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
