//
//  With.swift
//  Core
//
//  Created by Marcos Said on 30/01/19.
//  Copyright © 2019 GreenCode. All rights reserved.
//

import Foundation
/// This class have two major uses: Be a interface element selector make easy the casting and be a easier way to associate a action to a element through the target property without using the outlet. It works with button, barButtonItem e label til now.
/// Example 1: In your ViewController class you should use With.shared.append("button1",myButton).append("label1",myLabel).done . With has a shared instance, so you can use it in any other class in your code like With.shared.label("label1").text = "myText"
/// Example 2: You can define a action bo button using With.shared.target.append("button1", action: { print("my button was clicked") }).done()
public class With: Chainable {
    /// The shared instance of this class
    public static let shared = With()
    private var elements:[String: Any?] = [:]
    /// Allow append a action/event, like what happens when to click a button
    public let target = Target()
    
    private init() { }
    
    /// Append a interface element's reference
    ///
    /// - Parameters:
    ///   - name: the identifier, we suggest to use the same variable name
    ///   - object: the interface eleemnt
    public func append(_ name: String, _ object: Any?) -> Self {
        elements[name] = object
        return self
    }
    
    /// Add one or more references to UI's elements
    ///
    /// - Parameter elements: the id e thw reference of UI element
    public func append(_ elements: [String: Any?]) -> Self {
        for f in elements {
            self.elements[f.key] = f.value
        }
        return self
    }
    
    /// Retorna o elemento da interface sem casting. Se ele não existir, dará fatal error
    ///
    /// - Parameter name: o identificador passado em append
    public func any(_ name: String) -> Any? {
        return elements[name]!
    }
    
    /// Return if the UI element has reference in this class
    ///
    /// - Parameter name: the id used in append method
    public func exists(_ name: String) -> Bool {
        return elements[name] != nil
    }
    
    /// Clear all stored references
    public func clear() {
        elements.removeAll()
        target.actions.removeAll()
    }
    
    /// Returns the UI element with casting to tableview
    ///
    /// - Parameter name: the identifier
    public func tableView(_ name: String) -> UITableView {
        return elements[name] as! UITableView
    }
    
    /// Returns the UI element with casting to textfield
    ///
    /// - Parameter name: the identifier
    public func textField(_ name: String) -> UITextField {
        return elements[name] as! UITextField
    }
    
    /// Returns the UI element with casting to textfield
    ///
    /// - Parameter name: the identifier
    public func view(_ name: String) -> UIView {
        return elements[name] as! UIView
    }
    
    /// Returns the UI element with casting to label
    ///
    /// - Parameter name: the identifier
    public func label(_ name: String) -> UILabel {
        return elements[name] as! UILabel
    }
    
    /// Returns the UI element with casting to stackview
    ///
    /// - Parameter name: the identifier
    public func stackView(_ name: String) -> UIStackView {
        return elements[name] as! UIStackView
    }
    
    /// Returns the UI element with casting to scrollview
    ///
    /// - Parameter name: the identifier
    public func scrollView(_ name: String) -> UIScrollView {
        return elements[name] as! UIScrollView
    }
    
    /// Returns the UI element with casting to stackview
    ///
    /// - Parameter name: the identifier
    public func linearView(_ name: String) -> UILinearView {
        return elements[name] as! UILinearView
    }
    
    /// Returns the UI element with casting to pickerview
    ///
    /// - Parameter name: the identifier
    public func pickerView(_ name: String) -> UIPickerView {
        return elements[name] as! UIPickerView
    }
    
    /// Returns the UI element with casting to barButtonItem
    ///
    /// - Parameter name: the identifier
    public func barButtonItem(_ name: String) -> UIBarButtonItem {
        return elements[name] as! UIBarButtonItem
    }
    
    /// Returns the UI element with casting to barButtonItem
    ///
    /// - Parameter name: the identifier
    public func button(_ name: String) -> UIButton {
        return elements[name] as! UIButton
    }
    
    /// Returns the UI element with casting to switch
    ///
    /// - Parameter name: the identifier
    public func `switch`(_ name: String) -> UISwitch {
        return elements[name] as! UISwitch
    }
    
    /// Just finish the call chain to avoid warnings
    public func done() -> Void{}
    
    /// Class created to define actions to buttons, without use the oulets
    public class Target: Chainable {
        var actions:[()->Void] = []
        
        /// Add a action event. In a button case, it'll be when click it.
        ///
        /// - Parameters:
        ///   - name: the UI element identifier, the same used in parent class
        ///   - action: the action
        public func append(_ name: String, action: @escaping () -> Void) -> Self {
            let any = With.shared.any(name)
            
            var founded = false
            if let button = any as? UIButton {
                button.tag = actions.count
                button.addTarget(self, action: #selector(self.action), for: .touchUpInside)
                founded = true
            }
            if let barButtonItem = any as? UIBarButtonItem {
                barButtonItem.tag = actions.count
                barButtonItem.target = self
                barButtonItem.action = #selector(self.action)
                founded = true
            }
            //label need to associate to a gesture recognizer
            if let label = any as? UILabel {
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.action))
                label.tag = actions.count
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(tap)
                founded = true
            }
            if !founded {
                fatalError("the view type doesn't have support to append action using this class")
            }
            
            actions.append(action)
            return self
        }
        
        /// Just finish the call chain to avoid warnings
        public func done() -> Void{}
        
        @objc private func action(_ sender: Any) -> Void {
           //tentar converter
            var index = -1
            if let button = sender as? UIButton {
                index = button.tag
            }
            if let barButtonItem = sender as? UIBarButtonItem {
                index = barButtonItem.tag
            }
            if let label = sender as? UILabel {
                index = label.tag
            }
            //because it's gesture, use the associate view and invoke the method again
            if let tap = sender as? UITapGestureRecognizer {
                return self.action(tap.view!)
            }
            if index == -1 {
                fatalError()
            }
            actions[index]()
        }
    }
}
