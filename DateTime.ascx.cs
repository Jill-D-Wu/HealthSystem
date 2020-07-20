using System;
using System.Collections.Specialized;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RentalLedger
{
    public partial class DateTimeField : System.Web.DynamicData.FieldTemplateUserControl
    {
        public override string FieldValueString
        {
            get
            {
                string value = base.FieldValueString;
                if (value != null)
                {
                    DateTime dt;
                    if(DateTime.TryParse(value, out dt))
                    {
                        if(dt.Hour==0 && dt.Minute==0 && dt.Second==0)
                            value = dt.ToShortDateString();
                    }
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
