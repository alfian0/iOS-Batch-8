//: Playground - noun: a place where people can play

import UIKit

// https://codeburst.io/solid-design-principle-using-swift-fa67443672b8
// https://datasift.github.io/gitflow/IntroducingGitFlow.html

protocol IEmploye {
    func work()
}

struct Employe: IEmploye {
    func work() {
        
    }
}

struct Employe1: IEmploye {
    func work() {
        
    }
}

struct Manager {
    var employe: IEmploye
    
    init(employe: IEmploye) {
        self.employe = employe
    }
}

let employe = Employe()
let employe1 = Employe1()

Manager(employe: employe)
Manager(employe: employe1)
