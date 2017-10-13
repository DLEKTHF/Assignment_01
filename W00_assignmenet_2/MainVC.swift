
import UIKit


struct accountKey  {
  
  static let bankData = "BankData"
  static let nameData = "NameData"
  static let accountData = "AccountData"
  
}
class MainVC: UIViewController {
  
  
 lazy  var bankData = [String]()
 lazy  var nameData = [String]()
 lazy  var accountData = [String]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
       tableView.tableFooterView = UIView()
    
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    retrieveData()
    tableView.reloadData()
    
  }
  
 
  func retrieveData()  {
    
    if  let safeBankData = UserDefaults.standard.object(forKey: accountKey.bankData) as? [String] {
      self.bankData = safeBankData
    }
    if let safeNameData = UserDefaults.standard.object(forKey: accountKey.nameData) as? [String]  {
      self.nameData = safeNameData
    }
    if let safeAccountData = UserDefaults.standard.object(forKey: accountKey.accountData) as? [String] {
      self.accountData = safeAccountData
    }
    
    print("bank ", self.bankData)
    print("name ", self.nameData)
    print("account ", self.accountData)
    
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainVC:UITableViewDataSource,UITableViewDelegate  {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bankData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!MainCell
    cell.bankLabel.text = bankData[indexPath.row]
    cell.nameLabel.text = nameData[indexPath.row]
    cell.accountLabel.text = accountData[indexPath.row]
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   performSegue(withIdentifier: "mainToRecord", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "mainToRecord"  {
      
      let indexPath = sender as! IndexPath
      let recordVC = segue.destination as! RecordVC
    
      recordVC.bankInfo = bankData[indexPath.row]
      recordVC.nameInfo = nameData[indexPath.row]
      recordVC.accountInfo = accountData[indexPath.row]
      
    }

  }
  
  
}

