public class UpdateEmployeesOnTerrytoriService {

    public static void execute(List<Account> listObj) {

        Set<Id> setIdTerritory = new Set<Id>();

        for (Account obj : listObj) {
            setIdTerritory.add(obj.Territory__c);
        }

        List<Territory__c> listTerritory = [SELECT Id, numberOfEmployees__c,             
                                            (SELECT Id, numberOfEmployees__c FROM Accounts__r)        
                                            FROM Territory__c        
                                            WHERE Id In : setIdTerritory];
               
        for (Territory__c terr: listTerritory) {       
            Decimal empl = 0;      
            for (Account acc : terr.Accounts__r) {       
                empl += acc.numberOfEmployees__c;      
            }
            
            terr.numberOfEmployees__c = empl;
        }   
        update listTerritory;

    }
}