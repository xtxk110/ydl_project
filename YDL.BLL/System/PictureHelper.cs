using System;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace YDL.BLL
{
    public class PictureHelper
    {
        /// <summary>
        /// 获取图片压缩尺寸
        /// </summary>
        /// <param name="newWidth">压缩的目标宽度</param>
        /// <param name="newHeight">压缩的目标高度</param>
        /// <param name="srcWidth">原始图宽度</param>
        /// <param name="srcHeight">原始图高度</param>
        /// <returns></returns>
        static Size GetCompressSize(int newWidth, int newHeight, int srcWidth, int srcHeight)
        {

            double w = 0.0;
            double h = 0.0;
            //宽度大于高度，并原始比例大于等于压缩比列的情况
            if (srcWidth / srcHeight >= newWidth / newHeight)
            {
                if (srcWidth > newWidth)
                {
                    w = newWidth;
                    h = (srcHeight * newWidth) / srcWidth;
                }
                else
                {
                    w = srcWidth;
                    h = srcHeight;
                }
            }
            else//宽度小于高度或者原始比列比压缩比例小
            {
                if (srcHeight > newHeight)
                {
                    h = newHeight;
                    w = (srcWidth * newHeight) / srcHeight;
                }
                else
                {
                    w = srcWidth;
                    h = srcHeight;
                }
            }
            Size size = new Size(Convert.ToInt32(w), Convert.ToInt32(h));
            return size;
        }

        /// <summary>
        /// 通过宽度获取指定图片文件的压缩尺寸
        /// </summary>
        /// <param name="srcFile"></param>
        /// <param name="newWidth"></param>
        /// <returns></returns>
        public static Size GetCompressSizeByWidth(string srcFile, int newWidth)
        {
            using (Image img = Image.FromFile(srcFile))
            {
                var w = 0; var h = 0;
                var srcWidth = img.Width;
                var srcHeight = img.Height;
                if (newWidth < srcWidth)
                {
                    w = newWidth;
                    h = (srcHeight * newWidth) / srcWidth;
                }
                else
                {
                    w = srcWidth;
                    h = srcHeight;
                }

                return new Size(w, h);
            }
        }

        /// <summary>
        /// 通过高度获取指定图片文件的压缩尺寸
        /// </summary>
        /// <param name="srcFile"></param>
        /// <param name="newHeight"></param>
        /// <returns></returns>
        public static Size GetCompressSizeByHeight(string srcFile, int newHeight)
        {
            using (Image img = Image.FromFile(srcFile))
            {
                var w = 0; var h = 0;
                var srcWidth = img.Width;
                var srcHeight = img.Height;
                if (newHeight < srcHeight)
                {
                    h = newHeight;
                    w = (srcWidth * newHeight) / srcHeight;
                }
                else
                {
                    w = srcWidth;
                    h = srcHeight;
                }

                return new Size(w, h);
            }
        }

        /// <summary>
        /// 从字节数组中获取原图
        /// </summary>
        /// <param name="imgbuffer">图片字节数据</param>
        static Image GetSourceImage(byte[] imgbuffer)
        {
            using (System.IO.MemoryStream m = new System.IO.MemoryStream(imgbuffer, 0, imgbuffer.Length))
            {
                return Image.FromStream(m);
            }
        }
        /// <summary>
        /// 从指定磁盘路径中中获取原图
        /// </summary>
        /// <param name="srcImgFilePath">原始图片文件地址</param>
        static Image GetSourceImage(string srcImgFilePath)
        {
            if (System.IO.File.Exists(srcImgFilePath))
                return Image.FromFile(srcImgFilePath);
            else
                throw new Exception(string.Format("找不到图片文件“{0}。”", srcImgFilePath));
        }
        /// <summary>
        /// 压综指定图像
        /// </summary>
        /// <param name="img">原始图片文件对象</param>
        /// <param name="compressWidth">最终压缩的图片宽度,以像素为单位</param>
        /// <param name="compressHeight">最终压缩的图片高度,最终压缩的图片宽度</param>
        static Bitmap DoCompress(Image img, int compressWidth, int compressHeight)
        {
            //新建一个指定大小的画布
            Bitmap outbmp = null;
            Graphics g = null;
            try
            {

                //新建一个指定大小的画布
                outbmp = new Bitmap(compressWidth, compressHeight);
                g = Graphics.FromImage(outbmp);
                Size newsize = GetCompressSize(compressWidth, compressHeight, img.Width, img.Height);
                // 设置画布的描绘质量
                g.CompositingQuality = CompositingQuality.HighSpeed;//设置压缩质量
                g.SmoothingMode = SmoothingMode.HighSpeed;
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.Clear(System.Drawing.Color.Transparent);

                g.DrawImage(img, new Rectangle((compressWidth - newsize.Width) / 2, (compressHeight - newsize.Height) / 2, newsize.Width, newsize.Height), 0, 0, img.Width, img.Height, GraphicsUnit.Pixel);

            }
            catch
            {
                throw;
            }
            finally
            {
                //释放资源
                if (g != null)
                    g.Dispose();
                if (img != null)
                    img.Dispose();
            }

            return outbmp;
        }

        /// <summary>
        /// 压缩指定磁盘路径中的图片
        /// </summary>
        /// <param name="srcImgFilePath">原始图片文件</param>
        /// <param name="compressWidth">最终压缩的图片宽度,以像素为单位</param>
        /// <param name="compressHeight">最终压缩的图片高度,最终压缩的图片宽度</param>
        public static Bitmap Compress(string srcImgFilePath, int compressWidth, int compressHeight)
        {
            return DoCompress(GetSourceImage(srcImgFilePath), compressWidth, compressHeight);
        }

        /// <summary>
        /// 压缩指定字节数组中的图片
        /// </summary>
        /// <param name="imgBuffer">原始图片文件字节数组</param>
        /// <param name="compressWidth">最终压缩的图片宽度,以像素为单位</param>
        /// <param name="compressHeight">最终压缩的图片高度,最终压缩的图片宽度</param>
        public static Bitmap Compress(byte[] imgBuffer, int compressWidth, int compressHeight)
        {
            return DoCompress(GetSourceImage(imgBuffer), compressWidth, compressHeight);
        }
        /// <summary>
        /// 将位图文件转换成字节数组
        /// </summary>
        /// <param name="img">位图文件</param>
        /// <returns></returns>
        public static byte[] ConvertBitmapToByte(Bitmap img)
        {
            if (img == null)
                return null;

            using (System.IO.MemoryStream m = new System.IO.MemoryStream())
            {

                img.Save(m, GetEncoderInfo("image/png"), null);//保存为背景透明的图片
                m.Position = 0;
                return m.ToArray();
            }

        }

        /// <summary>
        /// 将图片格式的GUID转换成相关的格式
        /// </summary>
        /// <param name="guid">图片格式GUID</param>
        /// <returns></returns>
        public static ImageFormat ConvertImgFormat(Guid guid)
        {

            if (guid.Equals(ImageFormat.Bmp.Guid))
                return ImageFormat.Bmp;
            else if (guid.Equals(ImageFormat.Emf.Guid))
                return ImageFormat.Emf;
            else if (guid.Equals(ImageFormat.Exif.Guid))
                return ImageFormat.Exif;
            else if (guid.Equals(ImageFormat.Gif.Guid))
                return ImageFormat.Gif;
            else if (guid.Equals(ImageFormat.Icon.Guid))
                return ImageFormat.Icon;
            else if (guid.Equals(ImageFormat.Jpeg.Guid))
                return ImageFormat.Jpeg;
            else if (guid.Equals(ImageFormat.MemoryBmp.Guid))
                return ImageFormat.MemoryBmp;
            else if (guid.Equals(ImageFormat.Png.Guid))
                return ImageFormat.Png;
            else if (guid.Equals(ImageFormat.Tiff.Guid))
                return ImageFormat.Tiff;
            else if (guid.Equals(ImageFormat.Wmf.Guid))
                return ImageFormat.Wmf;
            else
                return ImageFormat.Jpeg;
        }
        /// <summary>
        /// 跟据扩展名获取图片编码格式
        /// </summary>
        /// <param name="extname">不含句点“.”的图片扩展名</param>
        /// <returns></returns>
        public static string GetMimeType(string extname)
        {
            switch (extname.ToLower())
            {
                case "jpg":
                    return "image/jpeg";
                case "gif":
                    return "image/gif";
                case "bmp":
                    return "image/bmp";
                case "png":
                    return "image/png";
                case "tiff":
                    return "image/tiff";
                default:
                    return "image/jpeg";
            }
        }
        /// <summary>
        /// 获取图片保存在内存流时的编码格式
        /// </summary>
        /// <param name="mimeType">图片类型</param>
        /// <returns></returns>
        public static ImageCodecInfo GetEncoderInfo(String mimeType)
        {
            foreach (ImageCodecInfo codec in ImageCodecInfo.GetImageEncoders())
            {
                if (codec.MimeType == mimeType)
                    return codec;
            }
            return null;
        }



        /// <summary>
        /// 按指定大小压缩图片
        /// </summary>
        /// <param name="sFile">原图片</param>
        /// <param name="dFile">压缩后保存位置</param>
        /// <param name="dHeight">高度</param>
        /// <param name="dWidth"></param>
        /// <param name="flag">压缩质量 1-100</param>
        /// <returns></returns>
        public static string GetPicThumbnail(string sFile, int? dHeight, int? dWidth, int flag)
        {
            //if (!dHeight.HasValue && !dWidth.HasValue) return null;
            System.Drawing.Image iSource = System.Drawing.Image.FromFile(sFile);
            if (!dHeight.HasValue && !dWidth.HasValue)
            {
                dWidth = iSource.Width;
                dHeight = iSource.Height;
            }
            else if (!dHeight.HasValue)
            {
                if (dWidth.Value < iSource.Width)
                {
                    dHeight = (dWidth.Value * iSource.Height) / iSource.Width;
                }
                else
                {
                    dWidth = iSource.Width;
                    dHeight = iSource.Height;
                }
            }
            else if (!dWidth.HasValue)
            {
                if (dHeight.Value < iSource.Height)
                {
                    dWidth = (dHeight.Value * iSource.Width) / iSource.Height;
                }
                else
                {
                    dWidth = iSource.Width;
                    dHeight = iSource.Height;
                }
            }
            else
            {
                if (iSource.Height > dHeight || iSource.Width > dWidth) //将**改成c#中的或者操作符号
                {
                    if ((iSource.Width * dHeight) > (iSource.Height * dWidth))
                    {
                        dHeight = (dWidth.Value * iSource.Height) / iSource.Width;
                    }
                    else
                    {
                        dWidth = (iSource.Width * dHeight.Value) / iSource.Height;
                    }
                }
                else
                {
                    dWidth = iSource.Width;
                    dHeight = iSource.Height;
                }
            }

            string dFile = Path.Combine(System.IO.Path.GetDirectoryName(sFile), string.Format("{0}_{1}x{2}.{3}", Path.GetFileNameWithoutExtension(sFile), dWidth.Value, dHeight.Value, Path.GetExtension(sFile)));
            if (System.IO.File.Exists(dFile))
            {
                return dFile;
            }
            ImageFormat tFormat = iSource.RawFormat;

            Bitmap ob = new Bitmap(dWidth.Value, dHeight.Value);
            Graphics g = Graphics.FromImage(ob);
            g.Clear(System.Drawing.Color.WhiteSmoke);

            g.CompositingQuality = CompositingQuality.Default;
            g.SmoothingMode = SmoothingMode.Default;
            g.InterpolationMode = InterpolationMode.Default;

            /* 无损图像
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            */
            g.DrawImage(iSource, new Rectangle(0, 0, dWidth.Value, dHeight.Value), 0, 0, iSource.Width, iSource.Height, GraphicsUnit.Pixel);
            g.Dispose();
            //以下代码为保存图片时，设置压缩质量

            EncoderParameters ep = new EncoderParameters();
            long[] qy = new long[1];
            qy[0] = flag;//设置压缩的比例1-100
            EncoderParameter eParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, qy);
            ep.Param[0] = eParam;

            try
            {
                ImageCodecInfo[] arrayICI = ImageCodecInfo.GetImageEncoders();
                ImageCodecInfo jpegICIinfo = null;
                for (int x = 0; x < arrayICI.Length; x++)
                {
                    if (arrayICI[x].FormatDescription.Equals("JPEG"))
                    {
                        jpegICIinfo = arrayICI[x];
                        break;
                    }
                }

                if (jpegICIinfo != null)
                {
                    ob.Save(dFile, jpegICIinfo, ep);//dFile是压缩后的新路径
                }
                else
                {
                    ob.Save(dFile, tFormat);
                }
                return dFile;
            }
            catch
            {
                return null;
            }

            finally
            {
                iSource.Dispose();
                ob.Dispose();
            }
        }
    }
}
