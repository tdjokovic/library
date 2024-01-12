package api.sockets;

import java.io.BufferedWriter;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;
import java.util.HashMap;

import data.Config;

public class Server
{
    public static void main(String[] args) throws IOException
    {
        System.out.println("SERVER STARTED");

        ServerSocket serverSocket = new ServerSocket(Config.port);
        System.out.println("Server is listening on port " +Config.port);

        HashMap<Integer, BufferedWriter> clients = new HashMap<Integer, BufferedWriter>(); // cuvamo sve klijente koji ce da se prijave ovom serveru

        while (true)
        {
            Socket clientSocket = serverSocket.accept(); // konekcija prema klijentu
            ServerThreadForClient thread = new ServerThreadForClient(clients, clientSocket);
            thread.start();
        }
    }
}