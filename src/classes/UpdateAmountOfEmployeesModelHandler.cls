public class UpdateAmountOfEmployeesModelHandler {

    public static void onInsertOrUndelete (List<Territory__c> listObj) {

        UpdateEmployeesOnModelService.execute(listObj);
    }
    
    public static void onDelete (List<Territory__c> listObjOld) {

        UpdateEmployeesOnModelService.execute(listObjOld);
    }
}