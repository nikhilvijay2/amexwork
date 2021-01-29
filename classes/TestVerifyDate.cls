@isTest
public class TestVerifyDate {
    
    @isTest static void testDateWithin30Days(){
        Date d1 = system.today();
        Date d2 = system.today()+10;
        Date verify = VerifyDate.CheckDates(d1,d2);
        system.assertEquals(d2, verify);
    }
    
    @isTest static void testDateEndOfMonth(){
        Date d1 = system.today();
        Date d2 = system.today()-10;
        Date verify2 = VerifyDate.CheckDates(d1,d2);
        //Integer totalDays = Date.daysInMonth(d1.year(), d1.month());
        //Date lastDay = Date.newInstance(d1.year(), d1.month(), totalDays);
        system.assertEquals(d1+30,verify2);
    }

}