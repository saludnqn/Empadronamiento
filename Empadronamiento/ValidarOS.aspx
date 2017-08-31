<%@ Page Title="" Language="C#" MasterPageFile="~/login.Master" AutoEventWireup="true" Theme="Login" CodeBehind="ValidarOS.aspx.cs" Inherits="Empadronamiento.ValidarOS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Encabezado" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
Verificación en Planes o Programas
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Cuerpo" runat="server">
  <label>
    Plan Nacer:</label>
  <asp:HyperLink ID="hlPlanNacer" runat="server" Text="Plan Nacer" ForeColor="#00898c"></asp:HyperLink>
  <br />
  <%--<label>
    Remediar Redes:</label>
  <asp:HyperLink ID="hlRemediarRedes" runat="server" Text="Remediar Redes"></asp:HyperLink>--%>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Botones" runat="server">
</asp:Content>
