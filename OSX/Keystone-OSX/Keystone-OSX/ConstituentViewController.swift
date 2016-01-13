//
//  ConstituentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/6/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public class ConstituentArrayViewController: NSViewController {
    
    var constituentArray: [Constituent] = []
    
    private var viewControllers: [ConstituentViewController] {
        return constituentArray.map { $0.viewController }
    }
    
}

extension Constituent {
    
    var viewController: ConstituentViewController {
        guard let viewController = NSStoryboard(name: "ConstituentView", bundle: NSBundle(forClass: ConstituentViewController.self)).instantiateInitialController() as? ConstituentViewController else { fatalError() }
        
        
        
        
        return viewController
    }
    
}


public class ConstituentViewController: NSViewController {
    
    var constituent: Constituent! {
        didSet {
            
            if constituent.constituentItems.count < 1 {
                
            }
            
            for item in constituent.constituentItems {
                
            }
            
            
        }
    }
    
    func addConstitutentItem(item: NSAttributedString) {
        constituent.addConstituentItem(item)
    }
    
}

extension NSAttributedString {
    
    var viewController: ConstituentItemViewController {
        guard let viewController = NSStoryboard(name: "ConstituentView", bundle: NSBundle(forClass: ConstituentViewController.self)).instantiateControllerWithIdentifier("ConstituentItemView") as? ConstituentItemViewController else { fatalError() }
        
        
        return viewController
    }
}

class ConstituentItemViewController: NSViewController {
    
    
}
