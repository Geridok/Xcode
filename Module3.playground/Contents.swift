import UIKit

/* Exersice 2 */
func foo_1()-> String{
    return "First func"
}
func foo_2(){
    print("Hi i call: \(foo_1())")
}

/* Exersice 3 */
func stringConcatenating(_ stringArr: [String]) -> String?{
    guard !stringArr.isEmpty else {
        return nil
    }
    
    var resultingString = ""
    
    for str in stringArr {
      resultingString += ","+str
    }
    return resultingString
}

/* Exersice 4 */

func swapAndMultiplication(_ firstItem:inout Int,_ secondItem:inout Int){
    let temporaryfirstItem = firstItem
    firstItem = secondItem * 2
    secondItem = temporaryfirstItem * 2
}

/* Exersice 5 */

func arraySum(_ array: [Int]) -> Int64{
    guard !array.isEmpty else {
        return 0
    }
    var result: Int64 = 0
    
    for el in array {
        result += Int64(el)
    }
    return result
}

func isLarger(_ firstArray: [Int],_ secondArray: [Int]) -> Bool{
    if(arraySum(firstArray) > arraySum(secondArray)) {
        return true
    }else{
        return false
    }
}

/* Exersice 6
    Надеюсь простите, ибо очередной раз писать сортировку не вижу смысла(всякие разные уже не раз писал) , тем более когда есть такие замечательные стандартные средства */

func descendingSort(_ array: inout [Int]){
    array.sort(by: >)
}

/* Exersice 7 */

func averageValue(_ array: [Int]) -> Int?{
    guard !array.isEmpty else {
        return nil
    }
    return Int(arraySum(array))/array.count
}

/* Exersice 8 */

func findIndex(_ stringArray: [String],_ subString: String) -> Int?{
    guard !stringArray.isEmpty else {
        return nil
    }
    return stringArray.firstIndex(of: subString)
}

/* Exercise 9
  Result: "Hello, young man/woman 0"*/

/* Exercise 10
    Result: 4 */

/* Bonus
    1) Да, конечно. Это все даже в онлайн лекциях было рассказано
    2) Например когда нам нужно создать пустой объект на старте программы, но мы точно уверены что он будет "заполнен" перед использованием */

