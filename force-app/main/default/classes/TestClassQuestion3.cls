@isTest
public with sharing class TestClassQuestion3 {

    @isTest
    private static void handleLeadAutoConvert_HappyPath(){
        //given
        Lead lead = new Lead(FirstName = 'FirstTestName', LastName = 'TestLastName', Company = 'TestCompanyName', Email = 'rinepem137@shouxs.com');
        List<Lead> listofLead = new List<Lead>();
        listofLead.add(lead);

        //act
        Test.startTest();
        insert listofLead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id];
        System.debug('Lead after insert :::::'+leadAfterInsert);

        // List<Account> accList = [SELECT Id, Name FROM Account];
        // System.Assert.areEqual(1, accList.size());   
    }

    @isTest
    private static void trigger_Insert_handleTitleNormalization(){

        List<Lead> listOfLeds = new List<Lead>();
        Lead lead = new Lead(Title = 'vp', LastName = 'TestLastName', Company = 'TestCompanyName', FirstName = 'FirstNameTest');
        listOfLeds.add(lead);

        Test.startTest();
        insert listOfLeds;
        Test.stopTest();

        Lead myLead = listOfLeds[0];
        System.debug('Show me a lead list::::' +listOfLeds);
        System.Assert.areEqual('Vice President', myLead.Title,'Expected Title is Vice President');
    }
}