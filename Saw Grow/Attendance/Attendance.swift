//
//  Attendance.swift
//  Saw Grow
//
//  Created by Truk Karawawattana on 22/12/2564 BE.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

enum attendanceTab {
    case request
    case history
}

class Attendance: UIViewController {
    
    var dateFromCalendar:Date?
    
    var attendanceTab:attendanceTab?
    
    var setColor: Bool = true
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var requestBtn: MyButton!
    @IBOutlet weak var historyBtn: MyButton!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if setColor {
            self.navigationController?.setStatusBarColor()
            headerView.setGradientBackground()
            
            setColor = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ATTENDANCE")
        
        if attendanceTab != nil {
            switch attendanceTab {
            case .history:
                segmentClick(historyBtn)
            default:
                break
            }
        }
        else{
            setTab(tab: .request)
        }
    }
    
    @IBAction func segmentClick(_ sender: UIButton) {
        self.view.endEditing(true)
        requestBtn.segmentOff()
        historyBtn.segmentOff()
        
        sender.segmentOn()
        
        switch sender.tag {
        case 1:
            setTab(tab: .request)
        case 2:
            setTab(tab: .history)
        default:
            break
        }
    }
    
    func setTab(tab:attendanceTab) {
        if self.children.count > 0 {
            for vc in self.children {
                if vc.isKind(of: AttendanceRequest.classForCoder())||vc.isKind(of: AttendanceHistory.classForCoder()) {
                    unEmbed(vc)
                }
            }
        }
        
        switch tab {
        case .request:
            let vc = UIStoryboard.attendanceStoryBoard.instantiateViewController(withIdentifier: "AttendanceRequest") as! AttendanceRequest
            vc.dateFromCalendar = dateFromCalendar
            embed(vc, inView: bottomView)
            
        case .history:
            let vc = UIStoryboard.attendanceStoryBoard.instantiateViewController(withIdentifier: "AttendanceHistory") as! AttendanceHistory
            embed(vc, inView: bottomView)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
}

