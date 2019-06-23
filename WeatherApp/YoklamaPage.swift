//
//  YoklamaPage.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 25.08.2017.
//  Copyright © 2017 Ömer Koçbil. All rights reserved.
//

import UIKit

class YoklamaPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func geriButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var liste: UITableView!

    let userService = UserService()
    
    var names = [String]()
    var attendences = [String]()
    var boolArray = [Bool]()

    @IBAction func yoklamayiKaydetClick(_ sender: Any) {
        // attendence file
        let file3 = "attendenceId.txt" //this is the file. we will write to and read from it
        var isimler2: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file3)
            
            //reading
            do {
                isimler2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 attendenceId")
            }
        }
        
        var sahteattendence = [String]()
        
        let yaz2 = isimler2
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
        
        attendences = sahteattendence
        
        for index in 0..<attendences.count {
            if boolArray[index] == true {
                self.userService.updateAttendence(attendenceId: attendences[index], presence: "1")
            }
            else if boolArray[index] == false {
                self.userService.updateAttendence(attendenceId: attendences[index], presence: "0")
            }
        }
        
        usleep(1000000)
        
        openCityAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.liste.register(UITableViewCell.self, forCellReuseIdentifier: "aliii")
        liste.delegate = self
        liste.dataSource = self
        
        // studentName file
        let file3 = "studentName.txt" //this is the file. we will write to and read from it
        var isimler2: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file3)
            
            //reading
            do {
                isimler2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 studentName")
            }
        }
        
        var sahtenames2 = [String]()
        
        let yaz2 = isimler2
        var sayac2 = yaz2.index(yaz2.startIndex, offsetBy: 0)
        var at2 = 0
        for index in 0..<yaz2.characters.count {
            let index2 = yaz2.index(yaz2.startIndex, offsetBy: index)
            if yaz2[index2] == "|" {
                let range = sayac2..<index2
                if at2 == 0 {
                    sahtenames2.append(yaz2.substring(with: range))
                    at2 = 1
                }
                else {
                    var ali = yaz2.substring(with: range)
                    sahtenames2.append(String(ali.characters.dropFirst()))
                }
                sayac2 = index2
            }
        }
        
        names = sahtenames2
        print("-------------------------------------")
        print(names)
        
        // presenceGuncelleme file
        let file2 = "presenceGuncelleme.txt" //this is the file. we will write to and read from it
        var isimler: String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file2)
            
            //reading
            do {
                isimler = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 presenceGuncelleme")
            }
        }
        
        var sahtenames = [String]()
        
        let yaz = isimler
        var sayac = yaz.index(yaz.startIndex, offsetBy: 0)
        var at = 0
        for index in 0..<yaz.characters.count {
            let index2 = yaz.index(yaz.startIndex, offsetBy: index)
            if yaz[index2] == "|" {
                let range = sayac..<index2
                if at == 0 {
                    sahtenames.append(yaz.substring(with: range))
                    at = 1
                }
                else {
                    var ali = yaz.substring(with: range)
                    sahtenames.append(String(ali.characters.dropFirst()))
                }
                sayac = index2
            }
        }
        
        print(sahtenames)
        
        for index in 0..<sahtenames.count {
            if sahtenames[index] == "1" {
                boolArray.append(true)
            }
            else if sahtenames[index] == "0" {
                boolArray.append(false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        boolArray.append(false)
        let cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: "Cells")
        cell.textLabel?.text = names[indexPath.row]
        
        if boolArray[indexPath.row] {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            boolArray[indexPath.row] = false
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            boolArray[indexPath.row] = true
        }
    }
    
    func openCityAlert(){
        // Create alert
        let alert = UIAlertController(title: "Başarılı Kayıt", message: "Yoklama başarı ile kaydedildi", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCityAlert2(){
        // Create alert
        let alert = UIAlertController(title: "Başarısız Kayıt", message: "Yoklama kaydedilemedi", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
