/**
 * Clase de test ejercicio 1.6 (FlightBookingHandler)
 * Crear un trigger sobre la nueva entidad que se ejecute solo al insertar,
 * y que rellene automáticamente el nombre de la cuenta (Account) si se 
 * rellena el campo del contacto
 */
@isTest
public with sharing class ej1_6_AccountAutofillTriggerTest {
    
    @isTest static void TestFlightBookingWithoutAccount(){

        List<Contact> ctcs = [SELECT Id, Name, AccountId FROM Contact Limit 10];
        Account acct = new Account();

        acct = [SELECT Id FROM Account WHERE Id = :ctcs.get(0).AccountId];    
        

        Flight_Bookings__c fb = new Flight_Bookings__c(
            Name='Test VSC',
            Departure_Date__c = Date.today() +1,
            Origin__c = 'Madrid',
            Destination__c='Roma',
            Contact__c = ctcs.get(0).Id);

        Test.startTest();
        Database.SaveResult result = Database.insert(fb, false);
        Test.stopTest();

        Flight_Bookings__c fb2 = [SELECT Name, Contact__c,  Account__c FROM Flight_Bookings__c WHERE Id = :fb.Id];

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
        System.assertEquals(acct.Id, fb2.Account__c);
    }
}
