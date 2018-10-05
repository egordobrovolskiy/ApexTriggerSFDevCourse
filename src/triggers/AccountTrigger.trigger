/**
 * Created by Yehor Dobrovolskyi on 04.10.2018.
 */

trigger AccountTrigger on Account (after insert, after update, after delete, after undelete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate) {
            UpdateAmountOfEmployeesTerritoryHandler.onInsertOrUndelete(Trigger.new);
        }
        if (Trigger.isDelete) {
            UpdateAmountOfEmployeesTerritoryHandler.onDelete(Trigger.old);
        }
    }
}