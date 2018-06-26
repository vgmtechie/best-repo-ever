global class WS_CreateContactIenergy{

    webService static WS_Response loadContact(List<WSContact> wscon){
    
    WS_Response obj = new WS_Response();
    List<Contact> insertContactList = new List<Contact>();
    List<Contact> updateContactList = new List<Contact>();    
    List<Case> createCaseList = new List<Case>();
    List<string> wseEmailsList = new List<string>();
    Map<string,contact> existingContactMap = new Map<string, contact>();
    try{
    
    for(WSContact wsc : wscon){
    
    wseEmailsList.add(wsc.email);
    
    }
    for(Contact con : [select Email, Id, LastName, FirstName, Phone, AccountId 
                       from Contact where Email IN : wseEmailsList]){
    if(!existingContactMap.ContainsKey(con.email)){
        existingContactMap.put(con.email, con);
        }
    }
    for(WSContact ws: wscon){
    
    if(existingContactMap.ContainsKey(ws.email)){
    
    existingContactMap.get(ws.email).LastName = ws.lastName;
    system.debug('Last Name ' + existingContactMap.get(ws.email).LastName);
    existingContactMap.get(ws.email).FirstName = ws.firstName;
    system.debug('First Name ' + existingContactMap.get(ws.email).FirstName);
    existingContactMap.get(ws.email).Phone = ws.phone;
    existingContactMap.get(ws.email).AccountId = null;
    updateContactList.add(existingContactMap.get(ws.email));
    }
    else{
    Contact newContact = new Contact(
    LastName = ws.lastName,
    FirstName = ws.firstName,
    Phone = ws.phone,
    Email = ws.email,
    AccountId = null);
        
    insertContactList.add(newContact);
    }
    
    }
    system.debug('Update List ' + updateContactList.size());
    if(updateContactList.size()>0){
    update updateContactList;
    }
    system.debug('Insert List ' + insertContactList.size());
    if(insertContactList.size()>0){
    Insert insertContactList;
    
    for(Contact c: insertContactList){
        Case cs = new Case(
        ContactId = c.id,
        AccountId = c.AccountId);
        createCaseList.add(cs);
    }
    WC_CreateCaseIenergy(createCaseList);
    
    }
    obj.status = 200;
    obj.Message = 'Process Successfull';
    }
    catch(exception e){
    obj.status = 500;
    obj.Message = e.getMessage();
    }
    
    return obj;
    }
    
    private static List<Case> WC_CreateCaseIenergy(List<Case> createCaseList){
    Insert createCaseList;
    return createCaseList;
    }
    global class WSContact{
        webService string lastName;
        webService string firstName;
        webService string email;
        webService string phone;
        webService Boolean isExternal;
        public WSContact(string lastName, string firstName, string email, string phone, boolean isExternal){

        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.phone = phone;
        this.isExternal= isExternal;

        }

    }
    global class WS_Response{
    
    Integer status;
    string Message;
    }
    

}