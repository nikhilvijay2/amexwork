public class EmployeeClass {
    
    string EmployeeName;
    Integer Employeeno;
    
    public EmployeeClass(){
        
        EmployeeName = 'Nikhil';
        Employeeno = 10;
    }
    
    public void show(){
        system.debug('EmployeeName' +EmployeeName);
        system.debug('Employeeno' +Employeeno);
    }

}