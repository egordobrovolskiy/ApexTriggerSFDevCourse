public class UpdateEmployeesOnTerrytoriService {

    public static void updateEmpl(List<Account> listObj) {

        Set<Id> setIdTerritory = new Set<Id>();

        for (Account obj : listObj) {
            setIdTerritory.add(obj.Territory__c);
        }

        List<Territory__c> listTerritory = [SELECT Id, numberOfEmployees__c,
        (SELECT Id, numberOfEmployees__c FROM Accounts__r)
        FROM Territory__c
        WHERE Id In : setIdTerritory];
        AggregateResult[] aggregateResults = [SELECT Territory__c, SUM(numberOfEmployees__c)
        FROM Account
        WHERE Territory__c  IN : setIdTerritory
        GROUP BY Territory__c];

        for (AggregateResult ar: aggregateResults) {
            for (Territory__c terr: listTerritory) {
                if (ar.get('Territory__c') == terr.Id) {
                    terr.numberOfEmployees__c = Integer.valueOf(ar.get('expr0'));
                }
            }
        }
        update listTerritory;

    }
}