//: Playground - noun: a place where people can play

import UIKit

// MARK:
// Protocol
// - Abstract
// - Define blueprints of: properties, method, requirements for functionality
// - Can implemented on struct, class, enum
// - As type
// Why protocol ?
// - Reusable like lego you can PnP your code
// - Delegation to solve callBack hell
// Different wit java
// - Protocol no extension will be `implements
// - Protocol with extension will be `extends` and `implement`

/*
 So, keeping it simple,
 a protocol says a struct , class or enum that if you want to be THAT, do THIS, this and THis.
 Example: if you want to be a human, you have to EAT, SLEEP, and Take REST.
 */

// Cash dan Credit

enum Type {
    case cash
    case credit
}

protocol PaymentType {
    var type: Type { get set }
    var name: String { get set }
    
    func payWith()
}

enum Gender {
    case men
    case woman
    case unknown
}

protocol People {
    var name: String { get set }
    var gender: Gender { get set }
}

class Agung: People {
    var name: String = "Agung"
    var gender: Gender = .unknown
}

class Agung2: Agung {
    
}

extension PaymentType {
    func payWith() {
        print(name)
    }
}

class PaymentManager {
    var paymentType: PaymentType
    
    init(type: PaymentType) {
        self.paymentType = type
    }
}

class PayWithCash: PaymentType {
    var type: Type = .cash
    var name: String = "Cash"
}

class PayWithCredit: PaymentType {
    var type: Type = .credit
    var name: String = "Credit"
}

class PayWithGopay: PaymentType {
    var type: Type = .credit
    
    var name: String = "Gopay"
}

let paymentManager = PaymentManager(type: PayWithGopay())
paymentManager.paymentType.payWith()

protocol Orang {
    var nama: String { get }
    var umur: Int { get set }
    var jenisKelamin: JenisKelamin { get }
    var rambut: Rambut { get }
    
    init(nama: String, umur: Int, jenisKelamin: JenisKelamin, rambut: Rambut)
}

// MARK:
// Exetension
// A Swift extension allows you to add functionality to a type, a class, a struct, an enum, or a protocol
// Why extension on protocol
// - with extension on protocol you can share your method to other object that extend protocol
// Why extension on class or struct
// - it can also help you keep your code organized.


extension Orang {
    // We cant create properties without value in extension
    /*
     * var tipeMata: TipeMata { get set }
     */
    func greetings() {
        print("Halo nama saya \(nama), umur saya \(umur), saya seorang \(jenisKelamin.rawValue)")
        print(rambut.description)
    }
    
    func status() {
        // MARK:
        // switch with tuple without enumeration
        // not limited with enum
        // we can limit type with where
        let data: (JenisKelamin, Int) = (jenisKelamin, umur)
        switch data {
        case (.wanita, let umur) where umur > 60:
            print("\(nama) adalah seorang nenek")
        case (.pria, let umur) where umur > 60:
            print("\(nama) adalah seorang kakek")
        case (_, let umur) where umur < 17:
            print("\(nama) masih anak anak")
        default:
            print("\(nama) masih dalam usia kerja")
        }
    }
}

struct Orang1: Orang {
    let nama: String
    var umur: Int
    let jenisKelamin: JenisKelamin
    let rambut: Rambut
}

extension Orang1 {
    init(dictionary: [String:Any]) {
        self.nama = (dictionary["nama"] as? String) ?? "John Doe"
        self.umur = (dictionary["umur"] as? Int) ?? 0
        self.jenisKelamin = (dictionary["jenis_kelamin"] as? JenisKelamin) ?? .pria
        self.rambut = (dictionary["rambut"] as? Rambut) ?? .lurus(warna: .hitam)
    }
}

class Orang2: Orang {
    let nama: String
    var umur: Int
    let jenisKelamin: JenisKelamin
    let rambut: Rambut
    
    required init(nama: String, umur: Int, jenisKelamin: JenisKelamin, rambut: Rambut) {
        self.nama = nama
        self.umur = umur
        self.jenisKelamin = jenisKelamin
        self.rambut = rambut
    }
}

// MARK:
// Enum
// - An enumeration is a data type consisting of a set of named values, called members
// - An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
// - Why swift is type safe ?
// - Variation limit

enum JenisKelamin: String {
    case pria
    case wanita
}

enum WarnaRambut: String {
    case hitam
    case cokelat
    case pirang
}

enum Kriting: String {
    case gelombang
    case kribo
}

enum Rambut {
    case lurus(warna: WarnaRambut)
    case kriting(warna: WarnaRambut, type: Kriting)
    
    var description: String {
        switch self {
        case .lurus(let warna):
            return "Rambut saya lurus berawarna \(warna.rawValue)"
        case .kriting(let (warna, type)):
            return "Rambut saya kriting \(type.rawValue) berwarna \(warna.rawValue)"
        }
    }
}

let r: Rambut = Rambut.lurus(warna: .cokelat)
switch r {
case .lurus(let warna):
    print(warna)
case .kriting((_, _)):
    break
}

let rambutLurusHitam = Rambut.lurus(warna: .hitam)
print(rambutLurusHitam.description)

let anonim = Orang1(dictionary: [:])
anonim.greetings()
anonim.status()
print("")
let alfian = Orang1(nama: "Alfian", umur: 21, jenisKelamin: .pria, rambut: .kriting(warna: .hitam, type: .gelombang))
alfian.greetings()
alfian.status()

// MARK:
// Condition
// if ..else
// In old programming language switch just for one type, but in if condition we can used for more one type
// this for old programming but no on swift we can test with tuple
// switch
// - switch faster that if, because compiler already know all condition, compiler have knowledge
// - faster
// - clean and readable

struct CreateOrderRequest {
    // MARK:
    // Interactor
    // Get or fetch Model Response From API
    struct CreateOrderResponse {
        // MARK:
        // ViewModel ~> Responsibility to parse Interactor response to Model View
        struct CreateOrderViewModel {
            let orderNumber: Int
            let orderName: String
            let orderCount: Int
        }
        
        var result: CreateOrderViewModel?
        
        init(data: [String: Any]) {
            result = parse(data: data)
        }
        
        private func parse(data: [String: Any]) -> CreateOrderViewModel? {
            guard let orderNumber = data["order_number"] as? Int,
                let orderName = data["order_name"] as? String,
                let orderCount = data["order_count"] as? Int else { return nil }
            
            return CreateOrderViewModel(orderNumber: orderNumber, orderName: orderName, orderCount: orderCount)
        }
    }
    
    var response: CreateOrderResponse?
    
    init() {
        response = fetch()
    }
    
    private func fetch() -> CreateOrderResponse {
        let data: [String: Any] = [
            "order_number": 123456,
            "order_name": "Adidas",
            "order_count": 1
        ]
        return CreateOrderResponse(data: data)
    }
}

let orderRequest = CreateOrderRequest()
print(orderRequest.response?.result?.orderName)

// MARK:
// loop
for i in 1...10 {
    print("- Bintang")
}
print("-------------")
for i in 0..<10 {
    print(i)
}
print("-------------")
let arrayInteger: [Int] = [1,2,3,4,5]
let member = ["Agung", "Bintang", "Guntur", "Heru"]

for name in member {
    print(name)
}

for i in arrayInteger {
    print(i)
}
print("-------------")

var i = 0
while i < 3 {
    print(i)
    i += 1
}
print("-------------")
var j = 0
repeat {
    print(j)
    j += 1
} while j < 5

// MARK
// class(refrence) vs struct(value)
// copy class will modified base class
// copy struct not affected base struct

// static vs class method
// static and class metod vs regular method
// - without initialize class

class StaticAndClass {
    private(set) static var staticVar: String = "static_var"
    
    init(nama: String) {
        
    }
    
    class var classVar: String {
        return "class_var"
    }
    
    static func staticFunc() -> String {
        return "static_func"
    }
    
    class func classFunc() -> String {
        return "class_func"
    }
    
    func basicFunc() -> String {
        return "basic_func"
    }
}

StaticAndClass.staticVar
//StaticAndClass.staticVar = "modified"
StaticAndClass.staticVar
StaticAndClass.staticFunc()
StaticAndClass.classFunc()
StaticAndClass(nama: "Bintang").basicFunc()

class SubClass: StaticAndClass {
    // MARK:
    // Cannot override
//    static func staticFunc() -> String {
//        return "static_func"
//    }
    
    override class var classVar: String {
        return "sub_class_var"
    }
    
    override class func classFunc() -> String {
        return "sub_class_func"
    }
}

//SubClass.staticVar = "modified_static_var"
SubClass.staticFunc()
SubClass.classFunc()
SubClass.staticVar
SubClass.classVar

StaticAndClass.staticVar

// MARK:
// class and static method vs singleton
// Anti Pattern
// Why
// Because you dont want creating new resource
// Singleton just work on class, because when at struct we are copying new object and add new resource
class Singleton {
    
    var state: String = "Active"
    
    static let shared: Singleton = {
        return Singleton()
    }()
    
    private init() {}
}

Singleton.shared.state
Singleton.shared.state = "Inactive"
Singleton.shared.state

protocol ContactType {}

class Implement: ContactType {}

struct Input<T: ContactType> {
    let viewModel: T
    let data: Any
    
    init(_ viewModel: T, data: Any) {
        self.viewModel = viewModel
        self.data = data
    }
}

Input(Implement(), data: 0)

// SOLID
// - Single responsibility priciple | Class or object must have one responisibility, like: Payment App - PaymentManger
// - Open and Close priciple | class can extension but not modified
// - Liskov Substitution Principle extension of Open and Close priciple | Extending base class without changing ther behaviour
// - Interface Segregation Principle | Client not forced to implement that they dont need or use
// - Dependency Inversion Principle | Decoupling

//func reverse(_ text: String) -> String {
//    var new: String = ""
//    for char in text {
//        new = "\(char)" + new
//    }
//    return new
//}
//
//print(reverse("alfian"))

// "restful" = "fluster"

//let a = "restful"
//let b = "fluster"
//
//func anagram(_ first: String, second: String) -> Bool {
//    return first.sorted() == second.sorted()
//}
//
//print(anagram(a, second: b))

// Check with dictionary, and count duplicate object
//func dictSignature(_ s: String) -> Dictionary<String, Int> {
//    var chars = Dictionary<String, Int>();
//    for y in s {
//        let x = String(y)
//        if let v = chars[x] {
//            chars.updateValue(v + 1, forKey: x)
//            chars[x] = v + 1
//        } else {
//            chars[x] = 1
//        }
//    }
//    return chars
//}
//
//func isAnagram(_ s1: String, _ s2: String) -> Bool {
//    let (d1, d2) = (dictSignature(s1), dictSignature(s2))
//    return d1 == d2;
//}
//let y = isAnagram("testing", "one two three")
//let x = isAnagram("testing", "gnitset")

