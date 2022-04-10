//
//  LoginViewController.swift
//  UsersApi
//
//  Created by user213590 on 4/8/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var request = requestApi()
    var usrLogin = LoginUser()
    var bd = UserApiData()
    var url = "https://reqres.in/api/login/"
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var nameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
        isToken()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        isToken()
    }
    
    func isToken()  {
        var user : [LoginUser] = bd.listar()
        for a in user{
            if (a.token != ""){
                let vc = storyboard?.instantiateViewController(withIdentifier: "listUser") as! UserTableViewController
                vc.navbar = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func loginApi(_ sender: Any) {
        var response = request.getRequest(url: url, method: "POST")
        let usr =  LoginUser()
        usr.email = nameText.text
        usr.password = emailText.text
        
        do {
            try response.httpBody = JSONEncoder().encode(usr)
        } catch {
            print ("Erro ao converter")
        }
        
        let tarefa =  URLSession.shared.dataTask(with: response){ [self]
            (dados, resposta, erro) in
            if(erro == nil){
                print("usuário criado com sucesso")
                
                if let dadosRetornados = dados{
                    do{
                        let decoder = try JSONDecoder().decode(LoginUser.self, from: dadosRetornados)
                        usrLogin.email = nameText.text
                        usrLogin.password = emailText.text
                        
                        usrLogin.token = decoder.token!
                        bd.salve(user: usrLogin)
                        
                    }catch{
                        
                    }
                }
            }else{
                print("erro ao cadastrar")
                
            }
            
        }
        
        tarefa.resume()
        isToken()
        
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
