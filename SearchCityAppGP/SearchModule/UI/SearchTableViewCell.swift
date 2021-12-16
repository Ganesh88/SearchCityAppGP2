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
        cityImageView.layer.cornerRadius = 15.0
        cityImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cityModel: CityModel) {
        cityTitleLabel.text = cityModel.title
        cityLocationLabel.text = cityModel.venue.displayLocation
        if let url = URL(string: cityModel.performers[0].imageUrl) {
            cityImageView.setImageWith(url)
        }
    }

}
