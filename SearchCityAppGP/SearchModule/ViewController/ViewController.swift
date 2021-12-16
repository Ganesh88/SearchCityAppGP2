//
//  ViewController.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 14/12/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar?
    
    var eventsListArray = [CityModel]()
    
    var searchViewModel: SearchViewModel? {
        didSet {
            viewModelBindings(searchViewModel: searchViewModel!)
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        setUpSearchBar()
       
        searchViewModel = SearchViewModel(searchEventsService: AppDelegate.getServiceFactory().getEventsSearchService())
        searchViewModel?.getEventsForSearchQuery()
    }
    
    func setUpSearchBar() {
        searchBar = UISearchBar()
        searchBar?.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar?.showsCancelButton = true
        searchBar?.searchTextField.textColor = .white
        searchBar?.tintColor = .white
        let image = UIColor.white.image()
        searchBar?.setImage(image, for: UISearchBar.Icon.search, state: .normal)

        if let textfield = searchBar?.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {

                // Background color
                backgroundview.backgroundColor = UIColor(red: 39, green: 70, blue: 86, alpha: 1)

                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func viewModelBindings(searchViewModel: SearchViewModel) {
        
        searchViewModel.eventsListArray.subscribe(onNext: { (eventsListArray) in
            self.eventsListArray = eventsListArray
            self.tableView.reloadData()
          }).disposed(by: disposeBag)

    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell
        cell?.configureCell(cityModel: eventsListArray[indexPath.row])
        return cell!
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
