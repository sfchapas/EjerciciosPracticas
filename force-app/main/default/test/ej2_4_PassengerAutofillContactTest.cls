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
                ID_Card__c = '47559507S',
                Booking__c = fb.Id);

        return passenger;
    }

    @isTest static void test(){
        //insertar contacto con dni
        //insertar passenger con el mismo dni
        //comprobar que passenger.contact tiene la relacin con el contacto anterior
    }
}
