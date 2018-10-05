public class UpdateEmployeesOnModelService {

    public static void updateEmpl(List<Territory__c> listObj) {

        Set<Id> setIdTerritoryModel = new Set<Id>();
        for (Territory__c obj : listObj) {
            setIdTerritoryModel.add(obj.TerritoryModel__c);
        }

        List<TerritoryModel__c> listTerritoryModel = [SELECT Id, numberOfEmployees__c,        
                                                      (SELECT Id, numberOfEmployees__c FROM Territories__r)       
                                                      FROM TerritoryModel__c        	
                                                      WHERE Id In : setIdTerritoryModel];
        

   
        for (TerritoryModel__c terrMod: listTerritoryModel) {  
            Decimal empl = 0;  
            for (Territory__c terr : terrMod.Territories__r) {
                empl += terr.numberOfEmployees__c;
            }   
            terrMod.numberOfEmployees__c = empl;
        }   
     
        System.debug(listTerritoryModel);
        update listTerritoryModel;    
    }
}