@RestResource (urlMapping='/contacts/*')

global with sharing class HrRestContacts {
    
    @HttpPut
    global static String upsertContact(String FirstName, String LastName, String Email, String Phone,String Title){
       
        if(String.isBlank(Email)|| String.isBlank(LastName)){
            return 'Error: Lastname and Email are required.';
        }

        List<contact> existingContact=[SELECT id FROM Contact WHERE Email=:Email LIMIT 1];

        String operation='';
        Contact contactRecord;
        if(existingContact.size()>0){
            operation='Updated';
            contactRecord=existingContact[0];

            contactRecord.FirstName=FirstName;
            contactRecord.LastName=LastName;
            contactRecord.Email=Email;
            contactRecord.Phone=Phone;
            contactRecord.Title=Title;

            update contactRecord;
            return 'Contact updated successfully, Id'+contactRecord.id;
        }else{
            operation='created';
            Contact con=new Contact();
            con.FirstName=FirstName;
            con.LastName=LastName;
            con.Email=Email;
            con.Phone=Phone;
            con.Title=Title;

            insert con;
            return 'Contact Created successfully, id:'+con.id;
        }

    }
}