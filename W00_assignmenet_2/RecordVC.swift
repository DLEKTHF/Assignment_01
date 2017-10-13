
import UIKit

class RecordVC: UIViewController,UITextFieldDelegate  {

    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
  
    var  bankInfo:String?
    var  nameInfo:String?
    var  accountInfo:String?
  
    let pickerView = UIPickerView()
  
    var pickOption = ["KB국민","신한","우리","하나","NH농협","IBK기업","외환","SC제일","씨티",
                      "KDB산업","새마을","대구","광주","우체국","카카오뱅크","신협","전북","경남","부산","수협","제주",
                      "저축은행","케이뱅크","HSBC","중국공상","JP모간","도이치","BNP파라바","BOA"]
    
    lazy var bankData = [String]()
    lazy var nameData = [String]()
    lazy var accountData = [String]()
  
    //데이터를 저장할수 있는 빈 집합을 만든다.
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    if textField == bankTextField{
      pickerView.selectRow(0, inComponent: 0, animated: true)
      bankTextField.text = pickOption[0]
    }
  }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
      
        return true
    }
    //입력이 끝나고 키보드가 사라지게 하기위해 textField대신 Record가 키보드 처리하도록 한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        bankTextField.inputView = pickerView
        self.title = "입력"
      
      if let safeBankInfo =  bankInfo, let safeNameInfo = nameInfo, let safeAccountInfo = accountInfo {
          bankTextField.text = safeBankInfo
          nameTextField.text = safeNameInfo
          accountTextField.text = safeAccountInfo
      }
      
      retrieveData()
  }
  
  
  @IBAction func add(_ sender: Any) {
    
    if didCheckValidate()  {
      
       bankData.append(bankTextField.text!)
       nameData.append(nameTextField.text!)
       accountData.append(accountTextField.text!)
       saveData()
       alertView(true)
      
    }else {
       alertView(false)
    }
    
  }
  
  @IBAction func Delete(_ sender: Any) {

    if let idx = bankData.index(of:bankTextField.text!) {
      
        bankData.remove(at: idx)
        nameData.remove(at: idx)
        accountData.remove(at: idx)
        saveData()
        deletealertView(true)
      
    }else {
        deletealertView(false)
    }
}
  func  didCheckValidate()  -> Bool   {
    return !bankTextField.text!.isEmpty && !nameTextField.text!.isEmpty && !accountTextField.text!.isEmpty
  }
  
  func retrieveData()  {

    if  let safeBankData  =  UserDefaults.standard.object(forKey: accountKey.bankData) as? [String] {
        self.bankData     =  safeBankData
    }
    if let safeNameData   = UserDefaults.standard.object(forKey: accountKey.nameData) as? [String]  {
        self.nameData     = safeNameData
    }
    if let safeAccountData = UserDefaults.standard.object(forKey: accountKey.accountData) as? [String] {
        self.accountData   = safeAccountData
    }
    print("bank ", self.bankData)
    print("name ", self.nameData)
    print("account ", self.accountData)

  }
  
  func saveData()  {
    
    UserDefaults.standard.set(bankData, forKey: accountKey.bankData)
    UserDefaults.standard.set(nameData, forKey: accountKey.nameData)
    UserDefaults.standard.set(accountData, forKey: accountKey.accountData)
    
  }
  
  func alertView(_ result:Bool)  {
    
    if result  {
     
      let dialog = UIAlertController(title: "알림", message: "내용이 저장되었습니다", preferredStyle: .alert)
      let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
      dialog.addAction(action)
      self.present(dialog, animated: true, completion: nil)
      
      bankTextField.text = ""
      nameTextField.text = ""
      accountTextField.text = ""
      
    }else {

      let dialog = UIAlertController(title: "경고", message: "모든 항목을 적어주세요", preferredStyle: .alert)
      let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
      dialog.addAction(action)
      self.present(dialog, animated: true, completion: nil)
    }
  }
    
    func deletealertView(_ result:Bool)  {
        
        if result  {
            
            let dialog = UIAlertController(title: "알림", message: "내용이 삭제되었습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
            
            bankTextField.text = ""
            nameTextField.text = ""
            accountTextField.text = ""

        }
    }
}

extension RecordVC : UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickOption.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickOption[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    bankTextField.text = pickOption[row]
  }
  
}
