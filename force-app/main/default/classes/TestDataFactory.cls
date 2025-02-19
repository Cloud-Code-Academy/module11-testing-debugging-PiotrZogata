public with sharing class TestDataFactory {

    public static Account createAccount(String name){
        Account account = new Account(Name = name, Industry = 'Technology', Type = 'Customer - Direct');
        return account;
    }

    public static Contact crateContact(Id accountId, String email, Boolean  isInsert, String firstName, String lastName){
            Contact contact = new Contact(AccountId = accountId, Email = email, FirstName = firstName, LastName = lastName);
             if(isInsert == true){
                insert contact;
             }
            return contact;
    }

    public static List<Contact> createContacts(Integer numOfLeads, Id accountId, String email, Boolean  doInsert, String firstName, String lastName){
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i <= numOfLeads; i++){
            Contact contact = (crateContact(accountId, email, false, firstName + i, lastName + i));
            contacts.add(contact);
        }
        if(doInsert == true){
            insert contacts;
        }
        return contacts;
    }

    public static List<Lead> createLeads(Integer numOfLeads, String email, Boolean doInsert){
        List <Lead> leads = new List<Lead>();

        for(Integer i = 0; i < numOfLeads; i++){
            Lead lead = createLead (email, false);
            leads.add(lead);
        }
        if(doInsert == true){
            insert leads;
        }
        return leads;
    }

    public static Lead createLead (String email, Boolean doInsert){
        Lead lead = new Lead(Email = email, FirstName = 'testFirstName', LastName = 'testLastName', Company = 'TestCompanyName' );
        if(doInsert == true){
            insert lead;
        }
        return lead;
    }

    // my class TestDataFactory 
    //https://trailhead.salesforce.com/content/learn/modules/apex_testing/apex_testing_data
    public static List<Account> createAccountsWithContacts(Integer numAccts, Integer numConPerAcct) {
    List<Account> accts = new List<Account>();
    for(Integer i=0;i<numAccts;i++) {
      Account a = new Account(Name='TestAccount' + i);
      accts.add(a);
    }
    insert accts;
    List<Contact> conts = new List<Contact>();
    for(Integer j=0;j<numAccts;j++) {
      Account acct = accts[j];
      // For each account just inserted, add contacts
      for(Integer k=0;k<numConPerAcct;k++) {
        conts.add(new Contact(LastName=acct.Name + ' Contact ' + k, Email='rinepem@shouxs.com', AccountId=acct.Id));
      }
    }
    // Insert all opportunities for all accounts.
    insert conts;
    return accts;
  }
}
