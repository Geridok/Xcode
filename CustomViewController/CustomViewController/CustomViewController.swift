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
    
    private var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis  = NSLayoutConstraint.Axis.horizontal
        buttonsStackView.distribution  = UIStackView.Distribution.fillEqually
        buttonsStackView.alignment = UIStackView.Alignment.fill
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing   = 10.0
        buttonsStackView.backgroundColor = .green
        return buttonsStackView
    }()
    
    
    private let childVCStackView: UIStackView = {
        let childVCStackView = UIStackView()
        childVCStackView.axis  = NSLayoutConstraint.Axis.vertical
        childVCStackView.distribution  = UIStackView.Distribution.fillEqually
        childVCStackView.alignment = UIStackView.Alignment.fill
        childVCStackView.spacing   = 10.0
        childVCStackView.translatesAutoresizingMaskIntoConstraints = false
        childVCStackView.backgroundColor = .green
        return childVCStackView
    }()
     
    private var childs: [UIViewController] = []
    private var placeholderVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
    
        self .view.addSubview(buttonsStackView)
        self.view.addSubview(childVCStackView)
        
        
        buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: childVCStackView.topAnchor).isActive = true
        
        buttonsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

        childVCStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        childVCStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        childVCStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        
    }
     
     func addVC(_ vc: UIViewController, buttonTitle: String) {
         assert(childs.count < 6, "Too many child ViewControllers: only 6 allowed")
        childs.append(vc)
        vc.view.isHidden = true
        let button = UIButton()
        button.addTarget(self, action: #selector(showHideContentVC(_:)), for: .touchUpInside)
        button.setTitle( buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        buttonsStackView.addArrangedSubview(button)
        
         // Сохраняем контроллер (но не показываем), создаем кнопку, показываем кнопку.
     }
     
     func setPlaceholder(_ vc: UIViewController) {
        self.view.addSubview(vc.view)
        NSLayoutConstraint.activate([
            vc.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            vc.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
             vc.view.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor)
        ])
        placeholderVC = vc
        placeholderVC?.view.isHidden = true
     }
     
    @objc private func showHideContentVC(_ sender: UIButton) {
        //placeholderVC?.view.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor).isActive = true
        if let index = buttonsStackView.arrangedSubviews.firstIndex(of: sender){
            if(isHidden[index]){
                showChildVC(childs[index])
            }else{
                hideChildVC(childs[index])
            }
        }
        let op = isHidden.firstIndex(of: false)
        
        if op == nil{
            placeholderVC?.view.isHidden = false
        }
         // Если все контент контроллеры скрыты, то показываем placeholder
     }

     private func showChildVC(_ childVC: UIViewController) {
        placeholderVC?.view.isHidden = true
        self.addChild(childVC)
        childVC.didMove(toParent: self)
        childVC.view.isHidden = false
        childVCStackView.addSubview(childVC.view)
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

