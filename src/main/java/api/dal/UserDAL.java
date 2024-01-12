package api.dal;

import api.db.ConnectionProvider;
import data.UserType;
import models.UserModel;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

public class UserDAL {
    private static Connection conn = ConnectionProvider.getConn();

    public static UserModel checkLogin(String email, String password)
    {
        String sql = "select * from user u join usertype t on u.userTypeID = t.typeID where email = ? and password = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            while(rs.next())
                return new UserModel(rs.getInt("userID"), rs.getString("firstName"), rs.getString("lastName"), rs.getString("email"), rs.getString("password"), rs.getString("password"), rs.getInt("t.typeID"));
        } catch (SQLException e){
            e.printStackTrace();
        }

        return null;
    }

    public static boolean addNewUser(UserModel user, boolean admin)
    {
        int userTypeID = admin ? UserType.BIBLIOTEKAR.getValue() : UserType.CITALAC.getValue();

        String sql = "insert into user (firstName, lastName, email, password, userTypeID) " +
                "values ( '"+ user.getFirstName() + "', '" + user.getLastName() + "', '" + user.getEmail() + "', '" +
                user.getPassword() + "', " + userTypeID + ")";

        System.out.println(sql);
        try{
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
        } catch (SQLException e){
            e.printStackTrace();
        }

        return true;
    }

    public static UserModel getUserByID(int userID)
    {
        String sql = "select * from user u join usertype t on u.userTypeID = t.typeID where userID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();
            while(rs.next())
                return new UserModel(rs.getInt("userID"), rs.getString("firstName"), rs.getString("lastName"),
                        rs.getString("email"), rs.getString("password"), rs.getString("password"), rs.getInt("t.typeID"));
        } catch (SQLException e){
            e.printStackTrace();
        }

        return null;
    }

    public static List<UserModel> getUsers(int userType, int userID)
    {
        List<UserModel> users = new LinkedList<UserModel>();
        String sql = "select * from user u join usertype t on u.userTypeID = t.typeID where userTypeId = ? AND u.userID != ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userType);
            ps.setInt(2, userID);

            ResultSet rs = ps.executeQuery();
            while(rs.next())
                users.add(
                        new UserModel(rs.getInt("userID"), rs.getString("firstName"), rs.getString("lastName"),
                                rs.getString("email"), rs.getString("password"), rs.getString("password"), rs.getInt("t.typeID")));
        } catch (SQLException e){
            e.printStackTrace();
        }

        return users;
    }

    public static boolean removeUser(int userID)
    {
        String sql = "delete from user where userID = ?";

        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.executeUpdate();

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return true;
    }
}
