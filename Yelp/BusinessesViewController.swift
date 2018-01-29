//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Jonathan Grider on 1/27/2018
//  Copyright (c) 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
  
  // Outlets
  @IBOutlet weak var tableView: UITableView!
  
  var businesses: [Business]!
  
  var searchBar: UISearchBar!
  var filterButton: UIBarButtonItem!
  var isMoreDataLoading = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // TODO: Set up filter button
    //self.filterButton = UIBarButtonItem()
    //self.filterButton.title = "Filter"
    //navigationItem.leftBarButtonItem = self.filterButton
    
    // Set up search bar
    createSearchBar()
    
    // Search for nothing at the start
    search(query: "")
    
    /* Example of Yelp search with more search options specified
     Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
     self.businesses = businesses
     
     for business in businesses {
     print(business.name!)
     print(business.address!)
     }
     }
     */
    
    updateColors()
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if businesses != nil {
      return businesses!.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
    
    cell.business = businesses[indexPath.row]
    
    return cell
    
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    searchBar.endEditing(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func updateColors() {
    
    self.navigationController?.navigationBar.barTintColor = UIColor(red:0.77, green:0.07, blue:0.00, alpha:1.0)
    self.navigationController?.navigationBar.tintColor = .white
    
  }
  
  func createSearchBar() {
    
    self.searchBar = UISearchBar()
    self.searchBar.sizeToFit()
    self.searchBar.placeholder = "Restaurants"
    self.searchBar.delegate = self
    navigationItem.titleView = searchBar
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if self.searchBar.text != nil {
      search(query: self.searchBar.text!)
    } else {
      search(query: "")
    }

  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.resignFirstResponder()
  }
  
  func search(query: String) {
    Business.searchWithTerm(term: query, completion: { (businesses: [Business]?, error: Error?) -> Void in
      
      self.businesses = businesses
      self.tableView.reloadData()
      self.tableView.rowHeight = UITableViewAutomaticDimension
      self.tableView.estimatedRowHeight = 120
      
    }
    )
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (!isMoreDataLoading) {
      // Calculate the position of one screen length before the bottom of the results
      let scrollViewContentHeight = tableView.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
      
      // When the user has scrolled past the threshold, start requesting
      if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
        
        isMoreDataLoading = true
        
        // Code to load more results

      }
    }
  }
  
  
}
