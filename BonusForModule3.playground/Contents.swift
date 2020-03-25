import UIKit


/* Exersice 2 */

let names = ["Vladimir", "Dmitriy", "Nikolay", "Petr"]
print(names.reduce("",{x,y in x+y+";"})) //тут все равно в конце ";" ((
print(names.joined(separator: ";"))
/* Exersice 3 */

let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
    x + y
})

/* Exersice 4 */

enum AutorizateType {
    case phone(Int)
    case email(String)
    case login(String)
}

/* Exersice 5
 Я глянул и все вами перечесленные контейнеры являются value type. Я думаю это связано с механикой inout, которая позвоялет более гибко управлять контейнерами. Но тогда я не понимаю почему вы согласились с моим утверждение про дерево и класс.
 Судя по всему копируется.
 */

indirect enum treeNode {
    case value(String,Any)
    case parent(treeNode?)
    case leftChild(treeNode?)
    case rightChild(treeNode?)
}
