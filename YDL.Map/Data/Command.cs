using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Data;
using YDL.Core;

namespace YDL.Map
{
    public class Command
    {
        public string Token { get; set; }

        public FetchType FetchType { get; set; }

        public CommandType CmdType { get; set; }

        public string Text { get; set; }

        public List<DbParam> Params { get; set; }

        public string EntityType { get; set; }

        public List<EntityBase> Entities { get; set; }

        public List<TableFieldPair> OnlyFields { get; set; }

        public List<TableFieldPair> NotFields { get; set; }

        public List<TableProcedurePair> Procedures { get; set; }

        public List<Command> PreCommands { get; set; }

        public List<Command> AfterCommands { get; set; }

        public object Tag { get; set; }

        private Command()
        {
            Params = new List<DbParam>();
            Entities = new List<EntityBase>();
            AfterCommands = new List<Command>();
            PreCommands = new List<Command>();
        }

        public static Command CreateInstance()
        {
            return new Command();
        }

    }
}
