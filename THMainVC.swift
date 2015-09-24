//
//  THMainVC.swift
//  TableHotelSwift
//
//  Created by samuel maura on 9/22/15.
//  Copyright © 2015 samuel maura. All rights reserved.
//

import UIKit

class THMainVC: UIViewController {

    var showCommentsButton :UIBarButtonItem?
    
    var transition : THTransitCenter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let article = UILabel(frame: CGRectInset(self.view.frame, 25.0, 25.0))
        
        article.textAlignment = .Center
        article.lineBreakMode = .ByWordWrapping
        article.numberOfLines = 0
        
        article.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        article.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit" +
        "Curabitur lacinia lorem ex. Nunc ipsum ex, egestas fermentum elit" +
        "molestie pharetra diam. Pellentesque habitant morbi tristique senectus" +
        "netus et malesuada fames ac turpis egestas. Phasellus rhoncus magna sit" +
        "amet sapien ultricies, at semper quam mattis. Suspendisse non erat" +
        "Phasellus eget lacus vel erat volutpat fermentum at a diam. Mauris "
        
        self.view.addSubview(article)
        self.navigationController?.toolbarHidden = false;
        
        var items = [UIBarButtonItem]()
        
        showCommentsButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply,
            target: self, action: "showComments:")
       
        items.append(showCommentsButton!)
        
        self.setToolbarItems(items, animated: true)
        
    }
    
    
    
    
    func showComments(sender:AnyObject){
        let commentTVC = THCommentsTVC()
        let nav = UINavigationController(rootViewController:commentTVC);
        
         // Custom Transition object
        self.transition = THTransitCenter()
        
        nav.modalPresentationStyle = UIModalPresentationStyle.Custom
        nav.transitioningDelegate = self.transition
        
        
        
        self.presentViewController(nav, animated: true, completion: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
