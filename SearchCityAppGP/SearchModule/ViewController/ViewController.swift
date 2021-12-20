//
//  ViewController.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 14/12/21.
//

import UIKit
import RxSwift
import RxCocoa

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
    }
    
    func setUpSearchBar() {
        tableView.keyboardDismissMode = .onDrag
        searchBar = UISearchBar()
        searchBar?.delegate = self
        searchBar?.text = "Texas + Rangers"
        searchBar?.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar?.showsCancelButton = true
        searchBar?.searchTextField.textColor = .white
        searchBar?.tintColor = .white
//        let image = UIColor.white.image()
//        searchBar?.setImage(image, for: UISearchBar.Icon.search, state: .normal)

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
       
        searchBar?.rx.text.orEmpty
                    .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                    .distinctUntilChanged()
                    .filter { !$0.isEmpty }
                    .subscribe(onNext: { [unowned self] query in
                            self.searchViewModel?.getEventsForSearchQuery(searchString: query)
                    }).disposed(by: disposeBag)
        
        searchBar?.rx.cancelButtonClicked
            .subscribe(onNext: { () in
                self.searchBar?.endEditing(true)
            })
            .disposed(by: self.disposeBag)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        pushDetailsViewController(eventModel: eventsListArray[indexPath.row])
    }
    
    func pushDetailsViewController(eventModel: CityModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as? EventDetailsViewController {
            detailsViewController.eventModel = eventModel
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


