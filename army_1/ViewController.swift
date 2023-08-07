//
//  ViewController.swift
//  army_1
//
//  Created by Астемир Пшигусов on 05.04.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var datePicker: UIDatePicker!
    
    var currentDate = Date()
    var calendar = Calendar.current
    var dateComponents: DateComponents?
    var selectedDate = Date()
    var days: Int? = 0
    var hours: Int? = 0
    var minutes: Int? = 0
    var seconds: Int? = 0
    var weeks: Int? = 0
    var sotkaDays = Date()
    var differenceString = ""
    var segmentedActionFlag: Int = 0
    var timer : Timer?
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "Выбери дату ДМБ:"
        startButton.layer.cornerRadius = 15
        textLabel.font = textLabel.font.withSize(24)
        
        segmentedControl.setTitle("Общее", forSegmentAt: 0)
        segmentedControl.setTitle("Дней", forSegmentAt: 1)
        segmentedControl.setTitle("Недель", forSegmentAt: 2)
        //
        datePicker.locale = Locale(identifier: "ru_RU")
        updateTi()
        differenceString = String(format: "Осталось: %02dд %02dч %02dм %02dс", days!, hours!, minutes!, seconds!)
        textLabel.isHidden = true
    }
    
    
    
    @IBAction func showTimeButton() {
        currentDate = Date()
        calendar = Calendar.current
     
       //updateTi()
        textLabel.isHidden = false
        
        switch segmentedActionFlag {
        case 0:
            textLabel.text = differenceString
            if !flag {
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0 , repeats: true, block: { timer in
                    self.flag = true
                   
                    if (self.seconds!<=0) {
                        self.seconds!=59
                        if (self.minutes!<=0) {
                            (self.hours!=self.hours!-1)
                            (self.minutes!=59)
                            if (self.hours!<1) {
                                self.days!=self.days!-1
                            }
                        } else { self.minutes! = self.minutes!-1 }
                    } else { (self.seconds! = self.seconds!-1)}
                    self.differenceString = String(format: "Осталось: %02dд %02dч %02dм %02dс", self.days!, self.hours!, self.minutes!, self.seconds!)
                    if self.segmentedActionFlag == 0 {
                    self.textLabel.text = self.differenceString}
                })
            }
            differenceString = String(format: "Осталось: %02dд %02dч %02dм %02dс", days!, hours!, minutes!, seconds!)
        case 1:
            differenceString = String(format: "Осталось: %02d Дней", days!)
        default:
            weeks = (Int(Double(days!))/7)
            differenceString = String(format: "Осталось: %02d Недели", weeks!)
        }
        textLabel.text = differenceString
    }
    
    @IBAction func segmentedAction() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
           
            textLabel.text = differenceString
            textLabel.isHidden = false
            segmentedActionFlag = 0
        case 1:
            differenceString = String(format: "Осталось: %02d Дней", days!)
            textLabel.text = differenceString
            textLabel.isHidden = false
            segmentedActionFlag = 1
        default:
            weeks = (Int(Double(days!))/7)
            differenceString = String(format: "Осталось: %02d Недели", weeks!)
            textLabel.text = differenceString
            textLabel.isHidden = false
            segmentedActionFlag = 2
        }
    }

    @IBAction func chooseDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let dateFormatterSotka = DateFormatter()
        dateFormatterSotka.dateStyle = .short
        dateFormatterSotka.timeStyle = .none
        
    
        selectedDate = datePicker.date
        updateTi()
        sotkaDays = selectedDate
        var sotka = 0
        
        while sotka<100{
            sotka = sotka+1
            sotkaDays = (sotkaDays-TimeInterval((sotka)))
            print(sotka)
            print(sotkaDays)
        }
       
        
        textLabel.isHidden = true
    }
    
    func updateTi(){
        dateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: selectedDate)
        days = dateComponents?.day
        hours = dateComponents?.hour
        minutes = dateComponents?.minute
        seconds = dateComponents?.second
        
        differenceString = String(format: "Осталось: %02dд %02dч %02dм %02dс", days!, hours!, minutes!, seconds!)
    }
}

