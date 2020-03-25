import UIKit

/* Exersice 2 */

open class GameObject {
    /* определяем нужные нам методы и свойства*/
    func who() {
        print("Just object")
    }
}

/* Теперь наследуемся от gameObject и делаем любые игровые объекты, а в инвенторе храним gameObject*/
final class Sword: GameObject {
    override func who(){
        print("Sword")
    }
}
open class Inventory{
    private var elements: [GameObject] = []
    func addObject(object:GameObject) {
        elements.append(object)
    }
    func showInventory() {
        elements.forEach({$0.who()})
    }
}
var obj1 = Sword()
var inv = Inventory()
inv.addObject(object: obj1) //и вот тут я был приятно удивлен, ведь получилось. Об этом не рассказывалось в лекциях, однако я попробовал как на плюсах. Насколько я понимаю тут происхдит upcast автоматически, но я не понял, по идеи он должен быть optional, но моя функция принимает "обычные" объекты.
inv.showInventory()
/* И вот если сделать задание на основе наших знаний, нам рассказали только про полиморфизм на примере protocol, и просто как-то странно звучит протокол "инвентаризуемый". Или я что-то не так понял? */
/*______________________________________________________________________________________________*/

public protocol DrawableOnMap {
    func drawOnMap()
}

final class People:GameObject{}

extension People:DrawableOnMap {
    func drawOnMap() {
        print("Draw on map")
    }
}

final class Map {
    func drawAllObject(objects: DrawableOnMap... ) {
        for element in objects {
            element.drawOnMap()
        }
    }
}

/*______________________________________________________________________________________________*/
open class Car {
    var name: String = ""
    var picture: [Character] = []
}

open class Equipment {
    var name: String
    var price: UInt
    var color: (Character, Character, Character)
    var engineVolume: Unit
    init(name: String, price: UInt, color: (Character, Character, Character), engineVolume: Unit) {
        self.name = name
        self.price = price
        self.color = color
        self.engineVolume = engineVolume
    }
}

final class car1: Car {
    var equipment: Equipment? = nil
    
}
/* Ну и так далее
    Я так понял расширение (как правила хорошего тона) используются для добавления протоколов
    Так же расширение можно использовать что бы дополнять уже стандартные классы или когда нет нужды наследоваться но мы хоти дополнить функционал (например при использовании чужой библиотеки) */
/* Exersice 3
 let v1: A = D() тут все хорошо т.к. D наследуется от C, а C от А

 v1.a() вызовется метод который переопределен в C

 let v2: B = C() вообще C и B не имеют никакой связи, тут будет ошибка компиляции.

 v2.c() тут соответственно тоже

 let v3: C = D() класс D можно сделать upcast к C

 v3.d() однако С не реализует такого метода, а при upcast нам становятся недоступны методы derived (ну если они не override ( в с++ по крайне мере так) ))

 let v4: D = D() no comments
 
 v4.a() тут все отлично, прям как в v1.a()
 */
