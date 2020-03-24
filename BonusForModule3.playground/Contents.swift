import UIKit

/* Exersice 1 */

struct User {
    let hasLogin = false
    let hasPassword = false
}

func shouldShowLoginButton(for user: User) -> Bool {
    return user.hasPassword && user.hasLogin ? true : false
}

/* Exersice 2 */
let names = ["Vladimir", "Dmitriy", "Nikolay", "Petr"]
names.forEach{ print("\($0); ", terminator:"") }

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

/* Точно выбрал class, ибо это ссылочный тип и там реализован подсчет ссылок, очень удобно передавать ее всюду, а не копировать.*/
/* Не совсем понял что значит реализовать "код структуры". Во первых он получится не универсальный, т.к. я пока не знаю как пользоваться template, указателей тут тоже я пока не знаю что бы организовывать детей и т.д., а вот например set & dictionary по сути и представляют собой дерево, только оно еще реализвованно на hashtable, супер быстрая штука. А обертывать одну из этих структур я что-то не понял, из задания, зачем.  */
