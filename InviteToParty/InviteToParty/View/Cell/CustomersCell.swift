//
//  CustomersCell.swift
//  InviteToParty
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import UIKit

class CustomersCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblId: UILabel!
    @IBOutlet var lblDistance: UILabel!
    
    //Update UI elements when new model is setted
    var model: Customer? {
        didSet {
            DispatchQueue.main.async {
                self.lblName.text = self.model?.name
                self.lblId.text = "\(self.model?.userId ?? 0)"
                self.lblDistance.text = self.formatDistance()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //Format distance using the current model
    func formatDistance() -> String {
        guard let model = model, let lat = Double(model.latitude), let lon = Double(model.longitude) else {
            return ""
        }
        
        let distance = GeoHandler.officeDistance(lat: lat, lon: lon)
        //Note: Use MeasurementFormatter to localise the distance
        return "~\(distance.rounded(.down)) km"
    }
}
