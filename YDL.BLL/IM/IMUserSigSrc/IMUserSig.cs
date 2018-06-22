using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Web.Hosting;
using System.Configuration;

// 此文件为 C# ，使用的非托管模式的 C++ 接口
// 项目中使用 C# 调用 dllsigcheck.dll 时请注意平台，64 位和 32 位平台的 dll 我们均有预编译

namespace YDL.BLL
{

    public class IMUserSig
    {

        public static string GetUserSig(string identifier)
        {
            //设置 调用文件路径
            string pri_key_path = HostingEnvironment.ApplicationPhysicalPath + @"bin\IM\IMUserSigSrc\private_key";
            string pub_key_path = HostingEnvironment.ApplicationPhysicalPath + @"bin\IM\IMUserSigSrc\public_key";
            var path = HostingEnvironment.ApplicationPhysicalPath + @"bin\IM\IMUserSigSrc";
            SetDllDirectory(path); // 设置c++dll 的搜索目录
            // 生成 sig 文件
            FileStream f = new FileStream(pri_key_path, FileMode.Open, FileAccess.Read);
            BinaryReader reader = new BinaryReader(f);
            byte[] b = new byte[f.Length];
            reader.Read(b, 0, b.Length);
            string pri_key = Encoding.Default.GetString(b);

            StringBuilder sig = new StringBuilder(4096);
            StringBuilder err_msg = new StringBuilder(4096);
            int ret = sigcheck.tls_gen_sig_ex(
                Convert.ToUInt32(IMRequest.sdkappid),
                identifier,
                sig,
                4096,
                pri_key,
                (UInt32)pri_key.Length,
                err_msg,
                4096);
            if (0 != ret)
            {
                return err_msg.ToString();
            }


            // 校验 sig
            f = new FileStream(pub_key_path, FileMode.Open, FileAccess.Read);
            reader = new BinaryReader(f);
            b = new byte[f.Length];
            reader.Read(b, 0, b.Length);
            string pub_key = Encoding.Default.GetString(b);

            UInt32 expire_time = 0;
            UInt32 init_time = 0;
            ret = sigcheck.tls_vri_sig_ex(
                sig.ToString(),
                pub_key,
                (UInt32)pub_key.Length,
                Convert.ToUInt32(IMRequest.sdkappid),
                identifier,
                ref expire_time,
                ref init_time,
                err_msg,
                4096);

            if (0 != ret)
            {
                return err_msg.ToString();
            }

            //ConfigurationManager.AppSettings.Set("UserSig", sig.ToString());
            return sig.ToString();
        }

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        static extern bool SetDllDirectory(string lpPathName);
    }

    class dllpath
    {

#if DEBUG
        //调试的时候用 32位
        public const string DllPath = "sigcheck32.dll";
#else
        //发布的时候用 64位, 呵呵, 腾讯IM集成太tm繁琐了 
        public const string DllPath = "sigcheck64.dll";       //64 位 dll (此dll 会在 上面 SetDllDirectory 方法设置的目录里面 搜索找到)
#endif

    }

    class sigcheck
    {
        [DllImport(dllpath.DllPath, EntryPoint = "tls_gen_sig", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
        public extern static int tls_gen_sig(
            UInt32 expire,
            string appid3rd,
            UInt32 sdkappid,
            string identifier,
            UInt32 acctype,
            StringBuilder sig,
            UInt32 sig_buff_len,
            string pri_key,
            UInt32 pri_key_len,
            StringBuilder err_msg,
            UInt32 err_msg_buff_len
        );

        [DllImport(dllpath.DllPath, EntryPoint = "tls_vri_sig", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
        public extern static int tls_vri_sig(
            string sig,
            string pub_key,
            UInt32 pub_key_len,
            UInt32 acctype,
            string appid3rd,
            UInt32 sdkappid,
            string identifier,
            StringBuilder err_msg,
            UInt32 err_msg_buff_len
        );

        [DllImport(dllpath.DllPath, EntryPoint = "tls_gen_sig_ex", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
        public extern static int tls_gen_sig_ex(
            UInt32 sdkappid,
            string identifier,
            StringBuilder sig,
            UInt32 sig_buff_len,
            string pri_key,
            UInt32 pri_key_len,
            StringBuilder err_msg,
            UInt32 err_msg_buff_len
        );

        [DllImport(dllpath.DllPath, EntryPoint = "tls_vri_sig_ex", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
        public extern static int tls_vri_sig_ex(
            string sig,
            string pub_key,
            UInt32 pub_key_len,
            UInt32 sdkappid,
            string identifier,
            ref UInt32 expire_time,
            ref UInt32 init_time,
            StringBuilder err_msg,
            UInt32 err_msg_buff_len
        );
    }
}
