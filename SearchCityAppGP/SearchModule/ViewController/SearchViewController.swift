//
//  ViewController.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 14/12/21.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar?
    
    @IBOutlet weak var noResultsLabel: UILabel!
    var eventsListArray = [EventsModel]()
    
    var searchViewModel: SearchViewModel? {
        didSet {
            viewModelBindings(searchViewModel: searchViewModel!)
        }
    }
    
    var disposeBag = DisposeBag()
    
    var areEventsLoading = false
    var currentPageCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        setUpSearchBar()
        searchViewModel = SearchViewModel(searchEventsService: AppDelegate.getServiceFactory().getEventsSearchService())
    }
    
    func setUpSearchBar() {
        tableView.keyboardDismissMode = .onDrag
        searchBar = UISearchBar()
        searchBar?.delegate = self
        searchBar?.text = kSearchBarDefaultText
        searchBar?.placeholder = kSearchBarPlaceholderText
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
                backgroundview.backgroundColor = kSearchBarTextFieldBGColor

                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    // MARK: - View Model Bindings Methods

    func viewModelBindings(searchViewModel: SearchViewModel) {
        
        searchViewModel.eventsListArray.subscribe(onNext: { (eventsListArray) in
            if eventsListArray.isEmpty {
                /*Utilities.instance.showAlert(view: self,
                                         title: "",
                                         message: kNoResultFoundText)*/
                self.noResultsLabel.isHidden = false
                self.eventsListArray = eventsListArray
            } else {
                self.eventsListArray += eventsListArray
                self.noResultsLabel.isHidden = true
            }
            self.tableView.reloadData()
            self.areEventsLoading = false
            self.hideHUD()
          }).disposed(by: disposeBag)
       
        searchBar?.rx.text.orEmpty
                    .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                    .distinctUntilChanged()
                    .subscribe(onNext: { [unowned self] query in
                        if query.isEmpty {
                            self.clearTableView()
                        }
                        self.showHud()
                        self.areEventsLoading = true
                        self.searchViewModel?.getEventsForSearchQuery(searchString: query,
                                                                      pageCount: 1)
                    }).disposed(by: disposeBag)
        
        searchBar?.rx.cancelButtonClicked
            .subscribe(onNext: { () in
                self.searchBar?.endEditing(true)
            })
            .disposed(by: self.disposeBag)
    }
    
    func loadMoreEvents() {
        if !areEventsLoading && currentPageCount != kTotalEventsPageCount {
            areEventsLoading = true
            searchViewModel?.getEventsForSearchQuery(searchString: searchBar?.text ?? "",
                                                pageCount: currentPageCount)
            currentPageCount += 1
        }
    }
    
    

}

// MARK: - UITableView Methods

extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell
        cell?.configureCell(eventsModel: eventsListArray[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        pushDetailsViewController(eventModel: eventsListArray[indexPath.row])
    }
    
    func pushDetailsViewController(eventModel: EventsModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as? EventDetailsViewController {
            detailsViewController.eventModel = eventModel
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func clearTableView() {
        self.noResultsLabel.isHidden = false
        eventsListArray = [EventsModel]()
        tableView.reloadData()
    }
}

// MARK: - UIScrollView Methods

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation), with: nil, afterDelay: 0.3)
        if (scrollView.contentOffset.y + 100) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            // You have reeached bottom (well not really, but you have reached 100px less)
            // Increase Page Count
           loadMoreEvents()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


