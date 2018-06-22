using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using YDL.Map;
using YDL.BLL;

namespace YDL.Service
{
    public partial class YDLServerService : ServiceBase
    {
        private static readonly Timer timer = new Timer(120000);//2分钟

        public YDLServerService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            timer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
            timer.AutoReset = true;
            timer.Enabled = true;

        }

        private static async void timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            string msg = await Monitoring();
        }

        private static async Task<string> Monitoring()
        {
            return await Task.Run<string>(() =>
            {
                //业务逻辑代码
                LogHelper.SaveLog("测试服务", "测试服务");
                return string.Empty;
            });
        }

        protected override void OnStop()
        {
            timer.Stop();
            timer.Dispose();
        }

        protected override void OnContinue()
        {
            timer.Start();
            base.OnContinue();
        }

        protected override void OnPause()
        {
            timer.Stop();
            base.OnPause();
        }

    }
}
