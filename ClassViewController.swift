//
//  ClassViewController.swift
//  PlantFavs
//
//  Created by Jeanie House on 4/23/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var pClass: [String] = Data.sharedInstance.pClassList
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 0.25, green: 0.73, blue: 0.15, alpha: 1.0)
        tableView.separatorColor = UIColor.whiteColor()
        
        title = "PlantFavs"
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
          tableView.tableFooterView = UIView(frame:CGRectZero)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pClass.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = pClass[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        cell.textLabel?.font = UIFont (name: "HelveticaNeue-Thin", size: 20)
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var varietyViewController = storyboard?.instantiateViewControllerWithIdentifier("VarietyViewController")as! VarietyViewController;()
        
        varietyViewController.pClass = pClass[indexPath.row]
        
        navigationController?.pushViewController(varietyViewController, animated: true)
    }
}
