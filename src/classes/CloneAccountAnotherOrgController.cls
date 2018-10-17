
public with sharing class CloneAccountAnotherOrgController {

    @AuraEnabled
    public static Account getAccount(Id recordId) {
        return [Select
                Id,
                Name,
                Phone,
                BillingAddress,
                ShippingAddress,
                NumberOfEmployees,
                Website
        From Account
        Where Id = :recordId];
    }

    @AuraEnabled
    public static void cloneAccount(Account account) {
       RemoteAccountCRUD.createAccount(account);
    }
}