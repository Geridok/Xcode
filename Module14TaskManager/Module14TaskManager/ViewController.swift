//
//  ViewController.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 22.05.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //MARK: - Properties
    var container: NSPersistentContainer!
    
    var tasks = [Task]()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        table.register(HeaderTableViewCell.nib(), forCellReuseIdentifier: HeaderTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var popUpWindow: PopUpWindowView = {
        let view = PopUpWindowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var datePickerViewPresenter = PickerViewPresenter()
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        return formatter
    }()
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = NSPersistentContainer(name: "TaskInfo")

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        for item in [tableView,visualEffectView,datePickerViewPresenter] {
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
        datePickerViewPresenter.datePickerDelegate = self
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        visualEffectView.alpha = 0
        popUpWindow.alpha = 0
    }
    
    //MARK: - CoreData
    
    func saveContext(){
        if container.viewContext.hasChanges {
            do{
                try container.viewContext.save()
            }catch{
                print("Errors: \(error)")
            }
        }
    }
    

    func loadSavedData(){
        let request = Task.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        do {
           tasks = try container.viewContext.fetch(request)
        } catch  {
            print("load Faled")
        }
    }
    
    //MARK: -Selectors
    
    @IBAction func addTaskPopUp(_ sender: Any) {
        view.addSubview(popUpWindow)

        popUpWindow.delegate = self
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        UIView.animate(withDuration: 0.5) {
            self.popUpWindow.alpha = 1
            self.visualEffectView.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
        
        NSLayoutConstraint.activate([
            popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64),
            popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64),
        ])
        popUpWindow.layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.frame = popUpWindow.bounds
        gradient.colors = [UIColor(red: 0.46, green: 0.89, blue: 0.76, alpha: 1.00).cgColor,UIColor(red: 0.30, green: 0.81, blue: 1.00, alpha: 1.00).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        popUpWindow.layer.insertSublayer(gradient, at: 0)
        
        popUpWindow.layer.cornerRadius = 20
        popUpWindow.clipsToBounds = true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: -Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
            cell.configure(unCompleteTaskAmount: 5, completeTaskAmount: 30, overDueTaskAmount: 100)
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        let date = tasks[indexPath.row].date
        
        cell.configure(taskName: tasks[indexPath.row].taskDescriprtion, date: dateFormatter.string(from: date))
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        } else {
            return 50
        }
    }
    
}

extension ViewController: TaskActionDelegate{
    func showDatePicker() {
        datePickerViewPresenter.showPicker()
    }
    
    @objc func hideDatePicker() {
        datePickerViewPresenter.doneButtonTapped()
    }
    
    
    func saveData(taskName: String?, taskDecription: String?, date: Date?) {
        
    }
    
    func cancelData() {
        UIView.animate(withDuration: 0.5) {
            self.popUpWindow.alpha = 0
            self.visualEffectView.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            self.popUpWindow.removeFromSuperview()
        }
        popUpWindow = PopUpWindowView()
        popUpWindow.translatesAutoresizingMaskIntoConstraints = false
        popUpWindow.layer.cornerRadius = 10
        self.hideDatePicker()
    }
    
}
extension ViewController: DatePickerValueChangedDelegate{
    func datePickerValueChanged(date: Date) {
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 14),
              .foregroundColor: UIColor.black,
        ]
        let attributeString = NSMutableAttributedString(
            string: dateFormatter.string(from: date),
           attributes: attributes
        )
        UIView.transition(with: self.popUpWindow.datePickerLabelButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popUpWindow.datePickerLabelButton.setAttributedTitle(attributeString, for: .normal)
        }, completion: nil)
        
    }
    
    
}
