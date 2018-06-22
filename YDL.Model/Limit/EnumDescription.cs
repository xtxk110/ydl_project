﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
  public static  class EnumDescription
    {
        public static string GetEnumDescription(this Enum enumValue)
             {
                string value = enumValue.ToString();
               FieldInfo field = enumValue.GetType().GetField(value);
               object[] objs = field.GetCustomAttributes(typeof(DescriptionAttribute), false);    //获取描述属性
                if (objs.Length == 0)    //当描述属性没有时，直接返回名称
                    return value;
                DescriptionAttribute descriptionAttribute = (DescriptionAttribute)objs[0];
                return descriptionAttribute.Description;
           }
    }
}
