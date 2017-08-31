<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ObraSocial.aspx.cs" Inherits="Empadronamiento.ObraSocial" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Padrón de Obra Social</title>
    <link rel="stylesheet" type="text/css" href="../App_Themes/Login/css/style.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="border: dotted 1px grey;">
        <h2>
            Obra Social del Paciente</h2>
            <br />
        <asp:GridView ID="gvOSocial" runat="server" AutoGenerateColumns="false" CssClass="mGrid" EmptyDataText="Sin datos encontrados"
            ToolTip="Obra Social encontrada en el Padrón de Obras Sociales">
            <Columns>
                <asp:BoundField DataField="Documento" HeaderText="DU" />
                <asp:BoundField DataField="Nombre" HeaderText="Paciente" />
                <asp:BoundField DataField="ObraSocial" HeaderText="ObraSocial" />
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
        <br />
    </div>
    <div style="text-align: center;">
        <input type="button" value="Cerrar" onclick="window.close()" />
    </div>
    </form>
</body>
</html>