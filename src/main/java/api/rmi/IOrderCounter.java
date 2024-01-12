package api.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface IOrderCounter extends Remote
{
    public int countOrders(int userID) throws RemoteException;
}
