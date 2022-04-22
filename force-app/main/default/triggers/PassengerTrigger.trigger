trigger PassengerTrigger on Passenger__c (after delete, after insert, after update, before delete, before insert, before update) {
    TriggerFactory.createHandler(Passenger__c.sObjectType);
}