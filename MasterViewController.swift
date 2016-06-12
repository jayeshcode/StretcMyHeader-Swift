//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Jayesh Wadhwani on 2016-06-07.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var dateLabel: UILabel!
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    let items = [NewsItem(category:.World, summary:"Climate change protests, divestments meet fossil fuels realities"),NewsItem(category:. Europe, summary:"Scotland's 'Yes' leader says independence vote is 'once in a lifetime"),NewsItem(category:.MiddleEast, summary:"Airstrikes boost Islamic State, FBI director warns more hostages possible"),NewsItem(category:.Africa, summary:"Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),NewsItem(category:.AsiaPacific, summary:"Despite UN ruling, Japan seeks backing for whale hunting"),NewsItem(category:. Americas, summary:"Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),NewsItem(category:.World, summary:"South Africa in $40 billion deal for Russian nuclear reactors"
),NewsItem(category:.Europe, summary:"'One million babies' created by EU student exchanges")]
    
    


    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
              
        self.navigationController?.navigationBarHidden = true
        
      setUpDateLabel()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    func setUpDateLabel() {
        let date: NSDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let dateInFormat: String = dateFormatter.stringFromDate(date)
        dateLabel.text = dateInFormat
    }

    override func viewWillAppear(animated: Bool) {
      //  self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count //objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomCell! = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)as! CustomCell
        cell.labelHeadlines!.numberOfLines = 0;
        cell.labelHeadlines!.numberOfLines = 0;
        cell.newsItem = items[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
}

