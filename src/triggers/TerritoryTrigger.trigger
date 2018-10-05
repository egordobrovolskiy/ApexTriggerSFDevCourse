/**
 * Created by Yehor Dobrovolskyi on 04.10.2018.
 */

trigger TerritoryTrigger on Territory__c (after insert, after update, after delete, after undelete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate) {
            UpdateAmountOfEmployeesModelHandler.onInsertOrUndelete(Trigger.new);
        }
        if (Trigger.isDelete) {
            UpdateAmountOfEmployeesModelHandler.onDelete(Trigger.old);
        }
    }
}