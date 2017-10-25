//
//  ViewController.swift
//  firstPaidTask
//
//  Created by air on 25.10.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit
import ExternalAccessory

class ScanMFiDevicesViewController: UIViewController {
    
    //MARK: - Keys
    
    static let defaultCellIdentifier = "defaultCell"
    
    //MARK: - Properties
    
    //array of external accessories
    var accessories = [EAWiFiUnconfiguredAccessory]()
    //external accessories browser
    var eaBrowser:EAWiFiUnconfiguredAccessoryBrowser?
    
    //MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init EABrowser
        eaBrowser = EAWiFiUnconfiguredAccessoryBrowser(delegate: self, queue:nil)
    }
    
    //MARK: - IBActions

    @IBAction func scanMFiDevicesButtonClicked(_ sender: UIButton) {
        
        //start scaning
        activityIndicator.startAnimating()
        eaBrowser?.startSearchingForUnconfiguredAccessories(matching: nil)
    }
    
    //MARK: - Helpers
    
    func setAccessories(){
        
        if let _accessories = eaBrowser?.unconfiguredAccessories{
            accessories =  Array(_accessories)
        }
        
        
    }
    
}

extension ScanMFiDevicesViewController:EAWiFiUnconfiguredAccessoryBrowserDelegate{
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didUpdate state: EAWiFiUnconfiguredAccessoryBrowserState) {
        setAccessories()
        tableView.reloadData()
    }
    
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didFindUnconfiguredAccessories accessories: Set<EAWiFiUnconfiguredAccessory>) {
        activityIndicator.stopAnimating()
        
        setAccessories()
        tableView.reloadData()
    }
    
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didRemoveUnconfiguredAccessories accessories: Set<EAWiFiUnconfiguredAccessory>) {
        setAccessories()
        tableView.reloadData()
    }
    
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didFinishConfiguringAccessory accessory: EAWiFiUnconfiguredAccessory, with status: EAWiFiUnconfiguredAccessoryConfigurationStatus) {
        
        setAccessories()
        tableView.reloadData()
    }
}

extension ScanMFiDevicesViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if accessories.count==0{
            return 0
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScanMFiDevicesViewController.defaultCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = accessories[indexPath.row].manufacturer
        cell.detailTextLabel?.text = accessories[indexPath.row].model
        
        return cell
    }
}

