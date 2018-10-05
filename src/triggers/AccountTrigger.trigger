/**
 * Created by Yehor Dobrovolskyi on 04.10.2018.
 */

trigger AccountTrigger on Account (after insert, after update, after delete, after undelete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            UpdateAmountOfEmployeesTerritoryHandler.onInsert(Trigger.new);
        }
        if(Trigger.isUpdate) {
            UpdateAmountOfEmployeesTerritoryHandler.onUpdate(Trigger.oldMap, Trigger.new);
        }
        if (Trigger.isDelete) {
            UpdateAmountOfEmployeesTerritoryHandler.onDelete(Trigger.old);
        }
        if (Trigger.isUndelete) {
            UpdateAmountOfEmployeesTerritoryHandler.onUndelete(Trigger.new);
        }
    }
}