import UIKit

/* Exersice 2
    Можно сделать класс который будет хранить вектор игральных карт*/
struct gameCard{
    /* Some information about car*/
}
class gameCardControl{
    var m_cardVec = [gameCard]()
}
/* Exersice 3
    «Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.» */
/* Exersice 4
    */
class Position{
    
    init(x:UInt,y:UInt) {
        m_xPos=x
        m_yPos=y
    }
    
    var m_xPos:UInt
    var m_yPos:UInt
}
class Circle {
    init(x_pos:UInt,y_pos:UInt,radius:UInt) {
        m_pos = Position( x: x_pos, y: y_pos)
        m_radius=radius
    }
    
    var m_pos: Position
    var m_radius:UInt
}
class Rectangle {
    init(x_pos:UInt,y_pos:UInt,width:UInt,height:UInt) {
        m_pos=Position( x: x_pos, y: y_pos)
        m_width=width
        m_height=height
    }
    
    var m_pos: Position
    var m_width:UInt
    var m_height:UInt
}

/* Exersice 5
        В первом случае, т.к. user1.name константная переменная
        В 3 и 4 случае, т.к. структуры константные
        В 5 так же, как и в 1
        В 7 тк user.name константная переменная */

/* Exersice 6 */
class Car {
    init(carName:String, engineModel:String, horsePower:UInt = 120, peopleCapacity:UInt = 5, carType:String = "Sedan") {
        m_carName = carName
        m_engineModel = engineModel
        m_horsePower = horsePower
        m_peopleCapacity = peopleCapacity
        m_carType = carType
    }
    var m_carName:String
    var m_engineModel:String
    var m_horsePower:UInt
    var m_peopleCapacity:UInt
    var m_carType:String
}
/* Exersice 7 */
class calculation{
    init(value_1:Double,value_2:Double){
        m_value_1 = value_1
        m_value_2 = value_2
    }
    
    func summ() -> Double {
        return m_value_1 + m_value_1
    }
    
    func substruction() -> Double {
        return m_value_1 - m_value_1
    }
    
    func division() -> Double {
        return m_value_1 / m_value_1
    }
    
    func multiply() -> Double {
        return m_value_1 * m_value_1
    }
    
    var m_value_1:Double
    var m_value_2:Double
}
/* Exercise 8
    К static переменным и методам класса можно обращаться безсоздания экземпляра класса */
/* Exercise 9
    Наследоваться могут только классы */
/* Exercise 10 */
enum directionY:Int {
    case west = -1
    case east = 1
}

enum directionX:Int {
    case north = -1
    case south = 1
}

class playerPosition {
    var m_positionX:Int
    var m_positionY:Int
    
    init(startPositionX:Int = 0, startPositionY:Int = 0) {
        m_positionX = startPositionX
        m_positionY = startPositionY
    }
    
    func movePosition(moveX:Int, moveY:Int, directionX:directionX, directionY:directionY) -> (positionX:Int, PositionY:Int) {
        m_positionX += moveX * directionX.rawValue
        
        m_positionY += moveY * directionY.rawValue
        
        return (m_positionX,m_positionY)
    }
}
var playerPos = playerPosition()

var new_pos = playerPos.movePosition(moveX: 20, moveY: 20, directionX: .north, directionY: .west)

print("New pos: \(new_pos.positionX);\(new_pos.PositionY)")

new_pos = playerPos.movePosition(moveX: 100, moveY: 100, directionX: .south, directionY: .east)

print("New pos: \(new_pos.positionX);\(new_pos.PositionY)")
