package api.dal;

import api.db.ConnectionProvider;
import models.LoanModel;
import models.UserModel;
import socketModels.UserMessage;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class MessageDAL {
    private static Connection conn = ConnectionProvider.getConn();

        public static List<UserModel> getChatsForUser(Integer userID)
    {
        List<UserModel> chats = new LinkedList<>();
        String sql = "SELECT * FROM chats c join user u on c.receiverID = u.userID WHERE c.senderID = ? ORDER BY c.date DESC";

        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            while(rs.next())
            {
                chats.add(new UserModel(rs.getInt("c.receiverID"), rs.getString("u.firstName"), rs.getString("u.lastName")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(chats);
        return chats;
    }

    public static boolean addNewChat(Integer userID, Integer otherUserID)
    {
        String sql = "select count(*) as num_of_chats from chats where senderID = ? AND receiverID=?";
        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, otherUserID);

            ResultSet rs = ps.executeQuery();
            if(rs.next())
            {
                Integer count = rs.getInt("num_of_chats");
                if(count == 0)
                {
                    // add new
                    String pattern= "yyyy-MM-dd HH:mm:ss";
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
                    String date = simpleDateFormat.format(new Date());

                    sql = "insert into chats (senderID, receiverID, date) values ("+
                            userID+ ", "+
                            otherUserID+ ", '" +
                            date + "')";

                    try{
                        Statement st = conn.createStatement();
                        st.executeUpdate(sql);
                    } catch (SQLException e){
                        e.printStackTrace();
                    }
                }
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return true;
    }

    public static List<UserMessage> getMessageWithUser(Integer userID, Integer otherUserID)
    {
        List<UserMessage> messages = new LinkedList<UserMessage>();
        String sql = "select * from message where (senderID = ? AND receiverID = ?) OR (receiverID = ? AND senderID = ?) ORDER BY date ASC";

        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, otherUserID);
            ps.setInt(3, userID);
            ps.setInt(4, otherUserID);

            ResultSet rs = ps.executeQuery();

            while(rs.next())
                messages.add(new UserMessage(rs.getInt("messageID"),rs.getInt("senderID"), rs.getInt("receiverID"),
                        rs.getString("messageBody"), rs.getString("date")));
        } catch (SQLException e){
            e.printStackTrace();
        }

        return messages;
    }

    public static boolean addMessage(UserMessage msg)
    {
        String sql = "insert into message (senderID, receiverID, messageBody, date) values ("+
                msg.getSenderID()+ ", "+
                msg.getReceiverID()+ ", '" +
                msg.getMessageBody() + "', '"+
                msg.getDate() + "')";
        System.out.println(sql);
        try{
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
        } catch (SQLException e){
            e.printStackTrace();
        }

        return true;
    }
}
