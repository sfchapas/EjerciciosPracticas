
trigger FlightBookingTrigger on Flight_Bookings__c(after delete, after insert, after update, before delete, before insert, before update) {
    TriggerFactory.createHandler(Flight_Bookings__c.sObjectType);
}