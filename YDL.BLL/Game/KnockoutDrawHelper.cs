using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.BLL
{
    public class KnockoutDrawHelper
    {
        public static List<int> CalRankPosAndSort(int total, int knockout, int rank)
        {
            var result = CalRankPos(total, knockout, rank);
            if (knockout <= 2)
            {
                result = SortIndexFor2(total, rank);
            }
            else
            {
                result = SortIndexFor4(result, rank);
            }
            return result;
        }

        public static List<int> CalRankPos(int total, int knockout, int rank)
        {
            List<int> result = new List<int>();
            int temp = 1;
            while (temp * knockout <= total)
            {
                int index = 0;
                switch (rank)
                {
                    case 1:
                        index = temp % 2 == 1 ? (temp - 1) * knockout : temp * knockout - 1;
                        break;

                    case 2:
                        index = temp % 2 == 1 ? temp * knockout - 1 : (temp - 1) * knockout + 1 - 1;
                        break;

                    case 3:
                        index = temp % 2 == 1 ? temp * knockout - 1 - 1 : temp * knockout - 2 - 1;
                        break;

                    default:
                        index = temp % 2 == 1 ? temp * knockout - 2 - 1 : temp * knockout - 1 - 1;
                        break;
                }
                result.Add(index);
                temp++;
            }
            return result;
        }

        public static List<int> SortIndexFor4(List<int> source, int rank)
        {
            List<int> firstOrders = new List<int>();
            bool isOut = true;
            bool isUp = rank % 2 == 1;
            if (rank == 1)
            {
                isOut = true;
                while (source.Count > 0)
                {
                    if (isOut)
                    {
                        var first = source.First();
                        var last = source.Last();

                        firstOrders.Add(isUp ? first : last);
                        firstOrders.Add(isUp ? last : first);
                        isUp = !isUp;
                        source.Remove(first);
                        source.Remove(last);

                        if (source.Count > 2)
                        {
                            var first1 = source[source.Count / 2 - 1];
                            var last1 = source[source.Count / 2];

                            firstOrders.Add(isUp ? first1 : last1);
                            firstOrders.Add(isUp ? last1 : first1);
                            isUp = !isUp;

                            source.Remove(first1);
                            source.Remove(last1);
                        }
                    }
                    else
                    {
                        var first1 = source[source.Count / 2 - 1];
                        var last1 = source[source.Count / 2];

                        firstOrders.Add(isUp ? first1 : last1);
                        firstOrders.Add(isUp ? last1 : first1);
                        isUp = !isUp;

                        source.Remove(first1);
                        source.Remove(last1);

                        if (source.Count > 2)
                        {
                            var first = source.First();
                            var last = source.Last();

                            firstOrders.Add(isUp ? first : last);
                            firstOrders.Add(isUp ? last : first);
                            isUp = !isUp;

                            source.Remove(first);
                            source.Remove(last);
                        }
                    }
                    isOut = !isOut;
                }
            }
            else if (rank == 2)
            {
                while (source.Count > 0)
                {
                    var first = source.First();
                    var last = source.Last();

                    firstOrders.Add(isUp ? first : last);
                    firstOrders.Add(isUp ? last : first);
                    isUp = !isUp;
                    source.Remove(first);
                    source.Remove(last);
                }
            }
            else if (rank == 3)
            {
                isOut = false;
                while (source.Count > 0)
                {
                    if (isOut)
                    {
                        var first = source.First();
                        var last = source.Last();

                        firstOrders.Add(isUp ? first : last);
                        firstOrders.Add(isUp ? last : first);
                        isUp = !isUp;
                        source.Remove(first);
                        source.Remove(last);

                        if (source.Count > 2)
                        {
                            var first1 = source[source.Count / 2 - 1];
                            var last1 = source[source.Count / 2];

                            firstOrders.Add(isUp ? first1 : last1);
                            firstOrders.Add(isUp ? last1 : first1);
                            isUp = !isUp;

                            source.Remove(first1);
                            source.Remove(last1);
                        }
                    }
                    else
                    {
                        var first1 = source[source.Count / 2 - 1];
                        var last1 = source[source.Count / 2];

                        firstOrders.Add(isUp ? first1 : last1);
                        firstOrders.Add(isUp ? last1 : first1);
                        isUp = !isUp;

                        source.Remove(first1);
                        source.Remove(last1);

                        if (source.Count > 2)
                        {
                            var first = source.First();
                            var last = source.Last();

                            firstOrders.Add(isUp ? first : last);
                            firstOrders.Add(isUp ? last : first);
                            isUp = !isUp;

                            source.Remove(first);
                            source.Remove(last);
                        }
                    }
                    isOut = !isOut;
                }
            }
            else if (rank == 4)
            {
                while (source.Count > 0)
                {
                    var first1 = source[source.Count / 2 - 1];
                    var last1 = source[source.Count / 2];

                    firstOrders.Add(isUp ? first1 : last1);
                    firstOrders.Add(isUp ? last1 : first1);
                    isUp = !isUp;

                    source.Remove(first1);
                    source.Remove(last1);
                }
            }
            return firstOrders;
        }

        public static List<int> SortIndexFor2(int total, int rank)
        {
            List<int> result = null;
            if (rank == 1)
            {
                result = new List<int>();
                int pow = (int)Math.Log(total, 2);
                for (int i = pow; i > 0; i--)
                {
                    if (result.Count < total / 2)
                    {
                        int step = (int)Math.Pow(2, i);
                        if (step == total)
                        {
                            result.Add(1 - 1);
                            result.Add(total - 1);
                        }
                        else
                        {
                            int part = total / step;
                            for (int j = 1; j <= part / 2; j++)
                            {
                                if (j % 2 == 1)
                                {
                                    result.Add(j * step - 1);
                                    result.Add(total + 1 - (j * step) - 1);
                                    if (part > 2)
                                    {
                                        result.Add(j * step + 1 - 1);
                                        result.Add(total + 1 - (j * step + 1) - 1);
                                    }
                                }
                            }
                        }
                    }
                }
                //平衡实力指数
                for (int i = 0; i < result.Count / 2; i++)
                {
                    if (i % 2 == 1)
                    {
                        var temp = result[i * 2];
                        result[i * 2] = result[i * 2 + 1];
                        result[i * 2 + 1] = temp;
                    }
                }
            }
            else
            {
                result = SortIndexFor2(total, 1);
                for (int i = 0; i < total / 2; i++)
                {
                    if (result[i] % 2 == 0)
                    {
                        result[i] = total - 2 - result[i];
                    }
                    else
                    {
                        result[i] = total - result[i];
                    }
                }
            }
            return result;
        }

    }
}
