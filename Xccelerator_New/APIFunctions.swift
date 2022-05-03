//
//  APIFunctions.swift
//  Xccelerator_New
//
//  Created by Sarah Mullings on 3/28/22.
//

import Foundation
import Firebase
import FirebaseFirestore

struct carPost: Identifiable {
    var id: String
    var make: String
    var color: String
    var startDate: String
    var endDate: String
//    var longitude: Double
//    var latitude: Double
}

class APIFunctions {
    static let functions = APIFunctions() //creates an instance of the class
    
    var ref: DocumentReference? = nil
    var delegate: DataDelegate?
    var carArray: [carPost] = []
    
    func savePost(make: String, color: String, startDate: String, endDate: String){
        let dataToSave : [String: String] = ["make": make, "color": color, "startDate": startDate, "endDate": endDate]
        ref = Firestore.firestore().collection("Postings").addDocument(data: dataToSave) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
    }
    
    func getPosts(){
        Firestore.firestore().collection("Postings").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.carArray = []
                for document in querySnapshot!.documents {
                    let post = carPost(id: document.documentID, make: document.data()["make"] as! String, color: document.data()["color"] as! String, startDate: document.data()["startDate"] as! String, endDate: document.data()["endDate"] as! String)
                    //print("\(document.documentID) => \(document.data())")
                    self.carArray.append(post)
                }//create an instance of car post and add it that way
                print("Car array is filled")
                self.delegate?.updateArray(newArray: self.carArray)
            }
        }
    }
    func deletePost(id: String){
        print("Going to delete post")
        print(id)
        Firestore.firestore().collection("Postings").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
