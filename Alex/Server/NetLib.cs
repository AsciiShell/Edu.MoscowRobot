using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Linq;
using System.Windows.Forms;

namespace ClassControl
{

    public class InitNet
    {
        #region ClassUser
        public class User
        {

            private IPAddress _Ip;
            private int _ID;
            private int _PortServer;
            private int _PortClient;
            private Boolean _Connected;
            private Boolean _Activated;
            private Thread _TCPConnect;
            private workServerIPTCP _Server;
            private PictureBox _Button;
            private int _X;
            private int _Y;
            private bool _Connecting;



            public int ID { get { return _ID; } set { _ID = value; } }
            public IPAddress Ip { get { return _Ip; } set { _Ip = value; } }
            public int PortServer { get { return _PortServer; } set { _PortServer = value; } }
            public int PortClient { get { return _PortClient; } set { _PortClient = value; } }
            public bool Connected { get { return _Connected; } set { _Connected = value; } }
            public bool Activated { get { return _Activated; } set { _Activated = value; } }
            public Thread TCPConnect { get { return _TCPConnect; } set { _TCPConnect = value; } }
            public workServerIPTCP Server { get { return _Server; } set { _Server = value; } }
            public PictureBox Button { get { return _Button; } set { _Button = value; } }
            public int X { get { return _X; } set { _X = value; } }
            public int Y { get { return _Y; } set { _Y = value; } }
            public bool Connecting { get { return _Connecting; } set { _Connecting = value; } }

            public User(int id)
            {
                _ID = id;
                _Connected = false;
                _Connecting = false;
                _Activated = true;
            }
            public void LockUser()
            {
                try
                {
                    Server.SendToClient("block");
                    Button.Image = Properties.Resources.Block;
                    Activated = false;
                }
                catch
                {
                    MakeError();
                }

            }
            public void UnlockUser()
            {
                try
                {
                    Server.SendToClient("unlock");
                    Button.Image = Properties.Resources.Connect;
                    Activated = true;
                }
                catch
                {
                    MakeError();
                }
            }
            public void PowerOff()
            {
                try
                {
                    Server.SendToClient("poweroff");
                }
                catch
                {
                    MakeError();
                }
            }
            public void Reboot()
            {
                try
                {
                    Server.SendToClient("reboot");
                }
                catch
                {
                    MakeError();
                }
            }
            public void MakeError()
            {
                Connected = false;
                Connecting = false;
                Button.Image = Properties.Resources.Disconnect;
                if (Server != null)
                {
                    Server.Stop();
                    // Server = null;
                }
                //if (TCPConnect != null)
                //{
                //    //Experimental
                //    TCPConnect = null;
                //}
            }

        }
        #endregion ClassUser

        #region UDPserver
        public class workServerIPUDP
        {
            // fixme
            private const string _trueInput = "wis";
            private const string _trueOutput = "sih";
            public void DoWork()
            {
                try
                {
                    var listener = new UdpClient(UDPport);
                    while (true)
                    {
                        var groupEP = new IPEndPoint(IPAddress.Any, UDPport);
                        var bytes = listener.Receive(ref groupEP);
                        // Проверяем данные на верность, а так же определяем пользователя
                        // Приходит id
                        var message = Encoding.UTF8.GetString(bytes).Split(" "[0]);
                        var id = int.Parse(message[1]);

                        if (message[0] == _trueInput)// && !_UserArray[id - 1].Connecting)
                        {
                            // Нам отправили запрос на создание нового подключения
                            // Запустим параллельно новую прослушку на порту, соответствующим данному пользователю
                            // Для ip адреса, с которого пришла датаграмма
                            // При этом данную слушалку необходимо поместить в структуру данных,
                            // Содержащую информацию о клиенте (id, ip, port, статус)
                            // А так же отправить сведения для подключения
                            // Console.Write(groupEP.Address.ToString());

                            _UserArray[id - 1].Ip = groupEP.Address;

                            string MessageStr = _trueOutput + " " + _UserArray[id - 1].PortServer.ToString();

                            var client = new IPEndPoint(_UserArray[id - 1].Ip, _UserArray[id - 1].PortClient);
                            bytes = Encoding.UTF8.GetBytes(MessageStr);
                            listener.Send(bytes, bytes.Length, client);



                            if (_UserArray[id - 1].TCPConnect == null)
                            {
                                _UserArray[id - 1].Server = new workServerIPTCP();
                                _UserArray[id - 1].Server.SetId(id);
                                _UserArray[id - 1].TCPConnect = new Thread(_UserArray[id - 1].Server.DoWork);
                                _UserArray[id - 1].TCPConnect.Start();
                            }
                            _UserArray[id - 1].Server.Start();
                        }
                    }
                }
                catch (Exception e)
                {
                    File.AppendAllText("logsUDPServer.txt", e.ToString() + Environment.NewLine + Environment.NewLine);
                    throw;
                }

            }
        }
        #endregion UDPserver
        #region TCPSever
        public class workServerIPTCP
        {

            private Queue<string> SendMessege;
            private string GetMessege;
            private int id;
            //private bool IsGood = true;//
           // private bool IsConnect = false;

            public void SetId(int i)
            {
                id = i;
                SendMessege = new Queue<string>();
            }

            public void DoWork()
            {
                if (_UserArray[id - 1].Connected)
                {
                    File.AppendAllText("SecondRun.txt", "It`s run!" + Environment.NewLine + Environment.NewLine);
                    _UserArray[id - 1].MakeError();
                    return;
                }
#pragma warning disable CS0618 // Тип или член устарел
                TcpListener listener = new TcpListener(_UserArray[id - 1].PortServer);
#pragma warning restore CS0618 // Тип или член устарел

                while (true)
                {
                    try
                    {
                        listener.Start();
                        TcpClient client = listener.AcceptTcpClient();
                        if (client.Client.RemoteEndPoint.AddressFamily == _UserArray[id - 1].Ip.AddressFamily)
                        {
                            _UserArray[id - 1].Connected = true;
                            _UserArray[id - 1].Connecting = false;

                            bool FirstMessage = true;
                            NetworkStream dialog = client.GetStream();
                            dialog.ReadTimeout = 128;
                            dialog.WriteTimeout = 128;
                            SendMessege.Enqueue("settime " + DateTime.Now.ToString());
                            while (_UserArray[id - 1].Connected)
                            {

                                if (SendMessege.Count == 0)
                                {
                                    Thread.Sleep(5);
                                    continue;
                                }

                                byte[] bytes = Encoding.UTF8.GetBytes(SendMessege.Dequeue());

                                dialog.Write(bytes, 0, bytes.Length);
                                bytes = new byte[256];

                                int i = dialog.Read(bytes, 0, bytes.Length);

                                GetMessege = Encoding.UTF8.GetString(bytes, 0, i).Trim();
                                if ((bool.Parse(GetMessege) != _UserArray[id - 1].Activated) || FirstMessage)
                                {
                                    _UserArray[id - 1].Activated = !_UserArray[id - 1].Activated;
                                    if (_UserArray[id - 1].Activated)
                                    {
                                        _UserArray[id - 1].Button.Image = Properties.Resources.Connect;
                                    }
                                    else
                                    {
                                        _UserArray[id - 1].Button.Image = Properties.Resources.Block;
                                    }
                                    FirstMessage = false;
                                }
                            }

                        }
                    }

                    catch (Exception e)
                    {
                        //File.AppendAllText("logsTCP.txt", e.ToString() + Environment.NewLine);
                        //throw;
                    }
                    finally
                    {
                        _UserArray[id - 1].Connected = false;
                        _UserArray[id - 1].Connecting = false;
                        _UserArray[id - 1].Button.Image = Properties.Resources.Disconnect;
                    }

                }

            }

            public void SendToClient(string s)
            {
                SendMessege.Enqueue(s);

            }
            public void Stop()
            {
                _UserArray[id-1].Connected = false;
                _UserArray[id - 1].Connecting = false;
            }
            public void Start()
            {
                _UserArray[id - 1].Connected = false;
                _UserArray[id - 1].Connecting = true;

            }
        }
        #endregion TCPserver

        public InitNet()
        {

            InitDataBase();
            var UDPworkObject = new workServerIPUDP();
            var UDPworkThread = new Thread(UDPworkObject.DoWork);
            UDPworkThread.Start();

        }

        public void InitDataBase()
        {

            var ArrS = File.ReadAllLines("users.ccdb");
            int count = int.Parse(ArrS[0]);
            _UserArray = new User[count];

            // Here parse string number 1
            // {
            //
            // }
            var coordinates = ArrS[2].Split(' ').Select(n => int.Parse(n)).ToArray();
            UDPport = int.Parse(ArrS[2].Split(' ')[0]);
            for (int i = 0; i < count; i++)
            {
                string s = ArrS[i + 3];
                var _params = s.Split(' ').Select(n => int.Parse(n)).ToArray();
                if (_params[0] == (i + 1))
                {
                    UserArray[i] = new User(i + 1);
                    UserArray[i].PortClient = _params[1];
                    UserArray[i].PortServer = _params[2];
                    UserArray[i].Activated = true;
                    UserArray[i].Connected = false;
                    UserArray[i].X = _params[3];
                    UserArray[i].Y = _params[4];
                }
                else
                {
                    // DataBase Error
                }

            }

        }

        static User[] _UserArray;
        public User[] UserArray { get { return _UserArray; } set { _UserArray = value; } }
        private static int UDPport;
        public int _UDPport { get { return UDPport; } set { UDPport = value; } }

    }

}
