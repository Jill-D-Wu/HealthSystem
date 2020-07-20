<%@ Page Language="C#" MasterPageFile="Site.master" CodeBehind="Default.aspx.cs" Inherits="RentalLedger._Default" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />
    I built this full fledge health system for patients, for medical professionals, for researchers, for administrators, and also for decision makers. You can 
    <ul>
        <li>click <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Patients/List.aspx">the Patients page</asp:HyperLink> to insert new patient, view existing patients</li>
        <li>click <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="Appointments/List.aspx">the Appointments page</asp:HyperLink> to make a new appointment, view and change existing appointments</li>
        <li>click <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="Diagnoses/List.aspx">the Diagnoses page</asp:HyperLink> to insert new Diagnose, view existing Diagnoses and their studies</li>
        <li>click <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="Studies/List.aspx">the Studies page</asp:HyperLink> to insert new Studies, view existing Studies and search studies based on its </li>
        <li>click <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="CheckTreatments1/List.aspx">the Check Treatments page</asp:HyperLink> to check whether you missing any treatment or wrong prescriptions </li>
        <li>and more and more ....... 
            <ul>
                <li>click <asp:HyperLink ID="HyperLink10" runat="server" NavigateUrl="InterventionTypes/Details.aspx?InterventionTypeID=5">all the new Diagnostic Tests for Covid-19</asp:HyperLink></li>
                <li>click <asp:HyperLink ID="HyperLink9" runat="server" NavigateUrl="InterventionTypes/Details.aspx?InterventionTypeID=7">all the new drugs for Covid-19</asp:HyperLink></li>
                <li>click <asp:HyperLink ID="HyperLink11" runat="server" NavigateUrl="InterventionTypes/Details.aspx?InterventionTypeID=2">all the new Biological Interventions for Covid-19</asp:HyperLink></li>
                <li>click <asp:HyperLink ID="HyperLink12" runat="server" NavigateUrl="InterventionTypes/Details.aspx?InterventionTypeID=10">all the new Procedures for Covid-19</asp:HyperLink></li>
                <li>and more, just find yourself</li>
            </ul>
        </li>
        <li>I have collected almost all clinical studies for Covid-19, they perform clinical trials world wide, if you want to check all the studies in your country or city, just go to <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="Countries/List.aspx">the Countries page</asp:HyperLink> or <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="Cities/List.aspx">the Cities page</asp:HyperLink>, on the search box entering your country name or city name, then click the search, to find your country or city. You will see all the studies on your city, click each study name to see details about the study. If you have Covid-19 symptoms looking for new treatment, you can use my system to find the studies suitable to your location, age, gender, and symptoms  </li>
    </ul>
    This is a huge system built on big data, here's the video for introduction, enjoy the power release from NoSQL database in fighting the Coronavirus and other diseases.<br />
    <iframe width="560" height="315" src="https://www.youtube.com/embed/UkA42RTqCrE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    <table class="auto-style1" style="vertical-align:top">
        <tr style="vertical-align:top">
            <td>
                <asp:GridView ID="gMain" runat="server" AutoGenerateColumns="false"
                    CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:TemplateField HeaderText="Health System" SortExpression="TableName">
                            <ItemTemplate>
                                <asp:DynamicHyperLink ID="HyperLink1" runat="server"><%# Eval("DisplayName") %></asp:DynamicHyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>

    <br /><br />

 
</asp:Content>


