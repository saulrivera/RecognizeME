//
//  CircleButton.swift
//  RecognizME
//
//  Created by Saul Rivera on 9/1/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import UIKit

@IBDesignable
public class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setValue()
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        setValue()
    }
    
    func setValue() {
        layer.cornerRadius = cornerRadius
    }

}
