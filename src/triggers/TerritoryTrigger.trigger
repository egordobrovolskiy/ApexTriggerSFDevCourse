/**
 * Created by Yehor Dobrovolskyi on 04.10.2018.
 */

trigger TerritoryTrigger on Territory__c (after insert, after update, after delete, after undelete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            UpdateAmountOfEmployeesModelHandler.onInsert(Trigger.new);
        }
        if(Trigger.isUpdate) {
            UpdateAmountOfEmployeesModelHandler.onUpdate(Trigger.oldMap, Trigger.new);
        }
        if (Trigger.isDelete) {
            UpdateAmountOfEmployeesModelHandler.onDelete(Trigger.old);
        }
        if (Trigger.isUndelete) {
            UpdateAmountOfEmployeesModelHandler.onUndelete(Trigger.new);
        }
    }
}