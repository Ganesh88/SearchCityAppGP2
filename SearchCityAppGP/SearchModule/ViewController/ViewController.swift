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
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        
        searchViewModel = SearchViewModel(searchEventsService: AppDelegate.getServiceFactory().getEventsSearchService())
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
        return cell!
    }
}

