/**
* @author       Santiago Fernandez Morillas
* @date         
*               Implements the ITrigger interface to help ensure the trigger code is bulkified and all in one place.
*/
public with sharing class CreditCardHandler implements ITrigger{

    // Var declaration
    User userAccentureTest;
    List<Id> contactsId = new List<Id>();
    Map<Id, Contact> contactsAssociatedPremium;
    List<Opportunity> listOpportunities = new List<Opportunity>();
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
        userAccentureTest = [SELECT Id, Name FROM User WHERE Name = 'Accenture TEST'];
    
        for (SObject creditCard : Trigger.new) {
            contactsId.add(((Credit_Card__c)creditCard).Contact__c);
            System.debug(contactsId.size() + ' Tamaño contactsId');
        }

        if (contactsId.size() > 0) {
            contactsAssociatedPremium = new Map<Id,Contact>([SELECT Id, Name, AccountId, Premium__c FROM Contact WHERE Id in :contactsId AND Premium__c = true]);
            System.debug(contactsAssociatedPremium.size() + ' Tamaño contactsAssociatedPremium');
            
        }
    }

    public void afterInsert(SObject sObj) {
        
        Credit_Card__c creditCard = (Credit_Card__c) sObj;
        System.debug('ENTRAAAAAAA');
        //Probado y hasta aquí entra pero no funciona
        if (creditCard.OwnerId != userAccentureTest.Id) {
            Contact ctc = contactsAssociatedPremium.get(creditCard.Contact__c);
            if (ctc.Premium__c) {
                Opportunity opp = new Opportunity();
                //Year, Month, Day
                Date fecha = Date.newInstance(2022, 8, 20);
                opp.CloseDate = fecha;
                opp.StageName = 'Not started';
                opp.AccountId = ctc.AccountId;
                opp.Name = ctc.Name;
                listOpportunities.add(opp);
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
        insert listOpportunities;
    }

    // Other methods
    
}