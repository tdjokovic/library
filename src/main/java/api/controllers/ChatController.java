package api.controllers;

import api.dal.LoanDAL;
import api.dal.MessageDAL;
import api.dal.UserDAL;
import com.google.gson.Gson;
import data.Config;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.UserModel;
import socketModels.UserMessage;

import java.beans.XMLDecoder;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class ChatController extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        Integer userID = Integer.parseInt(req.getParameter("userID"));
        if(req.getParameter("getAllChats") != null) {
            List<UserModel> chats = MessageDAL.getChatsForUser(userID);
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(new Gson().toJson(chats));
        }
        else if(req.getParameter("getSingleChat") != null) {
            Integer otherUserID = Integer.parseInt(req.getParameter("otherUserID"));
            List<UserMessage> messages = MessageDAL.getMessageWithUser(userID, otherUserID);
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(new Gson().toJson(messages));
        }
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        if(req.getParameter("sendMsg") != null)
        {
            System.out.println("SEND MESSAGE");
            System.out.println(req);
            StringBuilder requestBody = new StringBuilder();
            try (BufferedReader reader = req.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    requestBody.append(line);
                }
            }

            Gson gson = new Gson();
            UserMessage message = gson.fromJson(requestBody.toString(), UserMessage.class);
            System.out.println(message.getSenderID());
            System.out.println(message.getReceiverID());
            System.out.println(message.getMessageBody());
            System.out.println(message.getDate());
            boolean status = MessageDAL.addMessage(message);
            System.out.println("status is " + status);

            // SOCKET SEND MESSAGE
            BufferedWriter bw = (BufferedWriter) req.getSession().getAttribute("bw");
            bw.write(message.toString() + "\n");
            bw.flush();

            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(new Gson().toJson(status));
        }
        else if(req.getParameter("getMsg") != null)
        {
            System.out.println("LISTENING....");
            String line;
            XMLDecoder decoder;
            String str = "";
            try
            {
                line = ((BufferedReader)req.getSession().getAttribute("br")).readLine();
                decoder = new XMLDecoder(new ByteArrayInputStream(line.getBytes()));
                UserMessage msg = (UserMessage)decoder.readObject();

                System.out.println("ChatController: NEW MSG" + msg.getMessageBody());
                msg.setSender(UserDAL.getUserByID(msg.getSenderID()));
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write(new Gson().toJson(msg));
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
    }
}
