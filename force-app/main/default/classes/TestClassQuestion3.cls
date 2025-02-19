@isTest
public with sharing class TestClassQuestion3 {

    @isTest
    private static void handleLeadAutoConvert_HappyPath(){
  
        //given
        Account acc = TestDataFactory.createAccount('testName');
        insert acc;

        Contact con = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname', 'Lname');
        
        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);

        //act
        Test.startTest();
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id LIMIT 1];
        Assert.isTrue(leadAfterInsert.IsConverted, 'Lead should be converted');
        //Assert.isTrue(containsForce, 'Contains force');
    }

    @isTest
    private static void handleLeadAutoConvert_Negative_Scenario(){
  
        //given
        Account acc = TestDataFactory.createAccount('testName');
        insert acc;
        //Contact contact = new Contact(FirstName = 'FirstNameTest', LastName = 'LastNameTest', Email = 'rinepem@shouxs.com', AccountId = acc.Id);
        Contact con = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs1111.com', true, 'kkk', 'jjj');
        
        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);

        //act
        Test.startTest();
        //insert listofLead;
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id LIMIT 1];
        //Assert.areEqual(false, leadAfterInsert.IsConverted, 'Lead should be not converted');
        Assert.isFalse(leadAfterInsert.IsConverted, 'Lead should be converted');
    }

    @isTest
    private static void handleLeadAutoConvert_Positive_Check_With_3_Matched_Contacts_In_3_Different_Accounts(){
  
        //given
        Account acc1 = TestDataFactory.createAccount('testName1');
        insert acc1;
        Account acc2 = TestDataFactory.createAccount('testName2');
        insert acc2;
        Account acc3 = TestDataFactory.createAccount('testName3');
        insert acc3;
        // List <Account>accList = new List<Account>();
        // accList.add(acc1);
        // accList.add(acc2);
        // accList.add(acc3);
        // insert accList;

        Contact con1 = TestDataFactory.crateContact(acc1.Id, 'rinepem@shouxs.com', true, 'Fname1', 'Lname1');
        Contact con2 = TestDataFactory.crateContact(acc2.Id, 'rinepem@shouxs.com', true, 'Fname2', 'Lname2');
        Contact con3 = TestDataFactory.crateContact(acc3.Id, 'rinepem@shouxs.com', true, 'Fname3', 'Lname3');

        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);

        //act
        Test.startTest();
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id LIMIT 1];
        //Assert.areEqual(true, leadAfterInsert.IsConverted, 'Lead should be converted');
        Assert.isTrue(leadAfterInsert.IsConverted, 'Lead should be converted');
    }

    @isTest
    private static void handleLeadAutoConver_2_Conatcts_In_The_Same_Account(){
  
        //given
        Account acc = TestDataFactory.createAccount('testName');
        insert acc;

        Contact con1 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname1', 'Lname1');
        Contact con2 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname2', 'Lname2');
        
        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);

        //act
        Test.startTest();
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id LIMIT 1];
        //Assert.areEqual(false, leadAfterInsert.IsConverted, 'Lead should be not converted');
        Assert.isFalse(leadAfterInsert.IsConverted, 'Lead should be not converted');
    }

    @isTest
    private static void handleLeadAutoConver_Negative_3_Conatcts_In_The_Same_Account(){
  
        // //given
        // Account acc = TestDataFactory.createAccount('testName');
        // insert acc;

        // Contact con1 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname1', 'Lname1');
        // Contact con2 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname2', 'Lname2');
        // Contact con3 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname3', 'Lname3');

        // // Contact con1 = new Contact(AccountId = acc.Id, Email ='rinepem@shouxs.com', LastName = 'test1');
        // // Contact con2 = new Contact(AccountId = acc.Id, Email ='rinepem@shouxs.com', LastName  = 'test2');
        // // Contact con3 = new Contact(AccountId = acc.Id, Email ='rinepem@shouxs.com', LastName  = 'test3');
        // // List <Contact> conList = new List<Contact>();
        // // conList.add(con1);
        // // conList.add(con2);
        // // conList.add(con3);
        // // insert conList;
        //');

        TestDataFactory.createAccountsWithContacts(1, 3);

        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);

        //act
        Test.startTest();
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.id];
        //Assert.areEqual(false, leadAfterInsert.IsConverted, 'Lead should be not converted');
        Assert.isFalse(leadAfterInsert.IsConverted, 'Lead should be not converted');

    }

    @isTest
    private static void handleLeadAutoConver_neg_4_Conatcts_In_The_Same_Account(){
  
        //given
        Account acc = TestDataFactory.createAccount('testName');
        insert acc;
        String ids = acc.id;

        Contact con1 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname1', 'Lname1');
        Contact con2 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname2', 'Lname2');
        Contact con3 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname3', 'Lname3');
        Contact con4 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname4', 'Lname4');

        //List<Contact> contacts =  createContacts(4, ids, 'rinepem@shouxs.com', true);
        
        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);

        //act
        Test.startTest();
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id LIMIT 1];
        //Assert.areEqual(False, leadAfterInsert.IsConverted, 'Lead should be not converted');
        Assert.isFalse(leadAfterInsert.IsConverted, 'Lead should be not converted');
    }

    @isTest
    private static void handleLeadAutoConver_neg_5_Conatcts_In_The_Same_Account(){
  
        //given
        Account acc = TestDataFactory.createAccount('testName');
        insert acc;

        Contact con1 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname1', 'Lname1');
        Contact con2 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname2', 'Lname2');
        Contact con3 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname3', 'Lname3');
        Contact con4 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname4', 'Lname4');
        Contact con5 = TestDataFactory.crateContact(acc.Id, 'rinepem@shouxs.com', true, 'Fname5', 'Lname5');

        //List <Contact> contacts = TestDataFactory.createContacts(5, acc.Id, 'rinepem@shouxs.com', true, 'fname', 'Lname');
        //TestDataFactory.createAccountsWithContacts(1, 5);

        Lead lead = TestDataFactory.createLead('rinepem@shouxs.com', false);
      
        //act
        Test.startTest();
        insert lead;
        Test.stopTest();

        //assert
        Lead leadAfterInsert = [SELECT Id, Status, IsConverted FROM Lead WHERE Id = : lead.Id LIMIT 1];
        //Assert.areEqual(false, leadAfterInsert.IsConverted, 'Lead should be not converted');
        Assert.isFalse(leadAfterInsert.IsConverted, 'Lead should be not converted');
    }
}