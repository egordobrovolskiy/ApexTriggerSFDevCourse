public class UpdateAmountOfEmployeesTerritoryHandler {
    
    public static void onInsert (List<Account> listObj) {

        UpdateEmployeesOnTerrytoriService.updateEmpl(listObj);

    }
    
    public static void onDelete (List<Account> listObjOld) {

        UpdateEmployeesOnTerrytoriService.updateEmpl(listObjOld);

    }

    public static void onUndelete(List<Account> listObj) {

        UpdateEmployeesOnTerrytoriService.updateEmpl(listObj);

    }

    public static void onUpdate(Map<Id, Account> mapAccOld, List<Account> listAccNew) {

        List<Account> listAccounts = new List<Account>();

        for (Account accNew : listAccNew) {
            if (mapAccOld.get(accNew.Id).numberOfEmployees__c != accNew.numberOfEmployees__c ||
                    mapAccOld.get(accNew.Id).Territory__c != accNew.Territory__c ) {
                listAccounts.add(accNew);
            }
        }
        UpdateEmployeesOnTerrytoriService.updateEmpl(listAccounts);

    }
    
}