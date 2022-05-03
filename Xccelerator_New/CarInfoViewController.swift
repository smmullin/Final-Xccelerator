//
//  CarInfoViewController.swift
//  Xccelerator_New
//
//  Created by Sarah Mullings on 3/28/22.
//

import UIKit

class CarInfoViewController: UIViewController {

    var carInfo: carPost?
    
    @IBOutlet weak var colorInfoLabel: UILabel!
    @IBOutlet weak var makeInfoLabel: UILabel!
    @IBOutlet weak var deletePostButton: UIButton!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    
    @IBAction func deletePost(_ sender: Any) {
        APIFunctions.functions.deletePost(id: carInfo!.id)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeInfoLabel.text = carInfo?.make
        colorInfoLabel.text = carInfo?.color
        startDateLabel.text = carInfo?.startDate
        endDateLabel.text = carInfo?.endDate
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
