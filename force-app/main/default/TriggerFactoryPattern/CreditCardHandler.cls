/**
* @author       Santiago Fernandez Morillas
* @date         
*               Implements the ITrigger interface to help ensure the trigger code is bulkified and all in one place.
*/
public with sharing class CreditCardHandler implements ITrigger{

    // Var declaration
        User userAccentureTest = [SELECT Id, Name FROM User WHERE Name = 'Accenture TEST'];
    // Constant declaration

    // Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {

    }

    public void beforeInsert(SObject sObj) {

    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {

    }

    public void beforeDelete(SObject sObj) {

    }

    // Handler after methods

    public void bulkAfter() {

    }

    public void afterInsert(SObject sObj) {
        
        Credit_Card__c creditCard = (Credit_Card__c) sObj;

        if (creditCard.OwnerId != userAccentureTest.Id) {
            if (creditCard.Contact__r.Premium__c == true) {
                Opportunity opp = new Opportunity();
                //Year, Month, Day
                Date fecha = Date.newInstance(2022, 8, 20);
                opp.CloseDate = fecha;
                opp.StageName = 'Not started';
                opp.AccountId = creditCard.Contact__r.Account.Id;
                opp.Name = creditCard.Contact__r.Name;
                insert opp;
            }
        }
    }

    public void afterUpdate(SObject oldSobj, SObject sObj) {
        
    }

    public void afterDelete(SObject sObj) {

    }

    /**
    * This method is called once all records have been processed by the trigger.
    * Use this method to accomplish any final operations such as creation or updates of other records.
    */
    public void andFinally() {

    }

    // Other methods
    
}