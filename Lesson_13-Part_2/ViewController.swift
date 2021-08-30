//
//  ViewController.swift
//  Lesson_13-Part_2
//
//  Created by Evgeniy Nosko on 30.08.21.
//

import UIKit

//KVO - Key Value Observing - отслеживаем изменения, аналог в Swift (willSet/didSet)
//KVC - Kev Value Coding - изменяем объект, обращаясь не напрямую к нему, а по ключу
class Person: NSObject {
    
    // dynamic- чтобы отслеживать изменения
    @objc dynamic var name: String = ""
}


class ViewController: UIViewController {
    @IBOutlet weak var label:UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @objc var person = Person()
    var personObservation: NSKeyValueObservation?
    
    var textFieldObservation: NSKeyValueObservation?
    
    @objc dynamic var text: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        person.name = "Zhenya"
        
        //        отловить изменения
        personObservation = observe (
                    \.person.name,
                    options: [
                                        NSKeyValueObservingOptions.new,
//                                         NSKeyValueObservingOptions.old,
//                                         NSKeyValueObservingOptions.prior,
//                                         NSKeyValueObservingOptions.initial
                                        ]) { viewController, changedValue in
            viewController.label.text = changedValue.newValue
            print("Старое значение \(changedValue.oldValue)")
            print("Новое значение \(changedValue.newValue)")
        }
        person.name = "Zhenya"
        
        textFieldObservation = observe(
            \.text,
            options: [
                NSKeyValueObservingOptions.new
            ]) { viewController, changedValue in
            viewController.label.text = changedValue.newValue
            print("Старое значение \(changedValue.oldValue)")
            print("Новое значение \(changedValue.newValue)")
        }
    }
    @IBAction func textFieldDidChange() {
        text = textField.text ?? ""
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        person.name = "Zhenya"
    }
        
    
}

class PersonName {
    
    var personName: String = "" {
//        вызывается после wiilSet, и как присвоили новое значение
        didSet {
            print(self.personName)
        }
//        вызывается когда не успели присвоить новое значение
        willSet {
            print(self.personName)
        }
    }
    
}

