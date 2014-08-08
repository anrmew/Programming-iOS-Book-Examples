

import UIKit

class FirstViewController : UIViewController {}
class SecondViewController : UIViewController {}

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {
    var window : UIWindow?
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
        (self.window!.rootViewController as UITabBarController).delegate = self
        
        return true
    }
    
    func tabBarController(tabBarController: UITabBarController!, animationControllerForTransitionFromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return self
    }
}

extension AppDelegate : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        
        let vc1 = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let vc2 = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let con = transitionContext.containerView()
        
        let r1start = transitionContext.initialFrameForViewController(vc1)
        let r2end = transitionContext.finalFrameForViewController(vc2)
        
        // new in iOS 8, use these instead of assuming that the views are the views of the vcs
        let v1 = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let v2 = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        // which way we are going depends on which vc is which
        // the most general way to express this is in terms of index number
        let tbc = self.window!.rootViewController as UITabBarController
        let ix1 = find(tbc.viewControllers as [UIViewController], vc1)
        let ix2 = find(tbc.viewControllers as [UIViewController], vc2)
        let dir = ix1 < ix2 ? 1 : -1
        var r = r1start
        r.origin.x -= r.size.width * CGFloat(dir)
        let r1end = r
        r = r2end
        r.origin.x += r.size.width * CGFloat(dir)
        let r2start = r
        v2.frame = r2start
        con.addSubview(v2)
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        UIView.animateWithDuration(0.4, animations: {
            v1.frame = r1end
            v2.frame = r2end
            }, completion: {
                _ in
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
            })
    }
}
