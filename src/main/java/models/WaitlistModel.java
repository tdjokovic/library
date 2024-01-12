package models;

public class WaitlistModel {
    private Integer waitlistID;
    private BookModel book;
    private AuthorModel author;
    private UserModel user;
    private Integer position;

    public WaitlistModel(Integer waitlistID, BookModel book, UserModel user, Integer position) {
        this.waitlistID = waitlistID;
        this.book = book;
        this.user = user;
        this.position = position;
    }

    public WaitlistModel(Integer waitlistID, BookModel book, AuthorModel author, Integer position) {
        this.waitlistID = waitlistID;
        this.book = book;
        this.author = author;
        this.position = position;
    }

    public Integer getWaitlistID() {
        return waitlistID;
    }

    public void setWaitlistID(Integer waitlistID) {
        this.waitlistID = waitlistID;
    }

    public BookModel getBook() {
        return book;
    }

    public void setBook(BookModel book) {
        this.book = book;
    }
    public AuthorModel getAuthor() {
        return author;
    }

    public void setAuthor(AuthorModel author) {
        this.author = author;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }
}
