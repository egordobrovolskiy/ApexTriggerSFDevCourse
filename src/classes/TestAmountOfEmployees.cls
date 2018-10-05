@isTest
public class TestAmountOfEmployees {

    @isTest
    static void TestChangeNumberOfEmployeesAccount(){
        Test.startTest();
        TerritoryModel__c[] terrMods = TestDataFactory.createTerritoryModelWithTerritoryAndAccount(1, 2, 6);
        System.debug('List from TestDataFactory');
        System.debug(terrMods);
        
        TerritoryModel__c[] testBefore = [SELECT Id, numberOfEmployees__c
                , (SELECT Id FROM Territories__r) FROM TerritoryModel__c WHERE Id IN :new Map<Id, TerritoryModel__c>(terrMods).keySet() ];
        Decimal beforeChange = testBefore[0].numberOfEmployees__c;
        System.debug(beforeChange); 
      

      
        Territory__c[] accs = [SELECT Id, numberOfEmployees__c
                , (SELECT Id, numberOfEmployees__c FROM Accounts__r) FROM Territory__c WHERE Id IN :new Map<Id, Territory__c>(testBefore[0].Territories__r).keySet()];
        System.debug('Test method Account');
        Account acc = accs[0].Accounts__r[0];
        
        System.debug(acc);
        
        acc.numberOfEmployees__c += 5;
       
        update acc;
        System.debug('Update Account ' + acc);
       
        Test.stopTest();
        
         TerritoryModel__c[] tersAfter = [SELECT numberOfEmployees__c FROM TerritoryModel__c];
        Decimal afterChange = tersAfter[0].numberOfEmployees__c;
        System.debug(afterChange); 
        
        System.assertEquals(beforeChange + 5, afterChange);
    }
}