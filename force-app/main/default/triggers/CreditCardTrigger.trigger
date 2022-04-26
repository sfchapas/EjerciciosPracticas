trigger CreditCardTrigger on Credit_Card__c (after delete, after insert, after update, before delete, before insert, before update) {
    TriggerFactory.createHandler(Credit_Card__c.sObjectType);
}