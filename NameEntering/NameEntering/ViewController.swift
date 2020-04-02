//
//  ViewController.swift
//  NameEntering
//
//  Created by Владимир Мустафин on 28.03.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    private var nameConcatenation:String = ""

    private func deleteAllSpace(_ string:inout String) {
        
//        let space:Set<Character> = [" "]
//        string.removeAll(where: {space.contains($0)}) еще вариантик
        
        string.removeAll(where: {$0 == " "}) // более симпотичный
        
        //По поводу вот этих предикатов, аля: where: {$0 == " "}, я так понимаю это что-то на подобии lambda expression. Можете дать ссылрочку где о них можно почитать.
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
     
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func showNewName() {
        guard var str = nameTextField.text else{
            return
        }
        if !(str.isEmpty) {
            deleteAllSpace(&str) // стоит ли создавать отдельную функцию для этого (в которой по сути одна строчка)
            nameConcatenation += str + " "
            nameLabel.text = nameConcatenation
        }
    
    }
}

/*  А это что мне удалось найти в интернете по поводу доступа String[i], где i это Int, но в моей задаче это не помогло бы...*/
extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }

}

func test(){
    let str = "Some string"
    print(str.count)
    print(str[12]) // ну собственно нет проверки на выход за приеделы, в этом он не безопасен, тоже самое и с range
}
