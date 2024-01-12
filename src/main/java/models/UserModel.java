package models;

public class UserModel {
    private int userID;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String password2;
    private Integer userTypeID;

    public UserModel() {}

    public UserModel(int userID, String firstName, String lastName) {
        super();
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public UserModel(int userID, String firstName, String lastName, String email, String password, String password2, Integer userTypeID) {
        super();
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.password2 = password2;
        this.userTypeID = userTypeID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword2() {
        return password2;
    }

    public void setPassword2(String password2) {
        this.password2 = password2;
    }

    public int getUserTypeID() {
        return userTypeID;
    }

    public void setUserTypeID(int userTypeID) {
        this.userTypeID = userTypeID;
    }

    public boolean checkPasswords()
    {
        return password.equals(password2);
    }
}
