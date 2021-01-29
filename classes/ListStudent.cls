public class ListStudent {
    
    public List<student> stu{get;set;}
    
    public ListStudent(){
        stu = new List<student>();
        
        Student s = new Student('Ram', 20);
        Student s1 = new Student('sam', 22);
        Student s2 = new Student('pam', 23);
        
        stu.add(s);
        stu.add(s1);
        stu.add(s2);
    }

}