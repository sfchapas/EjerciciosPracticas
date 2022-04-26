/**
 * Clase de test ejercicio 1.7 (FlightBookinkgHandler)
 * Crear un trigger que se ejecute al modificar. Si se cambia el campo 
 * ‘Origin’ o el campo ‘Destination’ que marque el check ‘Modified’
 */
@isTest
public with sharing class ej1_7_OriginDestinationModifiedTest {
    
    @isTest static void TestChangeOrigin(){
        
        Flight_Bookings__c fb = new Flight_Bookings__c(
            Name='Test VSC',
            Departure_Date__c = Date.today() +1,
            Origin__c = 'Madrid',
            Destination__c='Roma');

        insert fb;

        fb.Destination__c = 'Miami';

        Test.startTest();
        Database.SaveResult result = Database.update(fb, false);
        Test.stopTest();

        Flight_Bookings__c fb2 = [SELECT Name, Modified__c FROM Flight_Bookings__c WHERE Id = :result.getId()];
        
        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
        System.assertEquals(true, fb2.Modified__c);
    }


}

