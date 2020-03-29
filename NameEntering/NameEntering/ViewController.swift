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
    
    /* Тут наверное стоит пояснить что я делал...
        Я пытался убрать все пробелы в введенном тексте(Ибо имя не может иметь пробелы), сначала была идея через цикл for с параметром enumerate пройтись по всем элементам и сравнением == " " и получить индекс пробела и функцие remove убрать его, но как оказалось с Int функция remove не умеет работать, она работает с String.Index и как сказал мне сам компилятор, такой cast:         let index = ind as? String.Index, всегда провалится, не совсем понятно почему так. Я так понимаю Strind.index это типо смещение в памяти указателя, т.к. я посмотрел и там доступ за O(1), хотя вроде когда мы пытаемся доступиться в массиве, он нам позволяет это сделать с Int и тоже делает за O(1). Какая-то тут тонкость, помогите разобраться. У меня получилось вот такое решение, скажите как вам, может что-то лучше можно придумать. Тут сложность O(n),(впринцепи как и была бы у цикла for) но как мы знаем есть разные константы поред этим О, так вот мне кажется что здесь она побольше.*/
    private func deleteAllSpace(_ string:inout String) {
        while(true){
            guard let index = string.firstIndex(of: " ") else {
                break
            }
            string.remove(at: index)
        }
//        let ind:Int = 2
//        let index = ind as? String.Index
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
     
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func viewName(_ sender: Any) {
        if !(nameTextField.text!.isEmpty) {
            var str = nameTextField.text!
            deleteAllSpace(&str)
            nameConcatenation += str + " "
            nameLabel.text = nameConcatenation
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
