//
//  ViewController.swift
//  CustomViewController
//
//  Created by Vladimir Mustafin on 14.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    var isHidden = [Bool](repeating: true, count: 6)
    
     private var buttonsStackView: UIStackView?
     private var childVCStackView: UIStackView?
     
    private var childs: [UIViewController] = []
    private var childsButtons: [UIButton] = []
     private var placeholderVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        buttonsStackView = UIStackView()
        buttonsStackView?.axis  = NSLayoutConstraint.Axis.horizontal
        buttonsStackView?.distribution  = UIStackView.Distribution.fillEqually
        buttonsStackView?.alignment = UIStackView.Alignment.fill
        buttonsStackView?.spacing   = 10.0
        buttonsStackView?.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width , height: 75.0)
        buttonsStackView?.bounds = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width , height: 75.0)
        buttonsStackView?.backgroundColor = .green
        buttonsStackView?.translatesAutoresizingMaskIntoConstraints = false
        
        
        childVCStackView = UIStackView()
        childVCStackView?.axis  = NSLayoutConstraint.Axis.vertical
        childVCStackView?.distribution  = UIStackView.Distribution.fillEqually
        childVCStackView?.alignment = UIStackView.Alignment.fill
        childVCStackView?.spacing   = 0.0
        childVCStackView?.frame = CGRect(x: 0.0, y: 75.0, width: self.view.bounds.width , height: self.view.bounds.height - 75.0)
        childVCStackView?.bounds = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width , height: self.view.bounds.height - 75.0)
        childVCStackView?.backgroundColor = .green
        childVCStackView?.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(buttonsStackView!)
        self.view.addSubview(childVCStackView!)
        buttonsStackView?.isHidden = false
        childVCStackView?.isHidden = false
        
        
    }
     
     func addVC(_ vc: UIViewController, buttonTitle: String) {
         assert(childs.count < 6, "Too many child ViewControllers: only 6 allowed")
        childs.append(vc)
        vc.view.isHidden = true
        
        var button = UIButton()
        button.titleLabel?.text = buttonTitle
        childsButtons.append(button)
        button.titleLabel?.textAlignment = .center
        buttonsStackView?.addSubview(button)
        button.isHidden = false
        
         // Сохраняем контроллер (но не показываем), создаем кнопку, показываем кнопку.
     }
     
     func setPlaceholder(_ vc: UIViewController) {
        placeholderVC = vc
        self.view.addSubview(vc.view)
        placeholderVC?.view.isHidden = true
     }
     
    @objc private func showHideContentVC(_ sender: UIButton) {
        if let index = childsButtons.firstIndex(of: sender){
            if(isHidden[index]){
                showChildVC(childs[index])
            }else{
                hideChildVC(childs[index])
            }
        }
        if let index = isHidden.firstIndex(of: false){
            
        }else{
            placeholderVC?.view.isHidden = false
        }
         // Если все контент контроллеры скрыты, то показываем placeholder
     }

     private func showChildVC(_ childVC: UIViewController) {
        placeholderVC?.view.isHidden = true
        self.addChild(childVC)
        childVC.didMove(toParent: self)
        childVC.view.isHidden = false
        childVCStackView?.addSubview(childVC.view)
        if let index = childs.firstIndex(of: childVC){
            isHidden[index] = false
        }
         // Функция для добавления контроллера в иерархию и его показа
     }
     
     private func hideChildVC(_ childVC: UIViewController) {
        childVC.willMove(toParent: self)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
        childVC.view.isHidden = true
        if let index = childs.firstIndex(of: childVC){
            isHidden[index] = true
        }
     }
    
}

