public class ExampleClass {
    
    string name;
    
    // Setter Method, this will take value from VF page and set the value to the apex variable name
    public void set(string name){
        this.name = name;
    }
    
    //Getter method, this will return the value to the VF page whenever it is called from apex variable 
    public string getName(){
        return 'Nikhil';
    }

}