//
//  UIView+Ext.swift
//  My Favorites Collection 2.0
//
//  Created by Nurken on 06.11.2024.
//

import UIKit

extension UIView{
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints                             = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive    = true
    }
}
