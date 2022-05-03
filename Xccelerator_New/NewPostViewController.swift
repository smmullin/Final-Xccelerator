//
//  NewPostViewController.swift
//  Xccelerator_New
//
//  Created by Sarah Mullings on 3/28/22.
//

import UIKit
import FirebaseFirestore
import FSCalendar

class NewPostViewController: UIViewController, FSCalendarDelegate {

    
    
    var ref: DocumentReference? = nil
    
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var startCalendar: FSCalendar!
    @IBOutlet weak var endCalendar: FSCalendar!
    var startDate: String = ""
    var endDate: String = ""
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let strin = formatter.string(from: date)
        //print("Start date is: \(strin)")
        if calendar == startCalendar{
            startDate = strin
            print("Start date is: \(strin)")
        }
        if calendar == endCalendar{
            endDate = strin
            print("End date is: \(endDate)")
        }
        
       
   }
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let formatting = DateFormatter()
//        formatting.dateFormat = "EEEE MM-dd-YYYY at h:mm a"
//        let endDate = formatting.string(from: date)
//        print("End date is: \(endDate)")
//    }
    
    @IBAction func savePost(_ sender: Any) {
        //var strin: String = calendar(startCalendar, didSelect: startCalendar.selectedDate!, at: startCalendar.monthPosition)
        //print(dates)
        
        guard let makeText = makeTextField.text, !makeText.isEmpty else {return}
        guard let colorText = colorTextField.text, !colorText.isEmpty else {return}
        APIFunctions.functions.savePost(make: makeText, color: colorText, startDate: startDate, endDate: endDate)
        self.navigationController?.popViewController(animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //ref = Firestore.firestore().collection("carPosts")
        startCalendar.delegate = self
        endCalendar.delegate = self
    }
    
    
}
