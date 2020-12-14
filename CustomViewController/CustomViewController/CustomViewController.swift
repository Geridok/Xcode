//
//  ViewController.swift
//  CustomViewController
//
//  Created by Vladimir Mustafin on 14.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
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
        let button = UIButton()
        button.addTarget(self, action: #selector(showHideContentVC(_:)), for: .touchUpInside)
        button.setTitle( buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
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
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        placeholderVC = vc
        showChildVC(placeholderVC!)
     }
     
    @objc private func showHideContentVC(_ sender: UIButton) {
        if let index = buttonsStackView.arrangedSubviews.firstIndex(of: sender){
            sender.isSelected.toggle()
            if sender.isSelected {
                if let holdView = placeholderVC {
                    hideChildVC(holdView);
                }
                showChildVC(childs[index])
            }else{
                hideChildVC(childs[index])
            }
        }
        if childVCStackView.arrangedSubviews.firstIndex(where: {$0.isHidden == false} ) == nil {
            if let holdView = placeholderVC {
               showChildVC(holdView)
           }
        }
     }

     private func showChildVC(_ childVC: UIViewController) {
        self.addChild(childVC)
        let index = getCorrectPlace(childVC)
        childVC.didMove(toParent: self)
        childVC.view.isHidden = false
        childVCStackView.insertArrangedSubview(childVC.view, at: index)
         // Функция для добавления контроллера в иерархию и его показа
     }
     
     private func hideChildVC(_ childVC: UIViewController) {
        childVC.willMove(toParent: self)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
        childVC.view.isHidden = true
     }
    
    private func getCorrectPlace(_ view: UIViewController) -> Array<UIViewController>.Index {
        let indexViewInOrder = childs.firstIndex(of: view) ?? 0
        if let indexVisibleView = childVCStackView.arrangedSubviews.lastIndex(where: {$0.isHidden == false}){
            if indexVisibleView + 1 < indexViewInOrder {
                return indexVisibleView + 1
            }else{
                return indexViewInOrder
            }
        }else{
            return 0
        }
    }
}

