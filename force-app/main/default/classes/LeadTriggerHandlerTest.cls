@isTest
public with sharing class handleTitleNormalizationTest {

    //try put insert DML operation into a Test.start() Test.stop()  !!!!!!!!!!!!!!!!!!!!
    //no just do not do DML operation at all !!!! when you wanto test onle a methods not the trigger !!!!!!!!!!!!!!
    @isTest
    private static void handleTitleNormalization_for_vp_VicePresident_expected(){

        List<Lead> listOfLeds = new List<Lead>();
        Lead lead = new Lead(Title = 'vp', LastName = 'TestLastName', Company = 'TestCompanyName');
        listOfLeds.add(lead);

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        Lead myLead = listOfLeds[0];
        System.Assert.areEqual('Vice President', myLead.Title,'Expected Title is Vice President');
    }

    private static String strinGenerate(Set<String>setOfString){
        List<String> myList = new List<String>(setOfString);
        String randomString = '';

        if (!myList.isEmpty()) { 
            Integer randomIndex = (Integer) (Math.random() * myList.size());
            randomString = myList.get(randomIndex);
            }
            return randomString;
    }

    @isTest
    private static void handleTitleNormalization_checkVicePresident_expectedSucces(){
        Set<String> myString = new Set<String>{'vp', 'v.p.', 'vice president'};
        List<Lead> listOfLeds = new List<Lead>();
        for(Integer i = 0; i < 100; i++){
            //String s = randomString;
            listOfLeds.add(new Lead(Title = strinGenerate(myString), LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        //insert listOfLeds;

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title FROM Lead];
        for(Lead lead : listOfLeadsAfterUpdate){
            System.assertEquals('Vice President', lead.Title, 'The expected result is the Vice President');
        }
    }

    @isTest
    private static void handleTitleNormalization_checkManager_expectedSucces(){
        Set<String> myString = new Set<String>{'mgr', 'manage', 'head of department'};

        List<Lead> listOfLeds = new List<Lead>();
        for(Integer i = 0; i < 100; i++){
            listOfLeds.add(new Lead(Title = strinGenerate(myString), LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        //insert listOfLeds;

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title FROM Lead];
        for(Lead lead : listOfLeadsAfterUpdate){
            System.assertEquals('Manager', lead.Title, 'The expected result is the Manager');
        }
    }

    @isTest
    private static void handleTitleNormalization_checkExecutive_expectedSucces(){
        Set<String> myString = new Set<String>{'exec', 'chief', 'head'};

        List<Lead> listOfLeds = new List<Lead>();
        for(Integer i = 0; i < 100; i++){
            listOfLeds.add(new Lead(Title = strinGenerate(myString), LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        //insert listOfLeds;

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title FROM Lead];
        for(Lead lead : listOfLeadsAfterUpdate){
            System.assertEquals('Executive', lead.Title, 'The expected result is the Executive');
        }
    }

    @isTest
    private static void handleTitleNormalization_checkAssistant_expectedSucces(){
        Set<String> myString = new Set<String>{'assist', 'deputy', 'jr'}; 

        List<Lead> listOfLeds = new List<Lead>();
        for(Integer i = 0; i < 100; i++){
            listOfLeds.add(new Lead(Title = strinGenerate(myString), LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        //insert listOfLeds;

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title FROM Lead];
        for(Lead lead : listOfLeadsAfterUpdate){
            System.assertEquals('Assistant', lead.Title, 'The expected result is the Assistant');
        }
    }

    @isTest
    private static void handleAutoLeadScoring_check0_expexted0(){
        List<Lead> listOfLeads = new List<Lead>();

        for(Integer i = 0; i < 100; i++){
            listOfLeads.add(new Lead(Title = 'TestTitle'+ i, LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        //insert listOfLeads;

        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(listOfLeads);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title, Lead_Score__c FROM Lead];
        for(Lead l : listOfLeadsAfterUpdate){
            System.Assert.areEqual(0, l.Lead_Score__c, 'Score shoould be 0');
        }
    }

    @isTest
    private static void handleAutoLeadScoring_checkIfAll_expexted18(){
        List<Lead> listOfLeads = new List<Lead>();

        Lead lead = new Lead(Status = 'Open - Not Contacted', Phone = '(415) 555-1234', Email = 'salesTest@gmail.com', 
        LeadSource = 'Website', Title = 'TestTitle', LastName = 'TestLastName', Company = 'TestCompanyName', Industry = 'Technology');
        listOfLeads.add(lead);
    
        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(listOfLeads);
        Test.stopTest();

        List<Lead> listOfLeadsAfterInsert = [SELECT Id, Title, Lead_Score__c FROM Lead];
        for(Lead leads : listOfLeadsAfterInsert){
            System.Assert.areEqual(18, leads.Lead_Score__c, 'Score should be 18');
        }
    }

    @isTest
    private static void handleAutoLeadScoring_checkLeadSourceIsPhone_expexted15(){
        List<Lead> listOfLead = new List<Lead>();

        Lead lead = new Lead(Status = 'Open - Not Contacted', Phone = '(415) 555-1234', Email = 'salesTest@gmail.com', 
        LeadSource = 'Phone', Title = 'TestTitle', LastName = 'TestLastName', Company = 'TestCompanyName', Industry = 'Technology');
        listOfLead.add(lead);

        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(listOfLead);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title, Lead_Score__c FROM Lead];
        for(Lead l : listOfLeadsAfterUpdate){
            System.Assert.areEqual(15, l.Lead_Score__c, 'Score should be 15');
        }
    }

    @isTest
    private static void handleAutoLeadScoring_checkLeadSourceIsOther_PhoneIsNull_expexted10(){
        List<Lead> listOfLead = new List<Lead>();

        Lead lead = new Lead(Status = 'Open - Not Contacted', Email = 'salesTest@gmail.com', 
        LeadSource = 'Other', Title = 'TestTitle', LastName = 'TestLastName', Company = 'TestCompanyName', Industry = 'Technology');
        listOfLead.add(lead);

        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(listOfLead);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title, Lead_Score__c FROM Lead];
        for(Lead l : listOfLeadsAfterUpdate){
            System.Assert.areEqual(10, l.Lead_Score__c);
        }
    }

    @isTest
    private static void handleLeadAutoConvert_checkLeadIsCreated_ExpectedSucces(){

        Contact testContact = new Contact(LastName = 'testName', Email = 'salesTest1@gmail.com', AccountId = null);
        insert testContact;
        System.debug('Here is a testContact ::::'+ testContact);

        List<Lead> listOfLead = new List<Lead>();

        Lead lead = new Lead(Status = 'Open - Not Contacted', Email = 'salesTest1@gmail.com', 
        LeadSource = 'Other', Title = 'TestTitle', LastName = 'New_Lead_Test', Company = 'TestCompanyName', Industry = 'Technology');

        Lead lead1 = new Lead(Status = 'Open - Not Contacted', Email = 'salesTest2@gmail.com', 
        LeadSource = 'Other', Title = 'TestTitle1', LastName = 'New_Lead_Test1', Company = 'TestCompanyName1', Industry = 'null');


        System.debug('Here is a list of  Leads ::::'+ listOfLead);
        listOfLead.add(lead);
        listOfLead.add(lead1);
        insert listOfLead;
        //insert new List<Lead>{lead, lead1};
        //insert new List<Lead>{listOfLead};
      
        Test.startTest();
        LeadTriggerHandler.handleLeadAutoConvert(listOfLead);
        Test.stopTest();

         // Query the CONTACT, not the Lead, after conversion
         Contact convertedContact = [SELECT Id, Email, LastName FROM Contact WHERE Email = :lead.Email LIMIT 1];

         System.assertNotEquals(null, convertedContact.Id, 'Contact ID should not be null');
         System.assertEquals(lead.Email, convertedContact.Email, 'Email should match');
         System.assertEquals(lead.LastName, convertedContact.LastName, 'Last Name should match'); // Or whatever fields you're merging
 
         // Assertions for the Lead that should *not* be converted:
         List<Lead> notConvertedLeads = [SELECT Id, Status, IsConverted FROM Lead WHERE Email = :lead1.Email];
         System.assertEquals(1, notConvertedLeads.size(), 'Should be one unconverted lead');
         Lead notConvertedLead = notConvertedLeads[0]; // Get the Lead from the list
         System.assertEquals(false, notConvertedLead.IsConverted, 'Lead should not be converted');
         System.assertEquals('Open - Not Contacted', notConvertedLead.Status, 'Status should remain unchanged');

        //Lead convertedLead = [SELECT Id, Status, IsConverted, Lead_Score__c FROM Lead WHERE Id =: lead.Id LIMIT 1];

        //System.assertEquals(true, convertedLead.IsConverted);
        //System.Assert.areEqual('Converted', convertedLead.Status);
    }
}