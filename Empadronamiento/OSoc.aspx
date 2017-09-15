<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OSoc.aspx.cs" Inherits="Empadronamiento.OSoc" MasterPageFile="~/login.Master" %>

<%@ Register Src="~/UserControls/ObrasSociales.ascx" TagName="OSociales" TagPrefix="uc1" %>
    
<asp:Content ID="content1" ContentPlaceHolderID="Encabezado" runat="server">
    <%-- Scripts globales --%>
    <script type="text/javascript" src='<%= ResolveUrl("~/ControlMenor/js/jquery-1.5.1.min.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~/ControlMenor/js/jquery-ui-1.8.9.custom.min.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~/ControlMenor/js/json2.js") %>'></script>
    <%-- Estilos jQueryUI y dataTable --%>
    <link href='<%= ResolveUrl("~/ControlMenor/css/redmond/jquery.ui.all.css") %>' rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="content3" ContentPlaceHolderID="Superior" runat="server">
    Datos de Identificación del Paciente
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
<table>
    <tr>
        <td>
        <div style="font-family: Verdana;" >
             <legend>Obras Sociales</legend>
             <uc1:OSociales ID="OSociales" runat="server" />
        </div>        
        </td>
    </tr>
</table>
</asp:Content>

