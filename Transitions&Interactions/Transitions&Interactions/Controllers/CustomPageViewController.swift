//
//  CustomPageViewController.swift
//  Transitions&Interactions
//
//  Created by Vladimir Mustafin on 12.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    lazy var orderedViewController: [UIViewController] = { return [
        newVC(viewControllerID: "FirstTab"),
        newVC(viewControllerID: "SecondTab"),
        newVC(viewControllerID: "ThirdTab") ]
    }()
    
    override func viewDidLoad() {
        self.dataSource = self
        let firstViewController = orderedViewController.first
         setViewControllers([firstViewController!], direction: .forward, animated: true, completion: nil)
    }
    
    func newVC(viewControllerID: String) -> UIViewController {
        return UIStoryboard(name: "TabViewController",bundle: nil).instantiateViewController(identifier: viewControllerID)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewController.firstIndex(of: viewController) else {
            return nil
        }
        guard viewControllerIndex - 1 >= 0 else {
            return orderedViewController.last
        }
        return orderedViewController[viewControllerIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.firstIndex(of: viewController) else {
            return nil
        }
        guard viewControllerIndex + 1 < orderedViewController.count else {
            return orderedViewController.first
        }
        return orderedViewController[viewControllerIndex + 1]
    }
    

}
