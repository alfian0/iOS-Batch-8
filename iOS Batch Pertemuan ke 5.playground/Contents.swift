//: Playground - noun: a place where people can play

import UIKit

/*
 - Buatlah object Hewan
 - Hewan memiliki properties `nama`, `hidup_di` (Darat, Air dan Keduanya / Amfibi)
 - Hewan Burung memilki properties ketinggian
    - Burung ada yang dapat terbang dan tidak, jika dapat terbang maka memiliki method/func aturKetinggian(ketingigan: Int)
    - Jika bukan burung kita tidak boleh memaksa object hewan untuk memiliki aturKetingian(ketingigan: Int)
 - Hewan Ikan memeliki properties kedalaman
    - Ikan memilki method aturKedalaman(kedalaman: Int)
 - Hewan darat memilki properties kecepatan
    - Hewan darat memiliki method aturKecepatan(kecepatan: Int)
 - Buat lah hewan Merpati, Penguin, Sapi, Ceetah, Paus dengan mengextension/implement dari object Hewan dan masukan kedalam array collection Hewan
 - Buat class KebunBinatang yang memiliki method untuk memparsing koleksi hewan dan cetak deskripsi hewan menjadi seperti
    ```
    Hewan Merpati dalah tipe hewan yang hidup di darat dan dapat terbang dengan ketingian 10
    Hewan Penguin dalah tipe hewan yang hidup di darat dan tidak dapat terbang
    Hewan Sapi dalah tipe hewan yang hidup di darat dan berlari dengan kecepatan 40 km/jam
    Hewan Ceetah dalah tipe hewan yang hidup di darat dan berlari dengan kecepatan 100 km/jam
    Hewan Paus dalah tipe hewan yang hidup di air dan dapat menyelam sampai kedalaman 20 m
    ```
 */

enum TipeHewan: String {
    case darat
    case air
    case amfibi
}

protocol Hewan {
    var nama: String { get set }
    var type: TipeHewan { get set }
    
    func description()
}

protocol Burung: Hewan {
    var ketinggian: Int { get set }
}

extension Burung {
    func description() {
        switch ketinggian {
        case 0:
            print("Hewan \(nama) dalah tipe hewan yang hidup di \(type) dan tidak dapat terbang")
        default:
            print("Hewan \(nama) dalah tipe hewan yang hidup di \(type) dan dapat terbang dengan ketingian \(ketinggian)")
        }
    }
}

protocol Terbang {
    mutating func aturKetingian(ketingigan: Int)
}

struct BurungTidakTerbang: Burung {
    var nama: String
    var type: TipeHewan = .darat
    var ketinggian: Int
    
    init(nama: String, ketinggian: Int) {
        self.nama = nama
        self.ketinggian = ketinggian
    }
}

struct BurungTerbang: Burung, Terbang {
    var nama: String
    var type: TipeHewan = .darat
    var ketinggian: Int
    
    init(nama: String, ketinggian: Int) {
        self.nama = nama
        self.ketinggian = ketinggian
    }
    
    mutating func aturKetingian(ketingigan: Int) {
        self.ketinggian = ketingigan
    }
}

let merpati = BurungTerbang(nama: "Merpati", ketinggian: 40)
let penguin = BurungTidakTerbang(nama: "Penguin", ketinggian: 0)

struct KebunbinatangManager {
    var collections: [Hewan] = []
    
//    init(collections: [Hewan]) {
//        self.collections = collections
//    }
    
    func manage() {
        for hewan in collections {
            hewan.description()
        }
    }
}

KebunbinatangManager(collections: [merpati, penguin]).manage()

class A {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func change(name: String) {
        self.name = name
    }
}

struct B {
    var name: String
    
    mutating func change(name: String) {
        self.name = name
    }
}

var classA = A(name: "A")
var classB = B(name: "B")

var copyClassA = classA
var copyClassB = classB

copyClassA.change(name: "B")
copyClassB.change(name: "A")

classA.name
classB.name





























/*
enum TipeHewan: String {
    case darat
    case air
    case amfibi
}

protocol Hewan {
    var nama: String { get set }
    var type: TipeHewan { get set }
    
    func description()
}

protocol Burung: Hewan {
    var ketinggian: Int { get set }
}

extension Burung {
    func description() {
        if ketinggian == 0 {
            print("Hewan \(nama) dalah tipe hewan yang hidup di \(type) dan tidak dapat terbang")
        } else {
            print("Hewan \(nama) dalah tipe hewan yang hidup di \(type) dan dapat terbang dengan ketingian \(ketinggian)")
        }
    }
}

protocol Terbang {
    mutating func aturKetinggian(ketinggian: Int)
}

protocol Ikan: Hewan {
    var kedalaman: Int { get set }
    mutating func aturKedalaman(kedalaman: Int)
}

protocol HewanDarat: Hewan {
    var kecepatan: Int { get set }
    mutating func aturKecepatan(kecepatan: Int)
}

extension HewanDarat {
    func description() {
        print("Hewan \(nama) dalah tipe hewan yang hidup di \(type) dan berlari dengan kecepatan \(kecepatan) km/jam")
    }
    
    mutating func aturKecepatan(kecepatan: Int) {
        self.kecepatan = kecepatan
    }
}

class Penguin: Burung {
    var ketinggian: Int = 0
    var nama: String = "Penguin"
    var type: TipeHewan = .darat
}

class Merpati: Burung, Terbang {
    var ketinggian: Int = 10
    var nama: String = "Merpati"
    var type: TipeHewan = .darat
    
    func aturKetinggian(ketinggian: Int) {
        self.ketinggian = ketinggian
    }
}

class Sapi: HewanDarat {
    var nama: String = "Sapi"
    var type: TipeHewan = .darat
    var kecepatan: Int = 40
}

class Ceetah: HewanDarat {
    var nama: String = "Ceetah"
    var type: TipeHewan = .darat
    var kecepatan: Int = 100
}

class Paus: Ikan {
    var kedalaman: Int = 20
    var nama: String = "Paus"
    var type: TipeHewan = .air
    
    func aturKedalaman(kedalaman: Int) {
        self.kedalaman = kedalaman
    }
    
    func description() {
        print("Hewan \(nama) dalah tipe hewan yang hidup di \(type) dan dapat menyelam sampai kedalaman \(kedalaman) m")
    }
}

let merpati = Merpati()
let penguin = Penguin()
let sapi = Sapi()
let ceetah = Ceetah()
let paus = Paus()

let koleksiHewan: [Hewan] = [merpati, penguin, sapi, ceetah, paus]

class KebunBinatangManager {
    var collection: [Hewan]
    
    init(collection: [Hewan]) {
        self.collection = collection
    }
    
    func parsing() {
        for hewan in collection {
            hewan.description()
        }
    }
}

KebunBinatangManager(collection: koleksiHewan).parsing()

struct Rupiah {
    var value: CGFloat
    
    var Dollar: CGFloat {
        get {
            return value * 13000
        }
    }
}

Rupiah(value: 100).Dollar
 */
