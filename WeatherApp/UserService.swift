//
//  UserService.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 4.07.2017.
//  Copyright © 2017 Ömer Koçbil. All rights reserved.
//

import Foundation

protocol UserServiceDelegate {
    func setUser(user: User)
}

class UserService{
    
    var delegate: UserServiceDelegate?
    
    var lessons = [String]()
    var ids = [String]()
    
    let apiKey = "mobileapp"
    let sifre = "!Deneyap@T3#Automation$"
    
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    func checkUser(email: String, password: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let path = "http://www.deneyap.org/mobileservlet.php?servletMethod=loginControl&email=\(email)&password=\(password)&random=\(random)&hash=\(md5Hex)"
        let url = NSURL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let json = JSON(data: data!)
            let id = json[0]["id"].string
            let name = json[0]["name"].string
            let surname = json[0]["surname"].string
            let email = json[0]["email"].string
            let password = json[0]["password"].string
            let phoneNumber = json[0]["phoneNumber"].string
            
            
            if(name != nil) {
                let user = User(id: id!, name: name!, surname: surname!, email: email!, password: password!, phoneNumber: phoneNumber!, isCorrect: 1)
                if self.delegate != nil {
                    self.delegate?.setUser(user: user)
                }
            }
            else {
                let user = User(id: "-1", name: "", surname: "", email: "", password: "", phoneNumber: "0", isCorrect: 0)
                if self.delegate != nil {
                    self.delegate?.setUser(user: user)
                }
            }
       
        }
        
        task.resume()
    }
    
    func updateUser(id: String, isim: String, soyisim: String, email: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let url : NSString = "http://www.deneyap.org/mobileservlet.php?servletMethod=updateUser&user={\"id\":\"\(id)\",\"name\":\"\(isim)\",\"surname\":\"\(soyisim)\",\"email\":\"\(email)\"}&random=\(random)&hash=\(md5Hex)" as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            print(httpResponse.statusCode)
            
            let text5 = String(httpResponse.statusCode) //just a text
            
            // updateUserCode file
            let file5 = "updateUserCode.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata updateUserCode")
                }
            }
            
        }
        
        task.resume()
        
    }
    
    func updateUserPassword(id: String, password: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let url : NSString = "http://www.deneyap.org/mobileservlet.php?servletMethod=changePassword&user={\"id\":\"\(id)\", \"password\":\"\(password)\"}&random=\(random)&hash=\(md5Hex)" as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            print(httpResponse.statusCode)
            
            let text5 = String(httpResponse.statusCode) //just a text
            
            // updatePasswordCode file
            let file5 = "updatePasswordCode.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata updatePasswordCode")
                }
            }

            
        }
        
        task.resume()
        
    }
    
    func getAttendence(deneyapId: String, lessonId: String, tarih: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let url : NSString = "http://www.deneyap.org/mobileservlet.php?servletMethod=getAttendenceList&deneyap={\"id\":\"\(deneyapId)\"}&lesson={\"id\":\"\(lessonId)\"}&date=\(tarih)&random=\(random)&hash=\(md5Hex)" as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            var text5 = "" //just a text
            let json = JSON(data: data!)
            let length = json.count
            
            for index in 0..<length {
                let name = json[index]["studentNameSurname"].string
                text5 = text5 + name! + "|"
            }
            
            print(text5)
            
            // name file
            let file5 = "studentName.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata name")
                }
            }
            
            
            
            var text6 = "" //just a text
            let json2 = JSON(data: data!)
            let length2 = json2.count
            
            for index in 0..<length2 {
                let name = json2[index]["id"].string
                text6 = text6 + name! + "|"
            }
            
            print(text6)
            
            // attendence file
            let file6 = "attendenceId.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file6)
                
                //writing
                do {
                    try text6.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata attendence")
                }
            }
            
            
            
            var text7 = "" //just a text
            let json3 = JSON(data: data!)
            let length3 = json3.count
            
            for index in 0..<length3 {
                let name = json3[index]["presence"].string
                text7 = text7 + name! + "|"
            }
            
            print(text7)
            
            // presenceGuncelleme file
            let file7 = "presenceGuncelleme.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file7)
                
                //writing
                do {
                    try text7.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata presenceGuncelleme")
                }
            }
 
        }
        
        task.resume()
    }
    
    func updateAttendence(attendenceId: String, presence: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let url : NSString = "http://www.deneyap.org/mobileservlet.php?servletMethod=updateAttendence&attendence={\"id\":\"\(attendenceId)\",\"presence\":\"\(presence)\"}&random=\(random)&hash=\(md5Hex)" as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            print(httpResponse.statusCode)
            
            let text5 = String(httpResponse.statusCode) //just a text
            
            // updateAttendenceCode file
            let file5 = "updateAttendenceCode.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata updateAttendenceCode")
                }
            }

            
        }
        
        task.resume()
    }
    
    func getStudent(name: String, surname: String, tcKimlik: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let url : NSString = "http://www.deneyap.org/mobileservlet.php?servletMethod=searchStudents&student={\"name\":\"\(name)\",\"surname\":\"\(surname)\",\"citizenId\":\"\(tcKimlik)\"}&random=\(random)&hash=\(md5Hex)" as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            let json = JSON(data: data!)
            let id = json[0]["id"].string
            let text5 = id //just a text
            
            // arananId file
            let file5 = "arananId.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata arananId")
                }
            }
            
            print(response!)
            
        }
        
        task.resume()
    }
    
    func getAttendenceForSpecificStudent(id: String, lesson: String) {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let url : NSString = "http://www.deneyap.org/mobileservlet.php?servletMethod=getStudentAttendenceList&student={\"id\":\"\(id)\"}&lesson={\"id\":\"\(lesson)\"}&random=\(random)&hash=\(md5Hex)" as NSString
        let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        let session = URLSession.shared
        let task = session.dataTask(with: searchURL as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            var text6 = "" //just a text
            let json2 = JSON(data: data!)
            let length2 = json2.count
            
            for index in 0..<length2 {
                let lessonDate = json2[index]["lessonDate"].string
                text6 = text6 + lessonDate! + "|"
            }
            
            print(text6)
            
            // lessonDate file
            let file6 = "lessonDate.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file6)
                
                //writing
                do {
                    try text6.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata lessonDate")
                }
            }
            
            
            var text5 = "" //just a text
            let json = JSON(data: data!)
            let length = json.count
            
            for index in 0..<length {
                let presence = json[index]["presence"].string
                text5 = text5 + presence! + "|"
            }
            
            print(text5)
            
            // presence file
            let file5 = "presence.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata presence")
                }
            }
            
        }
        
        task.resume()
    }
    
    func getLessons() {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let path = "http://www.deneyap.org/mobileservlet.php?servletMethod=getLessonList&random=\(random)&hash=\(md5Hex)"
        let url = NSURL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            var text5 = "" //just a text
            let json = JSON(data: data!)
            let length = json.count
            for index in 0..<length {
                let id = json[index]["name"].string
                //let name = json[index]["name"].string
                //self.lessons.append(name!)
                self.ids.append(id!)
                text5 = text5 + id! + "|"
            }
            print(text5)
            
            // lesson file
            let file5 = "lessons.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata lesson")
                }
            }
            
        }
        
        task.resume()
    }
    
    func getDeneyap() {
        let random = String(arc4random_uniform(100))
        let md5Data = self.MD5(string: self.apiKey + self.sifre + random)
        
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        print("md5Hex: \(md5Hex)")
        
        let path = "http://www.deneyap.org/mobileservlet.php?servletMethod=getDeneyapList&random=\(random)&hash=\(md5Hex)"
        let url = NSURL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            var text5 = "" //just a text
            let json = JSON(data: data!)
            let length = json.count
            for index in 0..<length {
                let id = json[index]["name"].string
                //let name = json[index]["name"].string
                //self.lessons.append(name!)
                self.ids.append(id!)
                text5 = text5 + id! + "|"
            }
            print(text5)
            
            // lesson file
            let file5 = "deneyap.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let path = dir.appendingPathComponent(file5)
                
                //writing
                do {
                    try text5.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch {
                    print("Hata deneyap")
                }
            }
            
        }
        
        task.resume()
    }
    
}
