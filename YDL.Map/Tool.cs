using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;

using YDL.Core;

namespace YDL.Map
{
    internal static class Tool
    {
        internal const string DBConnectionString = "ConnectionString";

        internal const string Proc_GetTreeId = "pg_GetTreeId";
        internal const string Proc_GetGlobalNo = "cp_GetGlobalNo";
        internal const string Proc_PageData = "cp_PageData";

        internal const string Proc_Param_Msg = "@message";
        internal const string Proc_Param_Count = "@totalcount";
        internal const string Proc_Param_GlobalNo = "@GlobalNo";
        internal const string Proc_Param_Id = "@id";
        internal const string Proc_Param_Table = "@table";
        internal const string Proc_Param_Sql = "@sql";
        internal const string Proc_Param_CountSql = "@countsql";
        internal const string ProcPage_Suffix = "WithPage";

        internal const string Field_RowState = "RowState";

        internal const char Chr_PlusSign = '+';
        internal const char Chr_Comma = ',';
        internal const char Chr_Group = ';';
        internal const char Chr_Point = '.';
        internal const char Chr_Blank = ' ';
        internal const char Chr_Single = '\'';
        internal const char Chr_Double = '\"';
        internal const char Chr_Semicolon = ';';
        internal const char Chr_Zero = '0';
        internal const char Chr_Alpha = '@';

        internal const string Str_Semicolon = ";";
        internal const string Str_PlusSign = "+";
        internal const string Str_Blank = " ";
        internal const string Str_Comma = ",";
        internal const string Str_Point = ".";
        internal const string Str_Single = "\'";
        internal const string Str_Zero = "0";
        internal const string Str_Alpha = "@";

        internal const string Str_LeftSquare = "[";
        internal const string Str_RightSquare = "]";
        internal const string Str_LeftBracket = "{";
        internal const string Str_RightBracket = "}";

        internal const string DateTimeFormat = "yyyy-MM-dd HH:mm:ss";

        internal const string EntityFullName = "EntityFullName";

        public static DbParameter GetProcMsgParam(this DbCommand cmdProc)
        {
            if (cmdProc.CommandType == CommandType.StoredProcedure)
            {
                return cmdProc.FirstOrDefault(Tool.Proc_Param_Msg);
            }
            return null;
        }

        public static DbParameter FirstOrDefault(this DbCommand cmd, string name)
        {
            foreach (DbParameter obj in cmd.Parameters)
            {
                if (obj.ParameterName.Equals(name, StringComparison.OrdinalIgnoreCase))
                {
                    return obj;
                }
            }
            return null;
        }

        public static void SetListOutParam(DbCommand cmd, List<OutParam> listOutParam)
        {
            foreach (DbParameter obj in cmd.Parameters)
            {
                if (obj.Direction == ParameterDirection.Output && obj.ParameterName != Tool.Proc_Param_Msg)
                {
                    listOutParam.Add(new OutParam() { Name = obj.ParameterName, value = obj.Value });
                }
            }
        }

        public static void TryAttachTran(this IDbCommand cmd, IDbTransaction tran)
        {
            if (cmd != null && tran != null)
            {
                cmd.Transaction = tran;
            }
        }
    }
}
