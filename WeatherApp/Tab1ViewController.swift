//
//  Tab1ViewController.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 5.07.2017.
//  Copyright © 2017 Ömer Koçbil. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var yoklamaButton: UIButton!
    @IBOutlet weak var dersList: UIPickerView!
    @IBOutlet weak var tarihList: UIDatePicker!
    @IBOutlet weak var deneyapList: UIPickerView!
    let userService = UserService()
    
    var deneyap = [String]()
    var secilenDeneyap: Int = 0
    
    var ders = [String]()
    var secilenDers: Int = 0
    
    var basilmaSayisi: Int = 0
    
    @IBAction func yoklamaGetirButtonClick(_ sender: Any) {
        self.userService.getAttendence(deneyapId: String(secilenDeneyap), lessonId: String(secilenDers), tarih: tarihList.date.description.substring(to:tarihList.date.description.index(tarihList.date.description.startIndex, offsetBy: 10)))
        print(tarihList.date.description.substring(to:tarihList.date.description.index(tarihList.date.description.startIndex, offsetBy: 10)))
        
        usleep(1000000)
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "YoklamaPageActivity") as! YoklamaPage
        self.present(next, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userService.getDeneyap()
        
        // deneyap file
        let file2 = "deneyap.txt" //this is the file. we will write to and read from it
        var dersler: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file2)
            
            //reading
            do {
                dersler = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 deneyap")
            }
        }
        
        print(dersler)
        
        var sahteattendence = [String]()
        sahteattendence.append("Lütfen Deneyap Seçiniz")
        
        let yaz2 = dersler
        var sayac2 = yaz2.index(yaz2.startIndex, offsetBy: 0)
        var at2 = 0
        for index in 0..<yaz2.characters.count {
            let index2 = yaz2.index(yaz2.startIndex, offsetBy: index)
            if yaz2[index2] == "|" {
                let range = sayac2..<index2
                if at2 == 0 {
                    sahteattendence.append(yaz2.substring(with: range))
                    at2 = 1
                }
                else {
                    var ali = yaz2.substring(with: range)
                    sahteattendence.append(String(ali.characters.dropFirst()))
                }
                sayac2 = index2
            }
        }
        
        deneyap = sahteattendence
        print(deneyap)
        
        self.userService.getLessons()
        
        // lesson file
        let file3 = "lessons.txt" //this is the file. we will write to and read from it
        var dersler3: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file3)
            
            //reading
            do {
                dersler3 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 lesson")
            }
        }
        
        print(dersler3)
        
        var sahtedersler = [String]()
        sahtedersler.append("Lütfen Ders Seçiniz")
        
        let yaz = dersler3
        var sayac = yaz.index(yaz.startIndex, offsetBy: 0)
        var at = 0
        for index in 0..<yaz.characters.count {
            let index2 = yaz.index(yaz.startIndex, offsetBy: index)
            if yaz[index2] == "|" {
                let range = sayac..<index2
                if at == 0 {
                    sahtedersler.append(yaz.substring(with: range))
                    at = 1
                }
                else {
                    var ali = yaz.substring(with: range)
                    sahtedersler.append(String(ali.characters.dropFirst()))
                }
                sayac = index2
            }
        }
        
        ders = sahtedersler
        print(ders)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == deneyapList {
            return String(deneyap[row])
        }
        else {
            return String(ders[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == deneyapList {
            return deneyap.count
        }
        else {
            return ders.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == deneyapList {
            print(row)
            secilenDeneyap = row
        }
        else {
            print(row)
            secilenDers = row
        }
    }

}
