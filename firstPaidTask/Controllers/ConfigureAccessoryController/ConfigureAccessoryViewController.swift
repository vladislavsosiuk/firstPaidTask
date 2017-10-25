//
//  ConfigureAccessoryViewController.swift
//  firstPaidTask
//
//  Created by air on 25.10.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit
import ExternalAccessory

class ConfigureAccessoryViewController: UIViewController {
    
    //MARK: - Properties
    
    var EABrowser:EAWiFiUnconfiguredAccessoryBrowser?
    
    //MARK: - Outlets

    @IBOutlet weak var ssidTextField: UITextField!
    
    @IBOutlet weak var macTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init eaBrowser
        EABrowser = EAWiFiUnconfiguredAccessoryBrowser(delegate: self, queue: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func configureClicked(_ sender: UIButton) {
        
        //check values for valid
        if let ssid = ssidTextField.text, !ssid.isEmpty, let mac = macTextField.text, !ssid.isEmpty{
            let accessory = EAWiFiUnconfiguredAccessory()
            
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Input SSID and MAC", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
extension ConfigureAccessoryViewController:EAWiFiUnconfiguredAccessoryBrowserDelegate{
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didUpdate state: EAWiFiUnconfiguredAccessoryBrowserState) {
        
    }
    
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didFindUnconfiguredAccessories accessories: Set<EAWiFiUnconfiguredAccessory>) {
        
    }
    
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didRemoveUnconfiguredAccessories accessories: Set<EAWiFiUnconfiguredAccessory>) {
        
    }
    
    func accessoryBrowser(_ browser: EAWiFiUnconfiguredAccessoryBrowser, didFinishConfiguringAccessory accessory: EAWiFiUnconfiguredAccessory, with status: EAWiFiUnconfiguredAccessoryConfigurationStatus) {
        
        
    }
    
    
}
