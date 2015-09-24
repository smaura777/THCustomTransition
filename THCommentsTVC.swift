//
//  THCommentsTVC.swift
//  TableHotelSwift
//
//  Created by samuel maura on 9/22/15.
//  Copyright © 2015 samuel maura. All rights reserved.
//

import UIKit

class THCommentsTVC: UITableViewController {

    var comments :NSMutableArray?
    var commentText :UITextField?
    var commentContainer :UIView?
    var originalSize:CGSize?
    var postButton :UIButton?
    
    
    
    func initData(){
        
        for  i in 1..<25 {
            self.comments?.addObject("Comment \(i) : this is a comment ")
        }
        
    }
    
    func dismissComments(sender:AnyObject){
         self.notificationCleanup()
        self.commentText?.resignFirstResponder()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
       
    }
    
    
    
    func notificationSetup(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardAction:", name: UIKeyboardWillShowNotification, object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardAction:", name: UIKeyboardWillHideNotification, object: nil)
    
    }
    
    func notificationCleanup(){
         NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func keyboardAction(note: NSNotification){
        let noteDict  = note.userInfo as NSDictionary?
        
       let keyboardSize =  noteDict?.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue.size
        
        var newsize :CGSize
        
        if note.name == UIKeyboardWillHideNotification {
            newsize = self.originalSize!
        }
        else {
            newsize = CGSizeMake(self.originalSize!.width, self.originalSize!.height - (keyboardSize!.height - 30) )
        }
        
        
        let finalFrame = CGRectMake(self.navigationController!.view.frame.origin.x, self.navigationController!.view.frame.origin.y, newsize.width, newsize.height)
        
        UIView.animateWithDuration(0.5) { () -> Void in
              self.navigationController?.view.frame = finalFrame
        }
        
        
    }
    
    
    func setup(){
        
        commentContainer = UIView();
        commentContainer?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        self.navigationController?.view.addSubview(commentContainer!)

        commentContainer?.backgroundColor = UIColor.whiteColor()
        
        commentText = UITextField()
        commentText?.layer.borderWidth = 0.8
        commentText?.layer.borderColor = UIColor.lightGrayColor().CGColor
        commentText?.layer.cornerRadius = 7.0
        commentContainer?.addSubview(commentText!)
        
        postButton = UIButton(type: UIButtonType.Custom)
        postButton?.backgroundColor = UIColor.grayColor()
        postButton?.setTitle("post", forState: UIControlState.Normal)
        postButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        postButton?.layer.cornerRadius = 12.0;
        
        commentContainer?.addSubview(postButton!)
        
        notificationSetup()
        
    }

    
    
    
    
    /**
    *
    *   ViewController standard  methods
    *
    *
    */
    

    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.originalSize = CGSizeMake(self.navigationController!.view.bounds.size.width, self.navigationController!.view.bounds.size.height)
        self.commentText?.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comments"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "basic")
        

        let  dismissCommentButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
            target: self,
            action: "dismissComments:")
        
        self.navigationItem.rightBarButtonItem = dismissCommentButton
        
        self.comments = NSMutableArray()
        
        self.initData()
        
        self.setup()
        
        
    }
    
    
    override func viewWillLayoutSubviews() {

    let  containerFrame = CGRectMake(self.tableView.bounds.origin.x, (self.navigationController?.view.bounds.size.height)! - 60, self.tableView.bounds.size.width, 60)

    commentContainer!.frame = containerFrame

    let commentTextFrame = CGRectMake((self.commentContainer?.bounds.origin.x)! + 10, (self.commentContainer?.bounds.origin.y)! + 15, (self.commentContainer?.bounds.size.width)! - 80 , 35)

    self.commentText?.frame = commentTextFrame

    let buttonFrame = CGRectMake((self.commentText?.bounds.size.width)! + 20, (self.commentContainer?.bounds.origin.y)! + 18, 50, 30)

    self.postButton?.frame = buttonFrame

    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.comments?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath)

        cell.textLabel?.text = self.comments?.objectAtIndex(indexPath.row) as? String

        return cell
    }
    
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.commentText?.resignFirstResponder()
    }
    
  
    
}
