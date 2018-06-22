using System;
using System.Linq;
using System.Collections.Generic;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    interface IWaiver
    {
        void SetScore(EntityBase loopObj);

        void SetWaiver(EntityBase loopObj); 
    }
}
