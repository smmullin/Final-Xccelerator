//
//  ViewController.swift
//  Xccelerator_New
//
//  Created by Sarah Mullings on 3/27/22.
//

import UIKit
import Firebase

protocol DataDelegate {
    func updateArray(newArray: [carPost])
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var addPostButton: UIBarButtonItem!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "carPostSegue"{
            let vc = segue.destination as! CarInfoViewController
            vc.carInfo = carPostsArray[carPostsTableView.indexPathForSelectedRow!.row]
        }

    }
    
    var carPostsArray = [carPost]()
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear called")
//        carPostsArray = []
        APIFunctions.functions.getPosts()
//        print(carPostsArray)
//self.carPostsTableView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear called")
//        carPostsArray = []
        APIFunctions.functions.getPosts()
//        print(carPostsArray)
//        self.carPostsTableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carPostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell") as! CarPostTableViewCell
        cell.makeLabel.text = carPostsArray[indexPath.row].make
        cell.colorLabel.text = carPostsArray[indexPath.row].color
        return cell
    }
    

    @IBOutlet weak var carPostsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load called")
        // Do any additional setup after loading the view.
        APIFunctions.functions.delegate = self
        //carPostsArray = []
        APIFunctions.functions.getPosts()
        carPostsArray = []
        self.carPostsTableView?.reloadData()
        carPostsTableView.delegate = self
        carPostsTableView.dataSource = self
    }
   
}

extension ViewController: DataDelegate{
    func updateArray(newArray: [carPost]) {
        carPostsArray = newArray
        self.carPostsTableView?.reloadData()
    }
}

