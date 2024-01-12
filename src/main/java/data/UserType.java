package data;

public enum UserType {

    BIBLIOTEKAR(1),
    CITALAC(2);

    private int value;

    private UserType(int value)
    {
        this.value = value;
    }

    public int getValue()
    {
        return this.value;
    }

}
