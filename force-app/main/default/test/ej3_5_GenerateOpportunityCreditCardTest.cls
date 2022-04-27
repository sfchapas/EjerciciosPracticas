/**
 * Clase de test ejercicio 3.5 (Credit Card)
 * Trigger en la entidad ‘Credit Card’: Cuando se guarde una Tarjeta de crédito con
 *  el campo owner “not equal” a "Accenture TEST". Si el campo Contacto asociado a
 *  dicha tarjeta tiene el campo Premium = True, crear una oportunidad (Opportunity)
 *  con los siguientes campos:
 *      CloseDate = 01 - Expiration Month - Expiration Year
 *      StageName = 'Not started';
 *      Account Name = Account asociada al contacto de la tarjeta de crédito
 *      Name = Nombre del contacto de la tarjeta de crédito
 */
@isTest
public with sharing class ej3_5_GenerateOpportunityCreditCardTest {

    @isTest static void TestInsertCreditCard(){
        //crear contacto premium 
        Contact ctc = new Contact (
                LastName='Test ej3.5', 
                NIF__c='47559507S',
                Premium__c = true);
        insert ctc;

        Credit_Card__c creditCard = new Credit_Card__c(
                Name='Test ej3.5'
        );

        //crear la tarjeta de credito con el contacto asociado y insertarla (test)
        Test.startTest();
        Database.SaveResult result = Database.insert(creditCard, false);
        Test.stopTest();

        //comprobar que se ha creado la oportunidad
        String nombre = 'Opp Credit Card Premium';
        Opportunity opp = [SELECT Id, Name FROM Opportunity WHERE Name = 'Opp Credit Card Premium'];
        System.assert(result.isSuccess());
        System.assertEquals(nombre, opp.Name);

    }

    
}
