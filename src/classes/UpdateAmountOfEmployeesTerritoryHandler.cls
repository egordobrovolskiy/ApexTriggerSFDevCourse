public class UpdateAmountOfEmployeesTerritoryHandler {
    
    public static void onInsert (List<Account> listObj) {

        Set<Id> result = getIdsTerritory(listObj);
        UpdateEmployeesOnTerrytoriService.updateEmpl(result);

    }
    
    public static void onDelete (List<Account> listObjOld) {

        Set<Id> result = getIdsTerritory(listObjOld);
        UpdateEmployeesOnTerrytoriService.updateEmpl(result);

    }

    public static void onUndelete(List<Account> listObj) {

        Set<Id> result = getIdsTerritory(listObj);
        UpdateEmployeesOnTerrytoriService.updateEmpl(result);

    }

    public static void onUpdate(Map<Id, Account> mapAccOld, List<Account> listAccNew) {
        Set<Id> setIdsTerr = new Set<Id>();

        for (Account accNew : listAccNew) {
            if (accNew.Territory__c != null) {
                if (mapAccOld.get(accNew.Id).numberOfEmployees__c != accNew.numberOfEmployees__c ||
                        mapAccOld.get(accNew.Id).Territory__c != accNew.Territory__c) {
                    setIdsTerr.add(accNew.Territory__c);
                }
            } else {
                if (mapAccOld.get(accNew.Id).Territory__c != null) {
                    setIdsTerr.add(mapAccOld.get(accNew.Id).Territory__c);
                }
            }
        }
        UpdateEmployeesOnTerrytoriService.updateEmpl(setIdsTerr);

    }

    private static Set<Id> getIdsTerritory(List<Account> listObj) {
        Set<Id> result = new Set<Id>();
        for (Account obj : listObj) {
            result.add(obj.Territory__c);
        }
        return result;
    }
    
}