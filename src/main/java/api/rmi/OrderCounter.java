package api.rmi;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

import api.dal.BookDAL;

public class OrderCounter extends UnicastRemoteObject implements IOrderCounter
{
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public OrderCounter() throws RemoteException
    {
        super();
    }

    // TODO change this into smth else, counting doesnt make sense here
    @Override
    public int countOrders(int userID) throws RemoteException
    {
        return 3;
    }
}
