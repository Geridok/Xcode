import UIKit

/* Exersice 2 */

class GameObject { //тут он сам internal становится
    func who() {
        print("Just object")
    }
}

final class Sword: GameObject {
    override func who(){
        print("Sword")
    }
}
class Inventory{ //тут тоже
    private var elements: [GameObject] = []
    func addObject(object:GameObject) {
        elements.append(object)
    }
}
/*______________________________________________________________________________________________*/

 protocol DrawableOnMap {
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
class Car {
    var name: String = ""
    var picture: [Character] = []
}

class Equipment {
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
/* В общем-то для выполнения вашего задания связанно с модификаторами, наоборот нужно было все стереть, ведь они автоматом internal, очень удобно)
    На самом деле не понятно пока что такое модуль, чем он от source файла отличается и т.д. Видимо позже об этом расскажут. Может кстати тут и стоит file-private все сделать, пока для меня это не совсем прозрачно....*/

/* Bonus
    as for upcasting
    is for type checking
    as! for force downcasting
    as? for optional downcasting
    ну поехали
*/
class Animal{
    func whoIs(){
        print("Just animal!")
    }
}

class Bird:Animal{
    override func whoIs() {
        print("Bird!")
    }
}

var obj1 = Animal()

var obj2:Bird = Bird()


if obj2 is Animal {
    print("Bird is also animal")
}

let obj3:Animal = obj2 as Animal

let obj4:Bird = obj1 as! Bird // ну тут не получилось downcast)

let obj5:Bird? = obj1 as? Bird
/*______________________________________________________________________________________________________________________*/
var str:String = "Some string"
var NSstring:NSString? = str as? NSString
/* Ну и так далее*/
