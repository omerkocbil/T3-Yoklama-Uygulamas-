//
//  Tab2ViewController.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 6.07.2017.
//  Copyright © 2017 Ömer Koçbil. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    let userService = UserService()
    var boolArray = [Bool]()
    
    @IBOutlet weak var ogrenciSoyad: UITextField!
    @IBOutlet weak var tcKimlik: UITextField!
    @IBOutlet weak var ders: UIPickerView!
    @IBOutlet weak var ogrenciAd: UITextField!
    @IBOutlet weak var liste: UITableView!
    
    @IBAction func yoklamayiGetirButtonClick(_ sender: Any) {
        self.userService.getStudent(name: self.ogrenciAd.text!, surname: self.ogrenciSoyad.text!, tcKimlik: self.tcKimlik.text!)
        
        usleep(1000000)
        
        // arananId file
        let file4 = "arananId.txt" //this is the file. we will write to and read from it
        var id: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file4)
            
            //reading
            do {
                id = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 arananId")
            }
        }
        
        print(id)
        
        
        self.userService.getAttendenceForSpecificStudent(id: id, lesson: String(secilenDers))
        
        usleep(1000000)
        
        // lessonDate file
        let file3 = "lessonDate.txt" //this is the file. we will write to and read from it
        var dersler2: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file3)
            
            //reading
            do {
                dersler2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 lessonDate")
            }
        }
        
        print(dersler2)
        
        var sahteattendence2 = [String]()
        
        let yaz3 = dersler2
        var sayac3 = yaz3.index(yaz3.startIndex, offsetBy: 0)
        var at3 = 0
        for index in 0..<yaz3.characters.count {
            let index2 = yaz3.index(yaz3.startIndex, offsetBy: index)
            if yaz3[index2] == "|" {
                let range = sayac3..<index2
                if at3 == 0 {
                    sahteattendence2.append(yaz3.substring(with: range))
                    at3 = 1
                }
                else {
                    var ali = yaz3.substring(with: range)
                    sahteattendence2.append(String(ali.characters.dropFirst()))
                }
                sayac3 = index2
            }
        }
        
        // presence file
        let file2 = "presence.txt" //this is the file. we will write to and read from it
        var dersler: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file2)
            
            //reading
            do {
                dersler = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 presence")
            }
        }
        
        print(dersler)
        
        var sahteattendence = [String]()
        
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
        
        var sahteattendence3 = [String]()
        
        for index in 0..<sahteattendence.count {
            if sahteattendence[index] == "1" {
                sahteattendence3.append("Geldi")
            }
            else if sahteattendence[index] == "0" {
                sahteattendence3.append("Gelmedi")
            }
        }
        
        print(sahteattendence3)
        
        var sahteattendence4 = [String]()
        
        for index in 0..<sahteattendence2.count {
            var kelime : String = ""
            
            let a1 = sahteattendence2[index].index(sahteattendence2[index].startIndex, offsetBy: 8)
            let a2 = sahteattendence2[index].index(sahteattendence2[index].startIndex, offsetBy: 10)
            let range = a1..<a2
            let ilk = sahteattendence2[index].substring(with: range)
            kelime = kelime + ilk + "-"
            
            let a3 = sahteattendence2[index].index(sahteattendence2[index].startIndex, offsetBy: 5)
            let a4 = sahteattendence2[index].index(sahteattendence2[index].startIndex, offsetBy: 7)
            let range2 = a3..<a4
            let orta = sahteattendence2[index].substring(with: range2)
            kelime = kelime + orta + "-"
            
            let a5 = sahteattendence2[index].index(sahteattendence2[index].startIndex, offsetBy: 0)
            let a6 = sahteattendence2[index].index(sahteattendence2[index].startIndex, offsetBy: 4)
            let range3 = a5..<a6
            let son = sahteattendence2[index].substring(with: range3)
            kelime = kelime + son
            
            sahteattendence4.append(kelime)
        }
        
        print(sahteattendence4)
        
        var gelmeDurumu = [String]()
        
        for index in 0..<sahteattendence4.count {
            gelmeDurumu.append(sahteattendence4[index] + "                    " + sahteattendence3[index])
        }
    
        print(gelmeDurumu)
        
        names = gelmeDurumu
        print(names)
        
        self.liste.reloadData()

    }
    
    var lessons = [String]()
    var names = [String]()
    var secilenDers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ogrenciAd.delegate = self
        self.ogrenciSoyad.delegate = self
        self.tcKimlik.delegate = self
        self.liste.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        liste.delegate = self
        liste.dataSource = self
        
        self.userService.getLessons()
        
        // lesson file
        let file2 = "lessons.txt" //this is the file. we will write to and read from it
        var dersler: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file2)
            
            //reading
            do {
                dersler = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 lesson")
            }
        }
        
        print(dersler)
        
        var sahtedersler = [String]()
        sahtedersler.append("Lütfen Ders Seçiniz")
        
        let yaz = dersler
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
        
        lessons = sahtedersler
        print(lessons)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        boolArray.append(false)
        let cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: "cell2")
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lessons[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lessons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        secilenDers = row
    }
    
}
