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

        List<Account> listAccounts = new List<Account>();

        for (Account accNew : listAccNew) {
            if (accNew.Territory__c != null) {
                if (mapAccOld.get(accNew.Id).numberOfEmployees__c != accNew.numberOfEmployees__c ||
                        mapAccOld.get(accNew.Id).Territory__c != accNew.Territory__c) {
                    listAccounts.add(accNew);
                }
            }
        }
        Set<Id> result = getIdsTerritory(listAccounts);
        UpdateEmployeesOnTerrytoriService.updateEmpl(result);

    }

    private static Set<Id> getIdsTerritory(List<Account> listObj) {
        Set<Id> result = new Set<Id>();
        for (Account obj : listObj) {
            result.add(obj.Territory__c);
        }
        return result;
    }
    
}