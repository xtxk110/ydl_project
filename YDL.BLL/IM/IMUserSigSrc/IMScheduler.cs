using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace YDL.BLL
{
    public class IMScheduler
    {
        public static int count;
        public static void GenerateUserSig()
        {
//            // 目前调试的时候会有32位sigcheck32.dll 在64位IIS 运行的冲突报错 ,故做下面条件编译解决此问题

//#if DEBUG //调试的时候直接从webconfig取 userSig
//            IMRequest.userSig = ConfigurationManager.AppSettings["UserSig"];
//#else  //发布后 取自动生成的userSig
//            IMRequest.userSig = IMUserSig.GetUserSig("");
//            new Scheduler().AutoGenerateUserSig();
            
//            /*
//            *后面做分布式的时候, 每台机子的userSig 可以不一样, 比如 A服务器 为 userSigA , B服务器为 userSigB 
//            *这个不一样的 userSig 依旧可以访问 腾讯IM 接口(亲测有效), 有木有其他问题待测试
//            */
//#endif


        }

        /// <summary>
        ///每隔179天替换userSig ,腾讯 IM UserSig  180 天过期, 提前一天生成userSig
        /// </summary>
        public void AutoGenerateUserSig()
        {
            Timer timer = new Timer();
            timer.Interval = new TimeSpan(1, 0, 0, 0).TotalMilliseconds;
            timer.AutoReset = true;
            timer.Enabled = true;

            //每隔1天触发执行Timer_Elapsed 方法
            timer.Elapsed += new ElapsedEventHandler(Timer_Elapsed);
        }


        public void Timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            count++;
            if (count == 179)
            {
                //到达第179天, 生成新的 userSig
                //IMRequest.userSig = IMUserSig.GetUserSig();
                count = 0;
            }
        }


    }
}
