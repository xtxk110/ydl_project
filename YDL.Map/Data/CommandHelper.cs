using System.Collections.Generic;
using System.Data;

using YDL.Core;
using YDL.Utility;
using YDL.Model;

namespace YDL.Map
{
    public static class CommandHelper
    {
        public static Command CreateText(FetchType fetchType = FetchType.Fetch, string text = null)
        {
            var p = Command.CreateInstance();
            p.CmdType = CommandType.Text;
            if (text.IsNotNullOrEmpty())
            {
                p.Text = text;
            }
            p.FetchType = fetchType;
            return p;
        }

        public static Command CreateText<T>(FetchType fetchType = FetchType.Fetch, string text = null)
        {
            var p = Command.CreateInstance();
            p.CmdType = CommandType.Text;
            if (text.IsNotNullOrEmpty())
            {
                p.Text = text;
            }
            p.FetchType = fetchType;
            p.EntityType = typeof(T).AssemblyQualifiedName;
            return p;
        }

        public static Command CreateProcedure(FetchType fetchType = FetchType.Fetch, string text = null)
        {
            var p = Command.CreateInstance();
            p.FetchType = fetchType;
            p.CmdType = CommandType.StoredProcedure;
            if (text.IsNotNullOrEmpty())
            {
                p.Text = text;
            }
            return p;
        }

        public static Command CreateProcedure<T>(FetchType fetchType = FetchType.Fetch, string text = null)
        {
            var p = Command.CreateInstance();
            p.FetchType = fetchType;
            p.CmdType = CommandType.StoredProcedure;
            if (text.IsNotNullOrEmpty())
            {
                p.Text = text;
            }
            p.EntityType = typeof(T).AssemblyQualifiedName;
            return p;
        }

        public static Command CreateSave(EntityBase entity, List<Command> commands = null)
        {
            return CreateSave(new List<EntityBase> { entity }, commands);
        }

        public static Command CreateSave(List<EntityBase> entities, List<Command> commands = null)
        {
            var cmd = Command.CreateInstance();
            cmd.FetchType = FetchType.Save;
            if (entities != null && entities.Count > 0)
            {
                cmd.Entities = entities;
            }
            if (commands != null && commands.Count > 0)
            {
                cmd.AfterCommands = commands;
            }
            return cmd;
        }

        public static Command CreateSave<T>(List<T> entities, List<Command> commands = null) where T : EntityBase
        {
            return CreateSave(ToBaseList<T>(entities), commands);
        }

        public static void Add(this List<DbParam> dbParams, string paramName, object paramValue, DataType dbType = DataType.String, ParamDirection direction = ParamDirection.Input, int size = 1) {
            dbParams.Add(CreateParam(paramName, paramValue, dbType, direction, size));
        }

        public static DbParam CreateParam(string paramName, object paramValue, DataType dbType = DataType.String, ParamDirection direction = ParamDirection.Input, int size = 1)
        {
            var result = new DbParam() { Type = dbType, Direction = direction, Name = paramName };
            if (direction != ParamDirection.Output && paramValue != null)
            {
                result.Value = paramValue;
            }
            if (direction == ParamDirection.Output && dbType == DataType.String)
            {
                result.Size = size;
            }
            return result;
        }

        public static void CreateParamPager(this Command command, FilterBase filter)
        {
            command.Params.Add(CommandHelper.CreateParam("@pageIndex", filter.PageIndex));
            command.Params.Add(CommandHelper.CreateParam("@pageSize", filter.PageSize));
            command.Params.Add(CommandHelper.CreateParam("@rowCount", 0, DataType.Int32, ParamDirection.Output));
        }

        public static void CreateParamUser(this Command command, string currentUserId)
        {
            command.Params.Add(CommandHelper.CreateParam("@userId", currentUserId));
        }

        public static void CreateParamId(this Command command, string id)
        {
            command.Params.Add(CommandHelper.CreateParam("@id", id));
        }

        public static void CreateParamMsg(this Command command)
        {
            command.Params.Add(CommandHelper.CreateParam(Tool.Proc_Param_Msg, null, DataType.String, ParamDirection.Output, 200));
        }

        public static void CreateParamActionCode(this Command command,RowState rowState)
        {
            command.Params.Add(CommandHelper.CreateParam("@actionCode", (int)rowState, DataType.Int32));
        }

        private static List<EntityBase> ToBaseList<T>(this List<T> entities) where T : EntityBase
        {
            List<EntityBase> result = new List<EntityBase>();
            foreach (var obj in entities)
            {
                result.Add(obj);
            }
            return result;
        }
    }
}
