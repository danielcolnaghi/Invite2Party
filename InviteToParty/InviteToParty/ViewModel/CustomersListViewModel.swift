//
//  CustomersListViewModel.swift
//  InviteToParty
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import Foundation

class CustomersListViewModel {
    //Private list, any implemantation related to the list should be implemented here(delete, update, insert)
    private var customers: [Customer]
    
    init() {
        customers = [Customer]()
    }
    
    func loadCustomersNearby(_ completionHandler:() -> Void, fail:(_ error: String) -> Void) {
        //Load all customers from file, filter nearby and sort by id
        CustomerDataAccess.shared.loadData({ (customersResponse) in
            //Sorted list
            var allCustomers = customersResponse.sorted(by: { $0.userId < $1.userId })
            
            for item in allCustomers {
                let distance = GeoHandler.officeDistance(lat: item.latitude, lon: item.longitude)
                //Filter by distance
                if distance <= 100 {
                    LogHandler.log("📝 Item added to list \(item) \(distance)")
                    customers.append(item)
                }
            }
            //Remove objects from temporary list
            allCustomers.removeAll()
            //Notify completion
            completionHandler()
            
        }) { (errorMessage) in
            //Notify error
            fail(errorMessage)
        }
    }
    
    var count: Int {
        return customers.count
    }
    
    func customer(atIndex index: Int) -> Customer {
        return customers[index]
    }
}
