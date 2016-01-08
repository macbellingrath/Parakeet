//
//  ViewController.swift
//  TappyTimer
//
//  Created by Mac Bellingrath on 1/6/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBAction func hiButtonPressed(sender: AnyObject) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let disposebag = DisposeBag()
        
        nameTextField.rx_text
            
            .map{ "Hello " + $0 }
            
            .throttle(0.5, scheduler: MainScheduler.instance)
            
            .subscribeNext {
                
                self.greetingLabel.text = $0
            }
            .addDisposableTo(disposebag)
        
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

