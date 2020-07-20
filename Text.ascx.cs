using System;
using System.Collections.Specialized;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RentalLedger
{
    public partial class TextField : System.Web.DynamicData.FieldTemplateUserControl
    {
        private const int MAX_DISPLAYLENGTH_IN_LIST = 25;

        public override string FieldValueString
        {
            get
            {
                string value = base.FieldValueString;
                if (ContainerType == ContainerType.List)
                {
                    if (value != null && value.Length > MAX_DISPLAYLENGTH_IN_LIST)
                    {
                        value = value.Substring(0, MAX_DISPLAYLENGTH_IN_LIST - 3) + "...";
                    }
                }
                if(value.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || value.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                {
                    value = "<a href='" + base.FieldValueString + "'>" + value + "</a>";
                }
                return value;
            }
        }

        public override Control DataControl
        {
            get
            {
                return Literal1;
            }
        }

    }
}
