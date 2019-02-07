//
//  CustomersListViewController.swift
//  InviteToParty
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import UIKit

class CustomersListViewController: UIViewController {

    private var customerVM = CustomersListViewModel()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customerVM.loadCustomersNearby({
            //UI elements must be changed in main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (errorMessage) in
            let alert = AlertHandler.alertError(message: errorMessage)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension CustomersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Validate if custom cell exists to prevent a posible crash
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell") as? CustomersCell else {
            return UITableViewCell()
        }
        cell.model = customerVM.customer(atIndex: indexPath.row)
        
        return cell
    }
    
    
}
