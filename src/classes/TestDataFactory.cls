@isTest
public class TestDataFactory {

    public static List<TerritoryModel__c> createTerritoryModelWithTerritoryAndAccount(Integer numTerrMod, Integer numTerr, Integer numAcc) {     
       
        List<TerritoryModel__c> listTerrMod = new  List<TerritoryModel__c>();
        for (Integer i = 0; i < numTerrMod; i++) {
            listTerrMod.add(new TerritoryModel__c(Name = 'Test TerritoryModel ' + i,
                                                 numberOfEmployees__c = 0));
        }
        insert listTerrMod;
        System.debug('TestDataFactory listTerrMod');
        System.debug(listTerrMod);
        
        List<Territory__c> listTerr = new List<Territory__c>();
        for (Integer i = 0; i < numTerrMod; i++) {
            TerritoryModel__c terrMod = listTerrMod[i];
            
            for (Integer j = 0; j < numTerr; j++) {
                listTerr.add(new Territory__c(Name = terrMod.Name + ' ==> Territory ' + j,
                                             TerritoryModel__c = terrMod.Id,
                                             numberOfEmployees__c = 0));
            }
        }
        insert listTerr;
        System.debug('TestDataFactory listTerr');
        System.debug(listTerr);
        
        List<Account> listAcc = new List<Account>();
        for (Integer i = 0; i < numTerr; i++) {
            Territory__c terr = listTerr[i];
            
            for (Integer j = 0; j < numAcc; j++) {
                listAcc.add(new Account(Name = terr.Name + ' ==> Account ' + j,
                                       Territory__c = terr.Id,
                                       numberOfEmployees__c = j + 1));
            }
        }
        
        insert listAcc;
        System.debug('TestDataFactory listAcc');
        System.debug(listAcc);
        
        System.debug('Test data - return list');
        System.debug(listTerrMod);
        return listTerrMod;        
    }
}