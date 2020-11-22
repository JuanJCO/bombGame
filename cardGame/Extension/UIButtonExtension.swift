//
//  UIButtonExtension.swift
//  cardGame
//
//  Created by Juan Carro on 22/11/20.
//

import UIKit

extension UIButton {
    
    //Creo esta extensión para asignársela a ambos botones
    func round(){
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
}
