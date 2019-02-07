//
//  CustomerDataAccess.swift
//  InviteToParty
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import Foundation

class CustomerDataAccess {
    //Singletone Design Pattern
    static let shared = CustomerDataAccess()
    private var cachedList: [Customer]?
    
    private init() {
        
    }
    
    func loadData(_ success:(_ customers: [Customer]) -> Void, fail:(_ errorMessage: String) -> Void) {
        //Check if there is a cached list in memory
        if let cachedList = cachedList {
            LogHandler.log("cachedList loaded \(String(describing: cachedList))")
            success(cachedList)
        }
        //Load customers file from local resources
        guard let path = Bundle.main.path(forResource: "customers", ofType: "txt") else {
            LogHandler.error("File not found.")
            fail("Ops, something wen wrong with customers list")
            return
        }
        
        do {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
                let dataList = String(data:data, encoding:.utf8)?.components(separatedBy: .newlines) else {
                    LogHandler.error("Fail to load data file.")
                    fail("Ops, something wen wrong with customers list")
                    return
            }
            
            var customersList = [Customer]()
            let decoder = JSONDecoder()
            for item in dataList {
                //Converting to data to decode and check if it is not a break line
                if let data = item.data(using: .utf8), item.count > 0 {
                    let jsonData = try decoder.decode(Customer.self, from: data)
                    customersList.append(jsonData)
                } else {
                    LogHandler.warning("Warning item not added to list: \(item)")
                }
            }
            
            //If everything goes right, cache the current list
            cachedList = customersList
            LogHandler.log("cachedList created \(String(describing: cachedList))")
            success(customersList)
            
        } catch {
            //If something wen wrong if any TRY, catch the error
            LogHandler.error(error.localizedDescription)
            fail("Ops, something wen wrong with customers list")
        }
    }
}
