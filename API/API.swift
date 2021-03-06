//
//  API.swift
//  Taskatyy
//
//  Created by zoza on 15/04/2018.
//  Copyright © 2018 zoza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    
    class func login(user: String, pass: String, assid: String, completion: @escaping (_ error:Error?, _ success:Bool)->Void)
    {
        
        let url = URLs.Login
        let parameters = ["userName":user, "password":pass, "assid":assid]
        let header = ["Content-Type" : "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                if response.result.isSuccess{
                    let log = JSON(response.result.value)
                    UserStore.saveUser(User(log["LoginResult"]))
                    print ("Login succeeded")
                    // print(log)
                    completion(nil,true)
                    
                }
                else {
                    print ("Error\(response.result.error!)")
                    
                }
                //  print(response)
        }
    }
    
    
    
    class func filter()
    {
        let url = URLs.Filter
        Alamofire.request(url, method: .get, headers: nil)
            .responseJSON { response in
                
                if response.result.isSuccess{
                    _ = JSON(response.result.value!)
                }
                else {
                    print ("Error\(String(describing: response.result.error))")
                }
        }
    }
    
    
    
    class func filter2()
    {
        let url = URLs.Filter2
        Alamofire.request(url, method: .get, headers: nil)
            .responseJSON { response in
                
                if response.result.isSuccess{
                    _ = JSON(response.result.value!)
                }
                else {
                    print ("Error\(String(describing: response.result.error))")
                }
        }
    }
    

    class func show(creator: String, item: String, pgIndex: String, pgsize: String, asignTo: String, status: String, periority: String, program: String, type:String, user: String, lateItem: String, HideClosed:String, catid:String , completion: @escaping (_ error:Error?, _ success:Bool ,_ data:AnyObject?)
        ->Void)
    {
        let url = URLs.Show
        let parameters = ["workItemCreatedBy":creator, "workItemId":item, "pageIndex":pgIndex, "pageSize":pgsize, "workItemAssignedTo":asignTo, "workItemStatusId":status, "workItemPriorityId":periority, "workItemProgramId":program, "workItemTypeId":type, "userId":user, "lateItems":lateItem, "HideClosed":HideClosed, "catid":catid] as [String:AnyObject]
        
        let header = ["Content-Type" : "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success (let value):
                    completion(nil,true,value as AnyObject?)
                case .failure(let error):
                    
                    completion(error as NSError?,false,nil)
                }
                
        }
    }
    

    
    
    class func addBnd(creator: String, status: String, title: String, detail: String, assignTo: String, periority: String, date: String, catId: String, progrm: String, type: String, photos: [[String:Any]] , completion: @escaping (_ error:Error?, _ success:Bool ,_ data:AnyObject?)->Void)
    {
        let url = URLs.AddBand
        let parameters = ["WorkItemCreatedBy":creator, "WorkItemStatusId":status, "WorkItemTitle":title, "WorkItemDetails":detail, "WorkItemAssignedTo":assignTo, "WorkItemPriorityId":periority, "AssignDate":date, "CatID":catId , "WorkItemProgramId":progrm, "WorkItemTypeId":type, "photos":photos] as [String:AnyObject]
        
        let header = ["Content-Type" : "application/json" , "Accept" :  "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success (let value):
                    completion(nil,true,value as AnyObject?)
                case .failure(let error):
                    completion(error as NSError?,false,nil)
                }
                
        }
    }
    //"workItemId":"1131","WorkItemTitle":"jh","WorkItemDetails":"ttttttttttttttttttttttttt","WorkItemCreatedBy":"2","WorkItemAssignedTo":"0","WorkItemStatusId":"1","WorkItemPriorityId":"2","EndDate":"4-8-2018","WorkItemProgramId":"1","WorkItemTypeId":"1"
    
   
    
    
    class func editBand(itemId: String, title: String, detail: String, creator: String, assignTo: String, status: String, periority: String, endDate: String, program: String,type: String, catId: String, completion: @escaping (_ error:Error?, _ success:Bool ,_ data:AnyObject?)->Void)
    {
        let url = URLs.EditBand
        let parameters = ["workItemId":itemId, "WorkItemTitle":title, "WorkItemDetails":detail, "WorkItemCreatedBy":creator, "WorkItemAssignedTo":assignTo, "WorkItemStatusId":status, "WorkItemPriorityId":periority, "EndDate":endDate, "WorkItemProgramId":program, "WorkItemTypeId":type, "catId":catId] as [String : AnyObject]
        
        let header = ["Content-Type" : "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    completion(nil,true,value as AnyObject?)
                case.failure(let error):
                    completion(error as NSError?,false,nil)
                }
        }
    }

    
    
    class func changeBand(completion: @escaping(_ error:Error?, _ success:Bool ,_ data:AnyObject?)->Void)
    {
        let url = URLs.changeBand
        let header = ["Content-Type" : "application/json"]

        Alamofire.request(url, method: .get,  encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    completion(nil,true,value as AnyObject?)
                case.failure(let error):
                    completion(error as NSError?,false,nil)
                }
        }
    }
    class func loadChat(itemId: String ,  completion: @escaping(_ error:Error?, _ success:Bool ,_ data:AnyObject?)->Void)
    {
        let url = URLs.chatLoad
        let header = ["Content-Type" : "application/json"]
        let parameters = ["workItemId": itemId] as [String : AnyObject]

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    completion(nil,true,value as AnyObject?)
                case.failure(let error):
                    completion(error as NSError?,false,nil)
                }
        }
    }
    
    class func chaPost(itemId: String , userId: Int , message: String, username: String,  completion: @escaping(_ error:Error?, _ success:Bool ,_ data:AnyObject?)->Void)
    {
        let url = URLs.chatPost
        let header = ["Content-Type" : "application/json"]
        let parameters = ["workItemId": itemId , "UserId": userId , "ChatMessage": message , "username":username ] as [String : AnyObject]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    completion(nil,true,value as AnyObject?)
                case.failure(let error):
                    completion(error as NSError?,false,nil)
                }
        }
    }
    
    
    class func attch(workitemid:String, completion: @escaping(_ error:Error?, _ success:Bool ,_ data:AnyObject?)->Void){
        
        let url = URLs.attach
        let header = ["Content-Type" : "application/json"]
        let parameters = ["workitemid": workitemid] as [String : AnyObject]

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    print(value)
                    completion(nil,true,value as AnyObject?)
                case .failure(let error):
                    completion(error as NSError?,false,nil)
                }
        }
    }


}
