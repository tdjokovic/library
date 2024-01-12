package api.controllers;

import java.io.IOException;

import api.dal.LoanDAL;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

public class LoanController extends HttpServlet
{
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        Integer bookID = Integer.parseInt(req.getParameter("bookID"));
        Integer count = LoanDAL.getWaitlistCount(bookID);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(new Gson().toJson(count));
    }
}
