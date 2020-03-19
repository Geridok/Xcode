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
    
    var m_xPos:UInt
    var m_yPos:UInt
    
    init(x:UInt,y:UInt) {
        m_xPos=x
        m_yPos=y
    }
}
class Circle {
    var m_pos: Position
    var m_radius:UInt
    init(x_pos:UInt,y_pos:UInt,radius:UInt) {
        m_pos=Position( x: x_pos, y: y_pos)
        m_radius=radius
    }
}
class Rectangle {
    var m_pos: Position
    var m_width:UInt
    var m_height:UInt
    init(x_pos:UInt,y_pos:UInt,width:UInt,height:UInt) {
        m_pos=Position( x: x_pos, y: y_pos)
        m_width=width
        m_height=height
    }
}

/* Exersice 5
        В первом случае, т.к. user1.name константная переменная
        В 3 и 4 случае, т.к. структуры константные
        В 5 так же, как и в 1
        В 7 тк user.name константная переменная */
