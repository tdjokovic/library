package socketModels;

import models.UserModel;

import java.beans.XMLEncoder;
import java.io.ByteArrayOutputStream;
import java.io.Serializable;

public class UserMessage implements Serializable {
    private Integer messageID;
    private Integer senderID;
    private Integer receiverID;
    private String messageBody;
    private String date;
    private UserModel sender;

    public UserMessage() {}

    public UserMessage(Integer senderID, Integer receiverID, String messageBody, String date) {
        this.senderID = senderID;
        this.receiverID = receiverID;
        this.messageBody = messageBody;
        this.date = date;
    }

    public UserMessage(Integer messageID,Integer senderID, Integer receiverID, String messageBody, String date) {
        this.messageID = messageID;
        this.senderID = senderID;
        this.receiverID = receiverID;
        this.messageBody = messageBody;
        this.date = date;
    }


    public Integer getMessageID() {
        return messageID;
    }

    public void setMessageID(Integer messageID) { this.messageID = messageID; }

    public Integer getSenderID() {
        return senderID;
    }

    public void setSenderID(Integer senderID) {
        this.senderID = senderID;
    }

    public Integer getReceiverID() {
        return receiverID;
    }

    public void setReceiverID(Integer receiverID) {
        this.receiverID = receiverID;
    }

    public String getMessageBody() {
        return messageBody;
    }

    public void setMessageBody(String messageBody) {
        this.messageBody = messageBody;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public UserModel getSender() {
        return sender;
    }

    public void setSender(UserModel sender) {
        this.sender = sender;
    }

    @Override
    public String toString()
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        XMLEncoder encoder = new XMLEncoder(baos);
        encoder.writeObject(this);
        encoder.close();

        String s = new String(baos.toByteArray());
        s = s.replace("\n", " ");
        return s;
    }
}
