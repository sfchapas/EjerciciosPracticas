/**
* @author       Santiago Fernandez Morillas
* @date         
*               Implements the ITrigger interface to help ensure the trigger code is bulkified and all in one place.
*/
public with sharing class FlightBookingHandler implements ITrigger{

    // Var declaration
    List<Id> contactsId = new List<Id>();
    Map<Id,Contact> contactsAssociates;
    // Constant declaration

    // Builder

    // Handler before methods

    /**
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
    */
    public void bulkBefore() {

        for (SObject flightBooking : Trigger.new) {
            contactsId.add(((Flight_Bookings__c)flightBooking).Contact__c);
        }
        if (contactsId.size() > 0) {
            contactsAssociates = new Map<Id,Contact>([SELECT Id, Name, AccountId FROM Contact WHERE Id in :contactsId]);
        }

    }

    public void beforeInsert(SObject sObj) {

        Flight_Bookings__c instance = (Flight_Bookings__c) sObj;
        if ((instance.Account__c == null || instance.Account__c == '') && (instance.Contact__c != null || instance.Contact__c != '')) {
            Contact ctc = contactsAssociates.get(instance.Contact__c);
            instance.Account__c = ctc.AccountId;
        }

    }

    public void beforeUpdate(SObject oldSobj, SObject sObj) {

        Flight_Bookings__c instance = (Flight_Bookings__c) sObj;
        Flight_Bookings__c instanceOld = (Flight_Bookings__c) oldSobj;
        
        if((instanceOld.Origin__c != instance.Origin__c) || (instanceOld.Destination__c != instance.Destination__c) ){
            instance.Modified__c = true;
        }

    }

    public void beforeDelete(SObject sObj) {

    }

    // Handler after methods

    public void bulkAfter() {

    }

    public void afterInsert(SObject sObj) {

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