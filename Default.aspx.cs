using System;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Linq;
using System.Collections.Generic;

namespace RentalLedger
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Collections.IList visibleTables = Global.DefaultModel.VisibleTables;
            if (visibleTables.Count == 0)
            {
                throw new InvalidOperationException("There are no accessible tables. Make sure that at least one data model is registered in Global.asax and scaffolding is enabled or implement custom pages.");
            }
            
            gMain.DataSource = Global.DefaultModel.VisibleTables.Where(x => (x.DisplayName.Substring(0, 2) != "lu"
                && !(x.DisplayName.Contains("WebSite"))
                && !(x.DisplayName.Contains("Case") || x.DisplayName.Contains("Day5Notice"))));
            gMain.DataBind();

            //glu.DataSource = Global.DefaultModel.VisibleTables.Where(x => x.DisplayName.Substring(0, 2) == "lu");
            //glu.DataBind();

            //gWebSite.DataSource = Global.DefaultModel.VisibleTables.Where(x => x.DisplayName.Contains("WebSite"));
            //gWebSite.DataBind();

            //gCase.DataSource = Global.DefaultModel.VisibleTables.Where(x => (x.DisplayName.Contains("Case")
            //    || x.DisplayName.Contains("Day5Notice")));
            //gCase.DataBind();
            
        }

    }
}
