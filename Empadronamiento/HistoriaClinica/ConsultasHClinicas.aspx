<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsultasHClinicas.aspx.cs" Inherits="DalSic.HistoriaClinica.ConsultasHClinicas" MasterPageFile= "~/mPaciente.Master" Theme="Login" %>

<%@ Register Assembly="MagicAjax" Namespace="MagicAjax.UI.Controls" TagPrefix="ajax" %>
<asp:Content ID="content0" ContentPlaceHolderID="head" runat="server">
    <script src="../js/jquery-1.12.0.js"></script>
</asp:Content>
<asp:Content ID="content1" ContentPlaceHolderID="Superior" runat="server">
  Historias Clínicas existentes del Paciente
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
<ajax:AjaxPanel ID="AjaxPanel1" runat="server" Width="100%" DefaultButton="btnBuscar">
<div>
Ingrese el Nro del Documento del Paciente: <asp:TextBox ID="txtDni" runat="server" ToolTip="Ingrese el número de Documento a buscar" MaxLength="8" ></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" onclick="btnBuscar_Click" />
<br /><br />
<asp:GridView ID="gvHClinicas" runat="server" CssClass="mGrid" GridLines="None"
        PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="False"
        AllowPaging="True" DataKeyNames="idPaciente">
        <Columns>
          <asp:BoundField DataField="Efector" HeaderText="Efector" />
          <asp:BoundField DataField="historiaclinica" HeaderText="HC" />
          <asp:BoundField DataField="fecharegistro" HeaderText="FechaRegistro" />
        </Columns>
        <PagerStyle CssClass="pgr" />
        <AlternatingRowStyle CssClass="alt" />
      </asp:GridView>
<br /><br />
<asp:Label ID="lblMensaje" runat="server" Text="" CssClass="lblmsn"></asp:Label>
</div>
 </ajax:AjaxPanel>
</asp:Content>