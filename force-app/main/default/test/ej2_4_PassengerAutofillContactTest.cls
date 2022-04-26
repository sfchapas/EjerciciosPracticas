/**
 * Clase de test ejercicio 2.4 (Passenger)
 * Trigger en la entidad ‘Pasajeros’ para rellenar el campo ‘Contacto’
 *  automáticamente, si existe algún contacto en la entidad contact con
 *  el nif igual al introducido en el campo nif de la entidad ‘Pasajeros’.
 *  Al insertar y modificar en la entidad ‘Pasajeros’
 */
@isTest
public with sharing class ej2_4_PassengerAutofillContactTest {
    
    

    public static Passenger__c mock(){

        Flight_Bookings__c fb = new Flight_Bookings__c(
                Name='Test VSC',
                Departure_Date__c = Date.today() +1,
                Origin__c = 'Madrid',
                Destination__c='Roma');
            
        insert fb;

        Contact ctc = new Contact (
                LastName='Test ej2.4', 
                NIF__c='47559507S');
        
        insert ctc;

        Passenger__c passenger = new Passenger__c(
                Name = 'Test ej2.3',
                Booking__c = fb.Id);

        return passenger;
    }

    @isTest static void TestInsertPassengerAutofillContact(){
        Passenger__c passenger =  ej2_4_PassengerAutofillContactTest.mock();
        passenger.ID_Card__c = '47559507S';

        Test.startTest();
        Database.SaveResult result = Database.insert(passenger, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
        
    }

    @isTest static void TestUpdatePassengerAutofillContact(){
        Passenger__c passenger =  ej2_4_PassengerAutofillContactTest.mock();
        insert passenger;

        passenger.ID_Card__c = '47559507S';

        Test.startTest();
        Database.SaveResult result = Database.update(passenger, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');

    }
}
