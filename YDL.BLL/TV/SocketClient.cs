using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace YDL.BLL
{
    public class SocketClient
    {
        private static byte[] result = new byte[1024];
        public static void SendRefreshCacheMsg()
        {
            //设定服务器IP地址
            string[] ipPort = UserHelper.GetConfig().IntranetSocketIpAndPort.Split(new char[] { ':'});
            string ipStr = ipPort[0];
            string port = ipPort[1];
            IPAddress ip = IPAddress.Parse(ipStr);
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            try
            {
                clientSocket.Connect(new IPEndPoint(ip, Convert.ToInt32(port))); //配置服务器IP与端口
                Console.WriteLine("连接服务器成功");
            }
            catch
            {

                Console.WriteLine("连接服务器失败，请按回车键退出！");
                return;
            }

            //通过 clientSocket 发送数据

            try
            {
                SocketMessage msgObj = new SocketMessage();
                msgObj.ServerAction = "RefreshTVConfigCache";
                string msg = JsonConvert.SerializeObject(msgObj);
                clientSocket.Send(Encoding.UTF8.GetBytes(msg));
                Console.WriteLine("向服务器发送消息：{0}" + msg);
            }
            catch
            {
                clientSocket.Shutdown(SocketShutdown.Both);
                clientSocket.Close();
            }
            Console.WriteLine("发送完毕，按回车键退出");
        }

        public class SocketMessage
        {
            public string ServerAction { get; set; }
            public string UserCode { get; set; }
        }

    }
}
