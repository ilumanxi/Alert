//
//  ViewController.swift
//  alert
//
//  Created by 谭帆帆 on 16/5/18.
//  Copyright © 2016年 tanfanfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    enum SegueIdentifier: String {
        case Blog = "Blog"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        let alertController = UIAlertController(title: "设置Blog", message: "请输入您的Blog的URL地址", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { [unowned self] (textField) in
            
            //为什么不可以
            textField.addTarget(self, action: #selector(ViewController.textChangeHandle(_:)), forControlEvents: .ValueChanged)
        }
        
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: {  (alertAction) in
            
        }))
        
        let doneAction = UIAlertAction(title: "设置", style: .Default, handler: { [unowned self,unowned alertController] (alertAction) in
            self.performSegueWithIdentifier(SegueIdentifier.Blog.rawValue, sender: alertController.textFields?.first?.text)
        })
        doneAction.enabled = false
        alertController.addAction(doneAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:  #selector(ViewController.textChange(_:)), name: UITextFieldTextDidChangeNotification, object: alertController.textFields?.first)
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    @objc private func textChange(notification: NSNotification) {
        
        alertActionEnabledHandle()
    }

    @objc private func textChangeHandle(textFiled: UITextField) {
        
        alertActionEnabledHandle()
    }
    
    private func alertActionEnabledHandle() {
        if let alertController = self.presentedViewController as? UIAlertController {
            let actions =   alertController.actions
            actions[actions.endIndex.predecessor()].enabled =  (alertController.textFields?.first?.hasText())!
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch SegueIdentifier(rawValue: identifier)! {
        case .Blog:
            
            segue.destinationViewController.view.backgroundColor = UIColor.orangeColor()//这段代码很有意思 注释掉运行看看
            if let blogViewController = segue.destinationViewController as? BlogViewController ,text = sender as? String{
               
                blogViewController.titleLabel.text = text
            }
            
        }
     
    }
}

