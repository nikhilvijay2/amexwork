@isTest
public class AnimalLocatorTest {
    
    @isTest static void AnimalLocatorMock(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string actual = AnimalLocator.getAnimalNameById(1);
        string expected = 'chicken';
        system.assertEquals(actual, expected);
        
    }

}