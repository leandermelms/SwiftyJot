//
//  ViewController.swift
//  SwiftJotExample
//
//  Created by Leander Melms on 20.04.16.
//  Copyright © 2016 Leander Melms. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos
import SnapKit
import SwiftyJot
//import FontAwesome



let kPencilImageName:String = String.fontAwesomeIconWithName(FontAwesome.Pencil)
let kTextImageName:String = String.fontAwesomeIconWithName(FontAwesome.PaperPlane)
let kClearImageName: String = String.fontAwesomeIconWithName(FontAwesome.Close)
let kSaveImageName:String = String.fontAwesomeIconWithName(FontAwesome.Save)

class ViewController: UIViewController, JotViewControllerDelegate{
    
    
    let jotViewController: JotViewController = JotViewController()
    
    let saveButton: UIButton = UIButton()
    let clearButton: UIButton = UIButton()
    let toggleDrawingButton: UIButton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.jotViewController.renderImageOnColor(UIColor.blueColor())
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.jotViewController.delegate = self
        self.jotViewController.state = .Drawing
        self.jotViewController.textColor = UIColor.blackColor()
        self.jotViewController.font = UIFont.boldSystemFontOfSize(64)
        self.jotViewController.fontSize = 64
        self.jotViewController.textEditingInsets = UIEdgeInsetsMake(12, 6, 0, 6)
        self.jotViewController.initialTextInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        //self.jotViewController.fitOriginalFontSizeToViewWidth
        self.jotViewController.textAlignment = .Left
        self.jotViewController.drawingColor = UIColor.cyanColor()
        
        self.addChildViewController(self.jotViewController)
        self.view.addSubview(self.jotViewController.view)
        self.jotViewController.didMoveToParentViewController(self)
        
        self.clearButton.titleLabel!.font = UIFont.fontAwesomeOfSize(24)
        self.clearButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.clearButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        self.clearButton.setTitle(kClearImageName, forState:.Normal)
        self.clearButton.addTarget(self,action: #selector(ViewController.clearButtonAction), forControlEvents:.TouchUpInside)
        
        
        self.view.addSubview(self.clearButton)
        self.clearButton.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(44)
            make.width.equalTo(44)
            make.left.equalTo(self.view).offset(4)
            make.top.equalTo(self.view).offset(4)
        }
        
        self.saveButton.titleLabel!.font = UIFont.fontAwesomeOfSize(24)
        self.saveButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.saveButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        self.saveButton.setTitle(kSaveImageName, forState:.Normal)
        self.saveButton.addTarget(self,action: #selector(ViewController.saveButtonAction), forControlEvents:.TouchUpInside)
        
        self.view.addSubview(self.saveButton)
        self.saveButton.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(44)
            make.width.equalTo(44)
            make.right.equalTo(self.view).offset(-4)
            make.top.equalTo(self.view).offset(4)
        }
        
        self.toggleDrawingButton.titleLabel!.font = UIFont.fontAwesomeOfSize(24)
        self.toggleDrawingButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.toggleDrawingButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        self.toggleDrawingButton.setTitle(kTextImageName, forState:.Normal)
        self.toggleDrawingButton.addTarget(self,action: #selector(ViewController.toggleDrawingButtonAction), forControlEvents:.TouchUpInside)
    
        self.view.addSubview(self.toggleDrawingButton)
        self.toggleDrawingButton.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(44)
            make.width.equalTo(44)
            make.right.equalTo(self.view).offset(-4)
            make.bottom.equalTo(self.view).offset(-4)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#pragma mark - Actions
    
    func clearButtonAction() {
        //self.jotViewController.clearAll()
    }
    
    func saveButtonAction () {
        print("save..")
        let drawnImage: UIImage = self.jotViewController.renderImageWithScale(2, onColor:self.view.backgroundColor!)
    
        self.jotViewController.clearAll()
    
        CustomPhotoAlbum.sharedInstance.saveImage(drawnImage, metadata:nil)
        
    }
    
    func toggleDrawingButtonAction (){
        if (self.jotViewController.state == .Drawing) {
            self.toggleDrawingButton.setTitle(kPencilImageName, forState:.Normal)
    
            if (self.jotViewController.textString.characters.count == 0) {
                self.jotViewController.state = .EditingText
            } else {
                self.jotViewController.state = .Text
            }
    
        } else if (self.jotViewController.state == .Text) {
            self.jotViewController.state = .Drawing
            self.jotViewController.drawingColor = UIColor.randomColor()
            self.toggleDrawingButton.setTitle(kTextImageName, forState: .Normal)
        }
    }

    
    //#pragma mark - JotViewControllerDelegate
    
    func jotViewController(jotViewController: JotViewController, isEditingText isEditing: Bool) {
        //self.clearButton.hidden = isEditing
        //self.saveButton.hidden = isEditing
        //self.toggleDrawingButton.hidden = isEditing
    }


}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        let r = CGFloat.random()
        let g = CGFloat.random()
        let b = CGFloat.random()
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

