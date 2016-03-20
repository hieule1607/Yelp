//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    var selectedStates = [Int:Bool]()
//    var distance : Int = 0
    var deal = false
    var selectedSegment = 0
    var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            /*
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
            */
        })
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let filterViewController = navigationController.topViewController as! FiltersViewController
        filterViewController.delegate = self
        filterViewController.switchStates = self.selectedStates
        filterViewController.isDealOffered = self.deal
        filterViewController.selectedSegment = self.selectedSegment
        
    }
    func filterViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject], selectedStates: [Int:Bool]) {
        
        let categories = filters["categories"] as? [String]
        deal = filters["deal"] as! Bool
        
        selectedSegment = filters["sortBy"] as! Int
//        distance = filters["distance"] as! Int
        
        self.selectedStates = selectedStates
        
        Business.searchWithTerm("Restaurants", sort: YelpSortMode(rawValue: selectedSegment), categories: categories, deals: deal) { (businesses:[Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }

}
extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        return cell
    }
}
