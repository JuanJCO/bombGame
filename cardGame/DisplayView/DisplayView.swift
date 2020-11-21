//
//  DisplayView.swift
//  cardGame
//
//  Created by Juan Carro on 20/11/20.
//

import Foundation
import UIKit

class UIDisplayView: UIView{
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var label: UILabel!
    
    let relativeFont: CGFloat = 0.15
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init (coder: coder)
        initView()
    }
    
    
    func initView(){
        
        let nib = UINib(nibName: "DisplayView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        self.view.frame = bounds
        //label.font = label.font.withSize(self.view.frame.height * relativeFont)
        addSubview(view)
        
    }
    
}
