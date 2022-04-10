//
//  UserTableViewController.swift
//  UsersApi
//
//  Created by user213590 on 4/6/22.
//

import UIKit

class UserTableViewController: UITableViewController {

    var users : [User] = []
    var navbar : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = navbar
        
        if let url = URL(string: "https://reqres.in/api/users"){
            let tarefa = URLSession.shared.dataTask(with: url){
                (dados, requisicao, erro) in
                
                if erro == nil {
                    print("Dados Capturados")
                 
                    if let dadosRetornados = dados {
                        do  {
                            let response = try JSONDecoder().decode(userApi.self, from: dadosRetornados)
                            
                            for data in response.data{
                             
                                self.users.append(data)
                               
                            }
                            self.tableView.reloadData()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }else{
                    print("Erro ao consultar a Api")
                }
            }
            tarefa.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath) as! CellTableViewCell
        
        cell.firstText.text = users[indexPath.row].first_name
        cell.lastText.text = users[indexPath.row].last_name
        cell.emailText.text = users[indexPath.row].email
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = storyboard?.instantiateViewController(withIdentifier: "userInformation") as! ViewController
        vc.userForm = users[indexPath.row]
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let url = URL(string: "https://reqres.in/api/users/" + String (users[indexPath.row].id!))!
            print(url)
           var requisicao = URLRequest(url: url)
            requisicao.httpMethod = "DELETE"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            
            
            let tarefa =  URLSession.shared.dataTask(with: requisicao){
                (dados, resposta, erro) in
                if(erro == nil){
                    print("User deletado com sucesso")
                }else{
                    print("erro ao cadastrar")
                    
                }
                
            }
            tarefa.resume()
          
          
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) 
        }
        // Delete the row from the data source
            
        
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
