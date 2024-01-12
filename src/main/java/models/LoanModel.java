package models;

import java.time.LocalDate;

public class LoanModel {
    private Integer loanID;
    private BookModel book;
    private UserModel user;
    private AuthorModel author;
    private LocalDate loanDate;
    private LocalDate returnDate;

    public LoanModel(BookModel book, AuthorModel author, LocalDate loanDate, LocalDate returnDate) {
        this.book = book;
        this.author = author;
        this.loanDate = loanDate;
        this.returnDate = returnDate;
    }

    public LoanModel(Integer loanID, BookModel book, UserModel user, LocalDate loanDate, LocalDate returnDate) {
        this.loanID = loanID;
        this.book = book;
        this.user = user;
        this.loanDate = loanDate;
        this.returnDate = returnDate;
    }

    public BookModel getBook() {
        return book;
    }

    public void setBook(BookModel book) {
        this.book = book;
    }

    public Integer getLoanID() {
        return loanID;
    }

    public void setLoanID(Integer loanID) {
        this.loanID = loanID;
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

    public void setAuthor(UserModel user) {
        this.user = user;
    }

    public LocalDate getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(LocalDate loanDate) {
        this.loanDate = loanDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }
}
