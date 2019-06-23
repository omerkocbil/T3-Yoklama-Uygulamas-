//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 5.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UserServiceDelegate {
    
    let userService = UserService()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var sifre: UITextField!
    
    @IBAction func girisYapButtonClick(_ sender: Any) {
        self.userService.checkUser(email: self.email.text!, password: self.sifre.text!)
        
        // kullaniciKaydi file
        let file7 = "kullaniciKaydi.txt" //this is the file. we will write to and read from it
        let text7 = self.email.text! + "|" + self.sifre.text! + "|" //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file7)
            
            //writing
            do {
                try text7.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                print("Hata kullaniciKaydi")
            }
        }
        
        usleep(1000000)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sifre.delegate = self
        self.email.delegate = self
        self.userService.delegate = self
        
        usleep(1500000)
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        
        let filePath = url.appendingPathComponent("kullaniciKaydi.txt").path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            
            // kullaniciKaydi file
            let file2 = "kullaniciKaydi.txt" //this is the file. we will write to and read from it
            var isimler: String = ""
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file2)
                
                //reading
                do {
                    isimler = try String(contentsOf: path, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata2 kullaniciKaydi")
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
            
            self.email.text = sahtenames[0]
            self.sifre.text = sahtenames[1]
            
            print(sahtenames)
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
    
    // UserServiceDelegate method
    func setUser(user: User) {
        if user.isCorrect == 1 {
            
            // id file
            let file5 = "id.txt" //this is the file. we will write to and read from it
            let text5 = user.id //just a text
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata id")
                }
            }
            
            // name file
            let file = "name.txt" //this is the file. we will write to and read from it
            let text = user.name //just a text
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file)
                
                //writing
                do {
                    try text?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                        print("Hata name")
                }
            }
            
            // surname file
            let file2 = "surname.txt" //this is the file. we will write to and read from it
            let text2 = user.surname //just a text
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file2)
                
                //writing
                do {
                    try text2?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata surname")
                }
            }
            
            // email file
            let file3 = "email.txt" //this is the file. we will write to and read from it
            let text3 = user.email //just a text
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file3)
                
                //writing
                do {
                    try text3?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata email")
                }
            }
            
            // password file
            let file4 = "password.txt" //this is the file. we will write to and read from it
            let text4 = user.password //just a text
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file4)
                
                //writing
                do {
                    try text4?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata password")
                }
            }
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! TabViewController
            self.present(nextViewController, animated:true, completion:nil)
        }
        else if user.isCorrect == 0 {
            openCityAlert()
        }
    }
    
    func openCityAlert(){
        // Create alert
        let alert = UIAlertController(title: "Hatalı Giriş", message: "E-Mail veya şifreniz hatalı", preferredStyle: UIAlertControllerStyle.alert)
        
        // Create cancel action
        let cancel = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
    }

}
