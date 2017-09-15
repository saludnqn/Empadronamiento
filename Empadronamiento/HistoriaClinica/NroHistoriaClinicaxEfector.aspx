<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NroHistoriaClinicaxEfector.aspx.cs" MasterPageFile="~/mPaciente.Master" Inherits="DalSic.HistoriaClinica.NroHistoriaClinicaxEfector" %>

<%@ Register Assembly="MagicAjax" Namespace="MagicAjax.UI.Controls" TagPrefix="ajax" %>
<asp:Content ID="content0" ContentPlaceHolderID="head" runat="server">
     <script src="../js/jquery-1.12.0.js"></script>
</asp:Content>
<asp:Content ID="content1" ContentPlaceHolderID="Superior" runat="server">
  Búsqueda de Historia Clínica en el Efector
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
  <asp:Panel ID="Panel1" runat="server" Width="98%" Style="margin-top: 6px;" DefaultButton="btnBuscar">
<table>
<tr>
<td>
Nro del Documento del Paciente:
</td>
<td>
 <asp:TextBox ID="txtDni" runat="server" ToolTip="Ingrese el número de Documento a buscar" MaxLength="8" ></asp:TextBox><br />
</td>
<td></td>
</tr>
<tr>
<td>
Nro de Historia Clínica:
</td>
<td>
 <asp:TextBox ID="txtHC" runat="server" ToolTip="Ingrese el número de Historia Clínica a buscar" MaxLength="10" ></asp:TextBox>
</td>
<td></td>
</tr>
    <tr>
        <td>Apellido</td>
        <td>
            <asp:TextBox ID="txtApellido" runat="server" MaxLength="100" ToolTip="Ingrese el apellido" Width="200px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Nombre</td>
        <td>
            <asp:TextBox ID="txtNombre" runat="server" MaxLength="100" ToolTip="Ingrese el nombre" Width="200px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
    </tr>
<tr>
<td></td>
<td></td>
<td>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" onclick="btnBuscar_Click" />
</td>
</tr>
</table>
<br />
<asp:GridView ID="gvHClinicas" runat="server" CssClass="mGrid" GridLines="None" ToolTip="Por defecto todas las Historias encontradas en el efector."
        PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="False"
        AllowPaging="True" DataKeyNames="idPaciente" EmptyDataText="No se encontraron datos." OnPageIndexChanging="gvHClinicas_PageIndexChanging">
        <Columns>
        <asp:BoundField DataField="paciente" HeaderText="Paciente" />
            <asp:BoundField DataField="fechaNacimientoPaciente" HeaderText="Fch. de Nacimiento" />
        <asp:BoundField DataField="numerodocumento" HeaderText="Documento" />
        <asp:BoundField DataField="hc" HeaderText="Nro. Historia Clínica" />
        <asp:BoundField DataField="fecharegistro" HeaderText="Fecha de Registro" />
        </Columns>
        <PagerStyle CssClass="pgr" />
        <AlternatingRowStyle CssClass="alt" />
      </asp:GridView>
<asp:Label ID="lblHc" runat="server" Text=""></asp:Label>
<br /><br />
<asp:Label ID="lblMensaje" runat="server" Text="" CssClass="lblmsn"></asp:Label>
 </asp:Panel>
</asp:Content>
