@isTest
public class Test_ws_CreateContactIenergy {
     
    static testMethod void testloadContact(){
        
       List<WS_CreateContactIenergy.WSContact> w = new List<WS_CreateContactIenergy.WSContact>();
        WS_CreateContactIenergy.WSContact con = 
            new WS_CreateContactIenergy.WSContact('Natrajan','Siva','vinod.09more@gmail.com','917387987777',false);
        w.add(con);
        
        WS_CreateContactIenergy.WSContact con1 = 
            new WS_CreateContactIenergy.WSContact('Natrajan1','Siva1','vinod.091more@gmail.com','91738798888',false);
        w.add(con1);
       
        
        WS_CreateContactIenergy.loadContact(w);
        Integer cs = [select count() from Contact];
        System.assertEquals(cs,2);
        
        Integer cas = [select count() from Case];
        System.assertEquals(cas,2);
        
        Contact cont = [select Id, FirstName, LastName from Contact where email = 'vinod.091more@gmail.com'];
        
        System.assertEquals(cont.FirstName,'Siva1');
        w.clear();
        system.debug('List Count' + w.size());
        WS_CreateContactIenergy.WSContact con2 = 
            new WS_CreateContactIenergy.WSContact('More1','Vinod1','vinod.0912more@gmail.com','91738798888',false);
        w.add(con2);
        WS_CreateContactIenergy.WSContact con3 = 
            new WS_CreateContactIenergy.WSContact('More','Vinod','vinod.09more@gmail.com','917387987777',false);
        w.add(con3);
        system.debug('List Count' + w.size());
        WS_CreateContactIenergy.loadContact(w);
        Integer cs1 = [select count() from Contact];
        System.assertEquals(cs1,3);
        Contact cont1 = [select Id, FirstName, LastName from Contact where email = 'vinod.09more@gmail.com'];
        
		System.assertEquals(cont1.FirstName,'Vinod');
    }

}