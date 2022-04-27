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
        //No comprobamos si es premium porque los contactos que hemos recogido en la
        //consulta son los premium
        if (creditCard.OwnerId != userAccentureTest.Id) {
            Contact ctc = contactsAssociatedPremium.get(creditCard.Contact__c);
            Opportunity opp = new Opportunity();
            //En layout los campos son required, el if es por si se inserta por código, pruebas...
            if (creditCard.Expiration_Month__c != null && creditCard.Expiration_Year__c != null){
                //Year, Month, Day
                Date fecha = Date.newInstance((Integer)creditCard.Expiration_Year__c, (Integer)creditCard.Expiration_Month__c, 01);
                opp.CloseDate = fecha;
            }else {
                //Si no tuviera fecha la fecha de cierre de un mes
                opp.CloseDate = Date.today() + 30;
            }
            opp.StageName = 'Not started';
            if (creditCard.Contact__c != null) {
                opp.AccountId = ctc.AccountId;
                opp.Name = ctc.Name;    
            }else{
                opp.Name = 'Opp Credit Card Premium';
            }
            listOpportunities.add(opp);
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
        if (listOpportunities.size()>0) {
            insert listOpportunities;    
        }
        
    }

    // Other methods
    
}