package models;

import java.util.List;

public class BookModel
{
    private int bookID;
    private String name;
    private String description;
    private String authorFirstName;
    private String authorLastName;
    private boolean availability;
    private List<String> images;

    public BookModel(int bookID, String name) {
        this.bookID = bookID;
        this.name = name;
    }

    public BookModel(int bookID, String name, String authorFirstName, String authorLastName, boolean availability)
    {
        super();
        this.bookID = bookID;
        this.name = name;
        this.authorFirstName = authorFirstName;
        this.authorLastName = authorLastName;
        this.availability = availability;
    }

    public BookModel(int bookID, String name, String authorFirstName, String authorLastName, String description, List<String> images, boolean availability)
    {
        super();
        this.bookID = bookID;
        this.name = name;
        this.authorFirstName = authorFirstName;
        this.authorLastName = authorLastName;
        this.description = description;
        this.availability = availability;
        this.images = images;
    }

    public int getBookID()
    {
        return bookID;
    }

    public void setBookID(int bookID)
    {
        this.bookID = bookID;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }
    public String getAuthorFirstName()
    {
        return authorFirstName;
    }

    public void setAuthorFirstName(String authorFirstName)
    {
        this.authorFirstName = authorFirstName;
    }
    public String getAuthorLastName()
    {
        return authorLastName;
    }

    public void setAuthorLastName(String authorLastName)
    {
        this.authorLastName = authorLastName;
    }

    public boolean getAvailability()
    {
        return availability;
    }

    public void setAvailability(boolean availability)
    {
        this.availability = availability;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public List<String> getImages()
    {
        return images;
    }

    public void setImages(List<String> images)
    {
        this.images = images;
    }
}
