//
//  THTransitCenter.swift
//  TableHotelSwift
//
//  Created by samuel maura on 9/22/15.
//  Copyright © 2015 samuel maura. All rights reserved.
//

import UIKit

class THTransitCenter: NSObject,UIViewControllerTransitioningDelegate,
UIViewControllerAnimatedTransitioning {

    var  presenting : Bool?
    
    var transparentView : UIView?
    
    
    
   /**
    *
    *   UIViewControllerTransitioningDelegate delegate methods
    *
    *
    */
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = false
        return self
    }
    
    
    
    
    
    
    
   /**
    *
    *   UIViewControllerAnimatedTransitioning delegate methods
    *
    *
    */

    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
       return  0.50
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let cv = transitionContext.containerView()
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        
        let startFrame = CGRectMake( (cv?.bounds.origin.x)! + 40 ,
            (cv?.frame.size.height)! , 0.1, 0.1)
        
        let endFrame = CGRectMake((cv?.bounds.origin.x)!,(cv?.bounds.origin.y)! + 20,
            (cv?.bounds.size.width)!,(cv?.bounds.size.height)! - 70)
        
        if self.presenting == true{
            self.transparentView = UIView(frame: (cv?.frame)!)
            
            self.transparentView?.backgroundColor = UIColor.blackColor()
            self.transparentView?.alpha = 0.6
            
            fromVC?.view.userInteractionEnabled = false
            cv?.addSubview(self.transparentView!)
            cv?.addSubview((toVC?.view)!)
            toVC?.view.frame = startFrame
            
        }
        
        
        
     
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.4 , options: UIViewAnimationOptions.LayoutSubviews, animations: { () -> Void in
            if self.presenting == true {
                toVC?.view.frame = endFrame
                
            }
            else {
                fromVC?.view.frame = startFrame
                 self.transparentView?.alpha = 0
                fromVC?.view.alpha = 0.1
                
                
            }
            
            }) { (success) -> Void in
                
                if self.presenting == false {
                    toVC?.view.userInteractionEnabled = true
                    fromVC?.view.removeFromSuperview()
                    self.transparentView?.removeFromSuperview()
                }
                
                transitionContext.completeTransition( transitionContext.transitionWasCancelled() == false)
        }
        
    
    }
    
    
    
    
    
    
    
    
}
