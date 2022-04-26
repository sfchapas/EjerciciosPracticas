/**
 * Clase de test ejercicio 2.3 (Contacts, Passengers)
 * Validar el NIF al guardar mediante trigger tanto en la entidad
 *  ‘Contactos’ como en ‘Pasajeros’, al insertar y modificar
 */
@isTest
public with sharing class ej2_3_ValidarNIFTriggerTest {

    public static SObject mock(String objType){
        Flight_Bookings__c fb = new Flight_Bookings__c(
                Name='Test VSC',
                Departure_Date__c = Date.today() +1,
                Origin__c = 'Madrid',
                Destination__c='Roma');
            
        Database.insert(fb);

        Contact ctcNIFok = new Contact (
                LastName='Test ej2.3', 
                NIF__c='47559507S');

        Passenger__c pssgNIFok = new Passenger__c(
                Name = 'Test ej2.3',
                ID_Card__c = '47559507S',
                Booking__c = fb.Id);

        if (objType == 'c') {
            return ctcNIFok;
        }else if(objType == 'p'){
            return pssgNIFok;
        }else {
            return null;
        }

    }
    

    @isTest static void TestInsertContactNIF(){
        Contact ctcNIFok= (Contact)ej2_3_ValidarNIFTriggerTest.mock('c');

        Test.startTest();
        Database.SaveResult result = Database.insert(ctcNIFok, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
    }   

    @isTest static void TestUpdateContactNIF(){
        Contact ctcNIFok= (Contact)ej2_3_ValidarNIFTriggerTest.mock('c');

        insert ctcNIFok;

        ctcNIFok.NIF__c = '47559508Q';

        Test.startTest();
        Database.SaveResult result = Database.update(ctcNIFok, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
    }


    @isTest static void TestInsertPassengerNIF(){
        Passenger__c pssgNIFok = (Passenger__c)ej2_3_ValidarNIFTriggerTest.mock('p');

        Test.startTest();
        Database.SaveResult result = Database.insert(pssgNIFok, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
    }

    @isTest static void TestUpdatePassengerNIF(){
        Passenger__c pssgNIFok = (Passenger__c)ej2_3_ValidarNIFTriggerTest.mock('p');

        insert pssgNIFok;

        pssgNIFok.ID_Card__c = '47559508Q';

        Test.startTest();
        Database.SaveResult result = Database.update(pssgNIFok, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'El test se ejecutó correctamente');
    }
}
