
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Utility;
using YDL.Core;

namespace YDL.BLL
{
    /// <summary>
    /// 获取比分竞猜的比分列表
    /// </summary>
    public class GetGuessVSScoreList_188 : IServiceBase
    {

        public Response Execute(User currentUser, string request)
        {
            var req = JsonConvert.DeserializeObject<Request<GetGuessRelatedFilter>>(request);
            Response rsp = ResultHelper.CreateResponse();
            rsp.IsSuccess = true;
            if (req.Filter.WinNumber == 3)
            {
                rsp.Entities.AddRange(GetFiveHitThreeVictory());
            }
            else if (req.Filter.WinNumber == 2)
            {
                rsp.Entities.AddRange(GetThreeHitTwoVictory());
            }
            else if(req.Filter.WinNumber==4)
            {
                rsp.Entities.AddRange(GetSevenHitFourVictory());
            }
            //所有的赔率默认值给2
            foreach (var item in rsp.Entities)
            {
                var guessScore = item as GuessScore;
                guessScore.Odds = 2;
            }
            return rsp;
        }


        private List<GuessScore> GetThreeHitTwoVictory()
        {
            var list = new List<GuessScore>();
            GuessScore obj1 = new GuessScore();
            obj1.LeftScore = 2;
            obj1.RightScore = 0;
            list.Add(obj1);

            GuessScore obj2 = new GuessScore();
            obj2.LeftScore = 2;
            obj2.RightScore = 1;
            list.Add(obj2);

            GuessScore obj3 = new GuessScore();
            obj3.LeftScore = 1;
            obj3.RightScore = 2;
            list.Add(obj3);

            GuessScore obj4 = new GuessScore();
            obj4.LeftScore = 0;
            obj4.RightScore = 2;
            list.Add(obj4);

            return list;

        }

        private List<GuessScore> GetFiveHitThreeVictory()
        {
            var list = new List<GuessScore>();
            GuessScore obj1 = new GuessScore();
            obj1.LeftScore = 3;
            obj1.RightScore = 0;
            list.Add(obj1);

            GuessScore obj2 = new GuessScore();
            obj2.LeftScore = 3;
            obj2.RightScore = 1;
            list.Add(obj2);

            GuessScore obj3 = new GuessScore();
            obj3.LeftScore = 3;
            obj3.RightScore = 2;
            list.Add(obj3);

            GuessScore obj4 = new GuessScore();
            obj4.LeftScore = 2;
            obj4.RightScore = 3;
            list.Add(obj4);

            GuessScore obj5 = new GuessScore();
            obj5.LeftScore = 1;
            obj5.RightScore = 3;
            list.Add(obj5);

            GuessScore obj6 = new GuessScore();
            obj6.LeftScore = 0;
            obj6.RightScore = 3;
            list.Add(obj6);

            return list;

        }

        private List<GuessScore> GetSevenHitFourVictory()
        {
            var list = new List<GuessScore>();
            GuessScore obj1 = new GuessScore();
            obj1.LeftScore = 4;
            obj1.RightScore = 0;
            list.Add(obj1);

            GuessScore obj2 = new GuessScore();
            obj2.LeftScore = 4;
            obj2.RightScore = 1;
            list.Add(obj2);

            GuessScore obj3 = new GuessScore();
            obj3.LeftScore = 4;
            obj3.RightScore = 2;
            list.Add(obj3);

            GuessScore obj4 = new GuessScore();
            obj4.LeftScore = 4;
            obj4.RightScore = 3;
            list.Add(obj4);

            GuessScore obj5 = new GuessScore();
            obj5.LeftScore = 0;
            obj5.RightScore = 4;
            list.Add(obj5);

            GuessScore obj6 = new GuessScore();
            obj6.LeftScore = 1;
            obj6.RightScore = 4;
            list.Add(obj6);

            GuessScore obj7= new GuessScore();
            obj7.LeftScore = 2;
            obj7.RightScore = 4;
            list.Add(obj7);

            GuessScore obj8 = new GuessScore();
            obj8.LeftScore = 3;
            obj8.RightScore = 4;
            list.Add(obj8);



            return list;

        }


    }

}
