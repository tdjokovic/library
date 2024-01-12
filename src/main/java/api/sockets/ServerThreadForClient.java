package api.sockets;

import java.beans.XMLDecoder;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.HashMap;

import socketModels.UserMessage;

public class ServerThreadForClient extends Thread
{
    private HashMap<Integer, BufferedWriter> clients = null;
    Socket clientSocket = null;

    public ServerThreadForClient (HashMap<Integer, BufferedWriter> clients, Socket clientSocket)
    {
        super();
        this.clients = clients;
        this.clientSocket = clientSocket;
    }

    @Override
    public void run()
    {
        super.run();
        BufferedReader br = null;
        BufferedWriter bw = null;

        try
        {
            br = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            bw = new BufferedWriter(new OutputStreamWriter(clientSocket.getOutputStream()));

            // prijava na sistem
            System.out.println("Nov se prijavio na sistem!");

            String line = br.readLine();
            XMLDecoder decoder = new XMLDecoder(new ByteArrayInputStream(line.getBytes()));
            UserMessage msg = (UserMessage)decoder.readObject();

            synchronized (clients)
            {
                clients.put(msg.getSenderID(), bw);
            }


            System.out.println("Uspesna prijava... slusam");
            while (true)
            {
                line = br.readLine();
                decoder = new XMLDecoder(new ByteArrayInputStream(line.getBytes()));
                msg = (UserMessage)decoder.readObject();

                System.out.println("SERVER: primio sam poruku '" +msg.getMessageBody() + "'");

                if (msg.getMessageBody().equals("logout"))
                {
                    synchronized (clients)
                    {
                        clients.remove(msg.getSenderID());
                    }

                    if (!clientSocket.isClosed())
                        clientSocket.close();
                    break;
                }
                else
                {
                    for (BufferedWriter bwritter : clients.values())
                    {
                        bwritter.write(msg.toString() +"\n");
                        bwritter.flush();
                    }
                }
            }
        } catch (IOException e)
        {
            e.printStackTrace();
        }
    }
}