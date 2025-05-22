public class Main  {
    public static void main(String[]args){
        student s1 = new Student();
        s1.setName = "Amal";
        System.out.println(s1.getName);

        int totalMarks = s1.calculateTotalMark(20,10);
        System.out.println(totalMarks);

    }
}

public class Student{
    private String name;
    private int age;

    public void setName(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }

    public int calculateTotalMarks(int m1,int m2){
        return m1+m2;
    }


}