@isTest
public with sharing class handleTitleNormalizationTest {

    @isTest
    private static void handleTitleNormalization_for_vp_VicePresident_expected(){

        List<Lead> listOfLeds = new List<Lead>();
        listOfLeds.add(new Lead(Title = 'vp', LastName = 'TestLastName', Company = 'TestCompanyName'));

        insert listOfLeds;

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title FROM Lead];
        System.assertEquals(listOfLeadsAfterUpdate[0].Title, 'Vice President', 'Expected Vice President');
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
        insert listOfLeds;

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
        insert listOfLeds;

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
        //('exec') || ld.title == 'chief' || ld.title.contains('head')

        List<Lead> listOfLeds = new List<Lead>();
        for(Integer i = 0; i < 100; i++){
            listOfLeds.add(new Lead(Title = strinGenerate(myString), LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        insert listOfLeds;

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
        //(ld.title.contains('assist') || ld.title.contains('deputy') || ld.title == 'jr') 

        List<Lead> listOfLeds = new List<Lead>();
        for(Integer i = 0; i < 100; i++){
            listOfLeds.add(new Lead(Title = strinGenerate(myString), LastName = 'TestLastName' + i, Company = 'TestCompanyName' + i));
        }
        insert listOfLeds;

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title FROM Lead];
        for(Lead lead : listOfLeadsAfterUpdate){
            System.assertEquals('Assistant', lead.Title, 'The expected result is the Assistant');
        }
    }

    @isTest
    private static void handleAutoLeadScoring_checkAll_expexted18(){
        List<Lead> listOfLead = new List<Lead>();

        Lead lead = new Lead(Status = 'Open - Not Contacted', Phone = '1111111111', Email = 'salesTest@gmail.com', 
        LeadSource = 'Website', Title = 'TestTitle', LastName = 'TestLastName', Company = 'TestCompanyName', Industry = 'Technology');
        listOfLead.add(lead);
        insert listOfLead;

        Test.startTest();
        LeadTriggerHandler.handleAutoLeadScoring(listOfLead);
        Test.stopTest();

        List<Lead> listOfLeadsAfterUpdate = [SELECT Id, Title, Lead_Score__c FROM Lead];
        for(Lead l : listOfLeadsAfterUpdate){
            System.Assert.areEqual(18, l.Lead_Score__c);
        }
    }
}