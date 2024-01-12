<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="socketModels.UserMessage" %>
<%@ page import="java.beans.XMLDecoder" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if(session.getAttribute("auth") == null)
    {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Inbox</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/styles.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
</head>
<body onload="checkForMessages()" style="overflow: hidden">
<input type="hidden" id="userID" value="<%= Integer.parseInt(session.getAttribute("userID").toString()) %>">
<input type="hidden" id="receiverID" value="">
<jsp:include page="header.jsp"></jsp:include>

<div class="container" style="margin-top: 10%; height: 75vh">
    <div id="chat-list"></div>
    <div style="padding-left: 20px; float: right; width: 80%; height: 100%">
        <div id="messages-content"></div>
        <div id="message-input">
            <input id="new-message" type="text" />
            <button onclick="sendMessage()">Pošalji</button>
        </div>
    </div>
</div>

<style type="text/css">
    #message-input {
        position: fixed;
        width: 50vw;
        bottom:10px;
        margin: auto;
    }

    #new-message {
        width: 80%;
    }

    #chat-list {
        width: 20%;
        overflow-y: auto;
        border-right: 1px solid #ccc;
        box-sizing: border-box;
        height: 100vh;
        display: flex;
        float:left;
    }

    #messages-content {
        flex: 1;
        width: 80%;
        height: 98%;
        padding: 20px;
        box-sizing: border-box;
        overflow-y: scroll;
    }

    /* Style for list items */
    #chat-list ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    #chat-list li {
        padding: 10px;
        cursor: pointer;
        border-bottom: 1px solid #eee;
    }

    #chat-list li:hover {
        background-color: lightgray;
    }

    .message {
        padding: 10px;
        margin-bottom: 5px;
        border-radius: 5px;
        max-width: 70%; /* Adjust the maximum width as needed */
    }

    .right {
        float: right;
        clear: both;
        background-color: #DCF8C6; /* Adjust background color as needed */
    }

    .left {
        float: left;
        clear: both;
        background-color: #EFEFEF; /* Adjust background color as needed */
    }

    .chat-container {
        overflow: auto; /* Ensure the container expands to contain floated elements */
    }

    .active-chat {
        background-color: lightgray;
    }

</style>
</body>
<script>
    document.getElementById("new-message").addEventListener("keyup", (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            sendMessage();
        }
    })

    function checkForMessages()
    {
        var x = new XMLHttpRequest();
        var userID = document.getElementById("userID").value;

        x.onreadystatechange = function()
        {
            if (x.readyState == 4 && x.status == 200)
            {
                var chats = JSON.parse(x.responseText);
                console.log(chats);
                var str = "";

                str += "<ul>";
                for(let i = 0 ; i < chats.length; i++)
                {
                    str += "<li style='border-radius: 5px' id='chat-"+ chats[i].userID +"' onclick='showChat("+chats[i].userID+")'>" + chats[i].firstName + " " + chats[i].lastName + "</li>";
                }
                str += "</ul>";

                document.getElementById("chat-list").innerHTML = str;
                showChat(chats[0].userID);
                listenNewMessages();
            }
        };

        x.open("get", "../getChats?userID=" +userID + "&getAllChats=", true);
        x.send();
    }

    function listenNewMessages()
    {
        var x = new XMLHttpRequest();
        console.log('listening for messages');
        x.onreadystatechange = function()
        {
            if (x.readyState == 4 && x.status == 200)
            {
                var msg = JSON.parse(x.responseText);
                console.log('NEW MESSAGE!');
                console.log(msg);

                var userID = document.getElementById("userID").value;
                var otherUserID = document.getElementById("receiverID").value;

                if((parseInt(userID) === msg.senderID && parseInt(otherUserID) === msg.receiverID) || (parseInt(userID) === msg.receiverID && parseInt(otherUserID) === msg.senderID))
                {
                    var newMessage = generateMessage(msg, userID, otherUserID);
                    console.log(newMessage);
                    document.getElementById("messages-content").innerHTML += newMessage;
                    scrollMessages();
                }
                listenNewMessages();
            }
        };

        x.open("post", "../message?getMsg=", true);
        x.send();
    }

    function showChat(otherUserID)
    {
        var chatItems = document.querySelectorAll('#chat-list li');
        chatItems.forEach((chatItem) => {
            chatItem.classList.remove('active-chat');
        });

        var chatInList = document.getElementById("chat-" + otherUserID);
        chatInList.classList.add('active-chat');

        document.getElementById("receiverID").value = otherUserID;
        var x = new XMLHttpRequest();
        var userID = document.getElementById("userID").value;

        x.onreadystatechange = function()
        {
            if (x.readyState == 4 && x.status == 200)
            {
                var messages = JSON.parse(x.responseText);
                // preview all messages
                var chatContent = generateChat(messages, userID, otherUserID);
                document.getElementById("messages-content").innerHTML = chatContent;
                document.getElementById("new-message").innerHTML = "";
                scrollMessages();
            }
        };

        x.open("get", "../getChats?userID=" +userID + "&getSingleChat=" + "&otherUserID=" + otherUserID, true);
        x.send();
    }

    function scrollMessages()
    {
        const scrollableDiv = document.getElementById("messages-content");
        scrollableDiv.scrollTo({
            top: scrollableDiv.scrollHeight,
            behavior: 'instant'
        });
    }

    function generateChat(messages, userID, otherUserID) {
        var chatHTML = "";

        for (var i = 0; i < messages.length; i++) {
            var message = messages[i];
            chatHTML += generateMessage(message, userID, otherUserID);
        }

        return chatHTML;
    }

    function generateMessage(message, userID, otherUserID)
    {
        var messageHTML = "";
        var isCurrentUser = (message.senderID === parseInt(userID) || message.receiverID === parseInt(otherUserID));
        var alignClass = (isCurrentUser) ? 'right' : 'left';
        messageHTML += '<div style="width: 100%">'
        messageHTML += '<div class="message ' + alignClass + '">';
        messageHTML += '<span class="message-body">' + message.messageBody + '</span>';
        messageHTML += '</div></div>';

        return messageHTML;
    }

    function sendMessage()
    {
        const message = document.getElementById("new-message").value;
        var userID = document.getElementById("userID").value;
        var receiverID = document.getElementById("receiverID").value;
        console.log(`sending message from ${userID} to ${receiverID}`)

        var x = new XMLHttpRequest();
        x.onreadystatechange = function()
        {
            if (x.readyState == 4 && x.status == 200)
            {
                document.getElementById("new-message").value = "";
            }
        };

        const date = getTodaysDate();
        var data = JSON.stringify({
            senderID: userID,
            receiverID: receiverID,
            messageBody: message,
            date: date
        });
        x.open("POST", "../message?sendMsg=", true);
        x.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        x.send(data);
    }

    function getTodaysDate()
    {
        const date = new Date();
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0'); // Months are zero-based
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');

        return year+"-"+month+"-"+day+"-"+hours+"-"+minutes+"-"+seconds;
    }

</script>
</html>