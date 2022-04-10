//
//  ViewController.swift
//  UsersApi
//
//  Created by user213590 on 4/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    var userForm = User()
    var index : Int = -1
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var lastText: UITextField!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isAlter()){
            buttonAction.setTitle("Alterar", for: .normal)
            emailText.text = userForm.email
            nameText.text = userForm.first_name
            lastText.text = userForm.last_name
            imgAvatar.image  = UIImage(data: NSData(contentsOf: NSURL(string: userForm.avatar!)! as URL)! as Data)
        }
        // Do any additional setup after loading the view.
    }
    
    func isAlter() -> Bool{
        return index >= 0 ? true : false
    }
    @IBAction func actionButton(_ sender: Any) {
        if(isAlter()){
            let url = URL(string: "https://reqres.in/api/users/" + String  (userForm.id!))!
            var requisicao = URLRequest(url: url)
            requisicao.httpMethod = "PATCH"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            userForm.first_name = nameText.text
            userForm.last_name = lastText.text
            userForm.email = emailText.text
            
            
            let encode = JSONEncoder()
            do {
                try requisicao.httpBody = encode.encode(userForm)
            } catch {
                print("erro ao converter")
                
            }
            
            let tarefa =  URLSession.shared.dataTask(with: requisicao){
                (dados, resposta, erro) in
                if(erro == nil){
                    print("Usuário alterado com sucesso")
                }else{
                    print("erro ao alterar")
                    
                }
                
            }
            
            tarefa.resume()
        } else {
            let url = URL(string: "https://reqres.in/api/users")!
            var requisicao = URLRequest(url: url)
            requisicao.httpMethod = "POST"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
           
            userForm.first_name = nameText.text
            userForm.last_name = lastText.text
            userForm.email = emailText.text
            
            let encode = JSONEncoder()
            do {
                try requisicao.httpBody = encode.encode(userForm)
            } catch {
                print("erro ao converter")
                
            }
            
            let tarefa =  URLSession.shared.dataTask(with: requisicao){
                (dados, resposta, erro) in
                if(erro == nil){
                    print("usuário criado com sucesso")
                }else{
                    print("erro ao cadastrar")
                    
                }
                
            }
            
            tarefa.resume()
        }
        }
    }
    


