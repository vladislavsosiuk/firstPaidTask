//
//  ScanMCNearbyServiceViewController.swift
//  firstPaidTask
//
//  Created by air on 25.10.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class ScanMCNearbyServiceViewController:UIViewController{
    
    //MARK: - Keys
    
    static let defaultCellIdentifier = "defaultCell"
    
    let displayName = UIDevice.current.name
    
    let serviceType = "search-mcs"
    
    //MARK: - Properties
    
    //array of peers
    var peers = [MCPeerID]()
    //peers browser
    var mcBrower:MCNearbyServiceBrowser?
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var MCPeerTextField: UITextField!
    
    @IBOutlet weak var serviceTypeTextField: UITextField!
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        //inti textFields
        MCPeerTextField.text = displayName
        serviceTypeTextField.text = serviceType
    }
    
    //MARK: - IBActions
    
    @IBAction func scanMCNearbyServicesClicked(_ sender: UIButton) {
        
        if let peerID = MCPeerTextField.text, !peerID.isEmpty, let serviceType = serviceTypeTextField.text, !serviceType.isEmpty{
            
            
            //stop finding if finding
            if let mcBrowser = mcBrower{
                mcBrowser.stopBrowsingForPeers()
            }
            //init browser for peers
            mcBrower = MCNearbyServiceBrowser(peer: MCPeerID(displayName:peerID ), serviceType: serviceType)
            mcBrower?.delegate = self
            activityIndicator.startAnimating()
            peers = []
            mcBrower?.startBrowsingForPeers()
        }else{
            let alert = UIAlertController(title: "Error", message: "Input peer id and service type", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension ScanMCNearbyServiceViewController:MCNearbyServiceBrowserDelegate{
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        activityIndicator.stopAnimating()
        
        peers.append(peerID)
        tableView.reloadData()
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        if let index = peers.index(of: peerID){
            peers.remove(at: index)
        }
        tableView.reloadData()
    }
}
extension ScanMCNearbyServiceViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if peers.count==0{
            return 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScanMCNearbyServiceViewController.defaultCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = peers[indexPath.row].displayName
        cell.detailTextLabel?.text = peers[indexPath.row].description
        
        return cell
    }
}
