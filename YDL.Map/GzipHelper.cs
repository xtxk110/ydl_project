using System.IO;
using System.IO.Compression;
using System;
using System.Runtime.Serialization.Formatters.Binary;

namespace YDL.Map
{
    public class GzipHelper
    {
        public static string Compress(string rawString)
        {
            if (string.IsNullOrEmpty(rawString) || rawString.Length == 0)
            {
                return string.Empty;
            }
            else
            {
                byte[] rawData = System.Text.Encoding.UTF8.GetBytes(rawString.ToString());
                byte[] zippedData = Compress(rawData);
                return (string)(Convert.ToBase64String(zippedData));
            }
        }

        static byte[] Compress(byte[] rawData)
        {
            MemoryStream ms = new MemoryStream();
            GZipStream compressedzipStream = new GZipStream(ms, CompressionMode.Compress, true);
            compressedzipStream.Write(rawData, 0, rawData.Length);
            compressedzipStream.Close();
            return ms.ToArray();
        }

        public static string Decompress(string zippedString)
        {
            if (string.IsNullOrEmpty(zippedString) || zippedString.Length == 0)
            {
                return string.Empty;
            }
            else
            {
                byte[] zippedData = Convert.FromBase64String(zippedString.ToString());
                return (string)(System.Text.Encoding.UTF8.GetString(Decompress(zippedData)));
            }
        }

        static byte[] Decompress(byte[] zippedData)
        {
            MemoryStream ms = new MemoryStream(zippedData);
            GZipStream compressedzipStream = new GZipStream(ms, CompressionMode.Decompress);
            MemoryStream outBuffer = new MemoryStream();
            byte[] block = new byte[1024];
            while (true)
            {
                int bytesRead = compressedzipStream.Read(block, 0, block.Length);
                if (bytesRead <= 0)
                    break;
                else
                    outBuffer.Write(block, 0, bytesRead);
            }
            compressedzipStream.Close();
            return outBuffer.ToArray();
        }

        static object Decompress1(byte[] bytes)
        {
            if (bytes == null) return null;
            MemoryStream mStream = new MemoryStream(bytes);
            mStream.Seek(0, SeekOrigin.Begin);
            DeflateStream unZipStream = new DeflateStream(mStream, CompressionMode.Decompress, true);
            object dsResult = null;
            BinaryFormatter bFormatter = new BinaryFormatter();
            dsResult = (object)bFormatter.Deserialize(unZipStream);
            return dsResult;
        }
    }
}
