<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Tunro.Master" Title="Parentescos" CodeBehind="ParentescoList.aspx.cs" Inherits="DalSic.Parentesco.ParentescoList" Theme="Login" %>

<%@ Register Assembly="Subsonic" Namespace="SubSonic" TagPrefix="subsonic" %>

<asp:Content ID="content4" ContentPlaceHolderID="Superior" runat="server">
Listado de Parentesco
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
<div>
<table>
<tr>
<td>Apellido: <asp:Label ID="lblApellido" runat="server"></asp:Label>
</td>
</tr>
<tr>
<td>Nombre: <asp:Label ID="lblNombre" runat="server"></asp:Label>
</td>
</tr>
<tr>
<td>Numero Doc: <asp:Label ID="lblDocumento" runat="server"></asp:Label>
</td>
<td>
<asp:HyperLink runat="server" ID="hlParentesco" NavigateUrl="../Paciente/PacienteEdit.aspx?id={0}" >Ver Datos del Paciente</asp:HyperLink>
</td>
</tr>
</table>
<hr />
      <br />
        <asp:GridView ID="gvParentesco" CssClass="mGrid" GridLines="None" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" runat="server" AutoGenerateColumns="false" AllowPaging="True" OnPageIndexChanging="gvParentesco_PageIndexChanging" PageSize="15">
            <Columns>
                <asp:BoundField DataField="tipoParentesco" HeaderText="Parentesco" />
                <asp:BoundField DataField="apellido" HeaderText="Apellido" />
                <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                <asp:TemplateField HeaderText="Tipo">
                <ItemTemplate>
                             <%# Eval("SysTipoDocumento.Nombre") %> 
                </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="numeroDocumento" HeaderText="Documento" />
                <asp:HyperLinkField DataNavigateUrlFields="idParentesco" DataNavigateUrlFormatString="ParentescoEdit.aspx?id={0}" HeaderText="Editar" Text="Editar" />
            </Columns>
        </asp:GridView>
</div>
</asp:Content>

