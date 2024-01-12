package api.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import api.dal.BookDAL;
import models.BookModel;

public class BooksController extends HttpServlet
{
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        String filter = req.getParameter("filter");

        List<BookModel> cars = BookDAL.getAllBooks(filter);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(new Gson().toJson(cars));
    }
}
