//
//  EventDetailsViewController.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 20/12/21.
//

import UIKit
import SDWebImage

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: SDAnimatedImageView!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var displayLoction: UILabel!
    
    var eventModel: CityModel?
    var barColor: UIColor?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.textAlignment = .center
        label.text = eventModel?.title
        self.navigationItem.titleView = label
        displayLoction.text = eventModel?.venue.displayLocation
        guard let eventModel =  eventModel else { return }
        if let url = URL(string: eventModel.performers[0].imageUrl) {
            imageView.setImageWith(url)
        }
        dateLable.text = Utilities.formattedDateFromString(dateString: eventModel.datetimeUtc)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        barColor = navigationController?.navigationBar.barTintColor
        navigationController?.navigationBar.barTintColor = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = barColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
