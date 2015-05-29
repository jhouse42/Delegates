//
//  VarietyViewController.swift
//  PlantFavs
//
//  Created by Jeanie House on 4/23/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class VarietyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    @IBOutlet var tableView: UITableView!
    
 
    var pClass: String!
    
    var varieties: [String] {
        return Data.sharedInstance.pClass[pClass]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 0.25, green: 0.73, blue: 0.15, alpha: 1.0)
        tableView.separatorColor = UIColor.whiteColor()
        
        title = pClass
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
          tableView.tableFooterView = UIView(frame:CGRectZero)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return varieties.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = varieties[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        cell.textLabel?.font = UIFont (name: "HelveticaNeue-Thin", size: 20)
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var varietyToRemove = varieties[indexPath.row]
        
        Data.sharedInstance.removeVariety(pClass: pClass, variety: varietyToRemove)
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var variety = varieties[indexPath.row]
        
        var url = Data.urlForVariety(variety)
        
        var webViewController = storyboard?.instantiateViewControllerWithIdentifier("WebViewController")as! WebViewController;()
        
        webViewController.url = url
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @IBAction func didTapAdd() {
        var alert = UIAlertView(title: "New Plant", message: "Type in a new favorite plant", delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Add")
        
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 1 {
         
            var textField = alertView.textFieldAtIndex(0)!
            
            var newVariety = textField.text.capitalizedString
    
            Data.sharedInstance.addVariety(pClass: pClass, variety: newVariety)
         
            var newIndexPath = NSIndexPath(forRow: varieties.count - 1, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
