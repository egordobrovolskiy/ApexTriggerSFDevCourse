public class UpdateAmountOfEmployeesModelHandler {

    public static void onInsert (List<Territory__c> listObj) {

        UpdateEmployeesOnModelService.updateEmpl(listObj);

    }

    public static void onDelete (List<Territory__c> listObjOld) {

        UpdateEmployeesOnModelService.updateEmpl(listObjOld);

    }

    public static void onUndelete(List<Territory__c> listObj) {

        UpdateEmployeesOnModelService.updateEmpl(listObj);

    }

    public static void onUpdate(Map<Id, Territory__c> mapTerrOld, List<Territory__c> listTerrNew) {

        List<Territory__c> listIdTerritory = new List<Territory__c>();

        for (Territory__c terrNew : listTerrNew) {
            if (mapTerrOld.get(terrNew.Id).numberOfEmployees__c != terrNew.numberOfEmployees__c ||
                    mapTerrOld.get(terrNew.Id).TerritoryModel__c != terrNew.TerritoryModel__c  ) {
                listIdTerritory.add(terrNew);
            }
        }
        UpdateEmployeesOnModelService.updateEmpl(listIdTerritory);

    }
}