//
//  UITableView+Ext.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 17.11.2020.
//

import UIKit

extension UITableView {

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
