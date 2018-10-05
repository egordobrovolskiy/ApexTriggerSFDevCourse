public class UpdateAmountOfEmployeesTerritoryHandler {
    
    public static void onInsertOrUndelete (List<Account> listObj) {

        UpdateEmployeesOnTerrytoriService.execute(listObj);

    }
    
    public static void onDelete (List<Account> listObjOld) {

        UpdateEmployeesOnTerrytoriService.execute(listObjOld);
    }
    
}