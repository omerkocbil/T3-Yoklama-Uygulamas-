//
//  Tab3ViewController.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 6.07.2017.
//  Copyright © 2017 Ömer Koçbil. All rights reserved.
//

import UIKit

class Tab3ViewController: UIViewController, UITextFieldDelegate {
    
    let userService = UserService()
    
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var sifre: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var soyisim: UITextField!
    @IBOutlet weak var isim: UITextField!
    
    @IBAction func guncelleButtonClick(_ sender: Any) {
        // id file
        let file = "id.txt" //this is the file. we will write to and read from it
        var id: String = ""
        var durum: Bool = false
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            
            //reading
            do {
                id = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata2 id")
            }
        }
        
        self.userService.updateUser(id: id, isim: self.isim.text!, soyisim: self.soyisim.text!
            , email: self.email.text!)
        
        if self.sifre.text?.characters.count != 0 {
            self.userService.updateUserPassword(id: id, password: self.sifre.text!)
            durum = true
        }
        
        usleep(1000000)
        
        if durum {
            openCityAlert()
        }
        else {
            openCityAlert5()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tel.delegate = self
        self.sifre.delegate = self
        self.email.delegate = self
        self.soyisim.delegate = self
        self.isim.delegate = self
        
        // name file
        let file = "name.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                isim.text = text2
            }
            catch {
                print("Hata2 name")
            }
        }
        
        // surname file
        let file2 = "surname.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file2)
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                soyisim.text = text2
            }
            catch {
                print("Hata2 surname")
            }
        }
        
        // email file
        let file3 = "email.txt" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file3)
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                email.text = text2
            }
            catch {
                print("Hata2 email")
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func openCityAlert(){
        // Create alert
        let alert = UIAlertController(title: "Başarılı Güncelleme", message: "Kullanıcı bilgileriniz ve şifreniz başarı ile değiştirildi", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCityAlert5(){
        // Create alert
        let alert = UIAlertController(title: "Başarılı Güncelleme", message: "Kullanıcı bilgileriniz başarı ile değiştirildi", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
