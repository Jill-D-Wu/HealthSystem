using System;
using System.Collections.Specialized;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RentalLedger
{
    public partial class ForeignKey_EditField : System.Web.DynamicData.FieldTemplateUserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (DropDownList1.Items.Count == 0)
            {
                if (Mode == DataBoundControlMode.Insert || !Column.IsRequired)
                {
                    DropDownList1.Items.Add(new ListItem("[Not Set]", ""));
                }
                PopulateListControl(DropDownList1);
                SortDDL(ref DropDownList1);
                //DropDownList placeholder = new DropDownList();
                //PopulateListControl(placeholder);

                //int i = 0;
                //foreach (ListItem item in placeholder.Items)
                //{
                //    //DropDownList1.Items.Add(new ListItem(item.Text, item.Value));
                //    if (DropDownList1.Items.Count == 0)
                //    {
                //        DropDownList1.Items.Add(new ListItem(item.Text, item.Value));
                //    }
                //    else
                //    {
                //        foreach (ListItem insdieItem in DropDownList1.Items)
                //        {
                //            if (item.Text[0] > insdieItem.Text[0])
                //            {
                //                DropDownList1.Items.Insert(i - 1, new ListItem(item.Text, item.Value));
                //            }
                //        }
                //    }
                //    i++;
                //}
            }

            SetUpValidator(RequiredFieldValidator1);
            SetUpValidator(DynamicValidator1);
        }

        protected override void OnDataBinding(EventArgs e)
        {
            base.OnDataBinding(e);

            string selectedValueString = GetSelectedValueString();
            ListItem item = DropDownList1.Items.FindByValue(selectedValueString);
            if (item != null)
            {
                DropDownList1.SelectedValue = selectedValueString;
            }

        }

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            // If it's an empty string, change it to null
            string value = DropDownList1.SelectedValue;
            if (String.IsNullOrEmpty(value))
            {
                value = null;
            }

            ExtractForeignKey(dictionary, value);
        }

        public override Control DataControl
        {
            get
            {
                return DropDownList1;
            }
        }

        public static void SortDDL(ref DropDownList objDDL)
        {
            System.Collections.ArrayList textList = new System.Collections.ArrayList();
            System.Collections.ArrayList valueList = new System.Collections.ArrayList();


            foreach (ListItem li in objDDL.Items)
            {
                textList.Add(li.Text);
            }

            textList.Sort();


            foreach (object item in textList)
            {
                string value = objDDL.Items.FindByText(item.ToString()).Value;
                valueList.Add(value);
            }
            objDDL.Items.Clear();

            for (int i = 0; i < textList.Count; i++)
            {
                ListItem objItem = new ListItem(textList[i].ToString(), valueList[i].ToString());
                objDDL.Items.Add(objItem);
            }
        }
    }
}
