@isTest
public with sharing class LeadTriggerHandlerTest {

    @isTest
    private static void handleTitleNormalization_for_vp_VicePresident_expected(){

        List<Lead> listOfLeds = new List<Lead>();
        Lead lead = new Lead(Title = 'vp', LastName = 'TestLastName', Company = 'TestCompanyName');
        listOfLeds.add(lead);

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();
        System.debug('Show me a list ' + listOfLeds);//shows 'Vice President'!

        Lead myLead = listOfLeds[0];
        Assert.areEqual('Vice President', myLead.Title,'Expected Title is Vice President');
    }

    @isTest
    private static void leadtrigger_Insert_handleTitleNormalization(){

        List<Lead> listOfLeds = new List<Lead>();
        Lead lead = new Lead(Title = 'vp', LastName = 'TestLastName', Company = 'TestCompanyName', FirstName = 'FirstNameTest');
        listOfLeds.add(lead);

        Test.startTest();
        insert listOfLeds;
        Test.stopTest();

        Lead leadAfterInsert = [SELECT Id, Title FROM Lead WHERE Id = :lead.Id];
        System.debug('Show me a list ' + listOfLeds);//shows 'vp'
        Assert.areEqual('Vice President', leadAfterInsert.Title, 'Expected Title is Vice President');
    }

    @isTest
    private static void handleTitleNormalization_for_vp_mgr_exec_assist(){

        List<Lead> listOfLeds = new List<Lead>();
        listOfLeds.add(new Lead(Title = 'vp', LastName = 'TestLastName', Company = 'TestCompanyName'));
        listOfLeds.add(new Lead(Title = 'mgr', LastName = 'TestLastName', Company = 'TestCompanyName'));
        listOfLeds.add(new Lead(Title = 'exec', LastName = 'TestLastName', Company = 'TestCompanyName'));
        listOfLeds.add(new Lead(Title = 'assist', LastName = 'TestLastName', Company = 'TestCompanyName'));
        
        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(listOfLeds);
        Test.stopTest();
        System.debug('Show me a list ' + listOfLeds);//shows 'Vice President'!

        Lead myLead = listOfLeds[0];
        Assert.areEqual('Vice President', myLead.Title,'Expected Title is Vice President');
        Lead mayLead1 = listOfLeds[1];
        Assert.areEqual('Manager', mayLead1.Title,'Expected Title is Manager');
        Lead mayLead2 = listOfLeds[2];
        Assert.areEqual('Executive', mayLead2.Title,'Expected Title is Executive');
        Lead myLead3 = listOfLeds[3];
        Assert.areEqual('Assistant', myLead3.Title,'Expected Title is Assistant');
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
}