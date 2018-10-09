public class UpdateEmployeesOnTerrytoriService {

    public static void updateEmpl(Set<Id> setIdTerritory) {

        Map<Id, Territory__c> mapTerritory = new Map<Id, Territory__c>([
                SELECT Id, numberOfEmployees__c
                FROM Territory__c
                WHERE Id In :setIdTerritory
        ]);

        AggregateResult[] aggregateResults = [
                SELECT Territory__c, SUM(numberOfEmployees__c)
                FROM Account
                WHERE Territory__c IN :setIdTerritory
                GROUP BY Territory__c
        ];

        updateTerritory(mapTerritory, aggregateResults);


        update mapTerritory.values();

    }



    private static void updateTerritory(Map<Id, Territory__c> mapTerritory, List<AggregateResult> aggregateResults) {
        for (AggregateResult ar : aggregateResults) {
            Id terrId =(Id) ar.get('Territory__c');
            Territory__c terr = mapTerritory.get(terrId);
            terr.numberOfEmployees__c = Integer.valueOf(ar.get('expr0'));
        }
    }
}