<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="mConfiguracion.Master" CodeBehind="ParentescoEdit.aspx.cs" Inherits="DalSic.Parentesco.ParentescoEdit" %>

<%@ Register Assembly="Subsonic" Namespace="SubSonic" TagPrefix="subsonic" %>

<asp:Content ID="content1" ContentPlaceHolderID="Encabezado" runat="server">
<script src="../js/Format.js" type="text/javascript"></script>	
</asp:Content>

<asp:Content ID="content4" ContentPlaceHolderID="Superior" runat="server">
Datos de Parentesco
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
<div>
Parentesco:<subsonic:DropDown ID="ddlParentesco" runat="server" ShowPrompt="false" >
                <asp:ListItem Value="F">Padre</asp:ListItem>
                <asp:ListItem Value="M">Madre</asp:ListItem>
                <asp:ListItem Value="O">Otro</asp:ListItem>
                </subsonic:DropDown><br />
<hr />
<table>
<tr>
<td>
Apellido:<asp:TextBox ID="txtApellido" runat="server"></asp:TextBox>
</td>
<td colspan="2">
Nombre:<asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
</td>
</tr>
<tr>
<td>
Tipo Doc:<subsonic:DropDown ID="ddlTipoDoc" runat="server" TableName="Sys_TipoDocumento" TextField="nombre" ShowPrompt="false" >
                </subsonic:DropDown>
</td>
<td>
Numero:<asp:TextBox ID="txtNumero" MaxLength="8" runat="server" 
        ToolTip="Solo números"></asp:TextBox>
</td>
<td>
Fecha Nac:<asp:TextBox ID="txtFechaN" runat="server" CssClass="boxcortos" onblur="javascript:formatearFecha(this)"></asp:TextBox>
</td>
</tr>
<tr>
<td>
Lugar Nacimiento:<subsonic:DropDown ID="ddlProvincia" runat="server" TableName="Sys_Provincia" TextField="nombre" ShowPrompt="false">
                </subsonic:DropDown>
</td>
<td>
Nacionalidad:<subsonic:DropDown ID="ddlNacionalidad" runat="server" TableName="Sys_Pais" TextField="nombre" ShowPrompt="false">
                </subsonic:DropDown>
</td>
</tr>
<tr>
<td>
Nivel de Instrucción:<subsonic:DropDown ID="ddlNivelInstruccion" runat="server" TableName="Sys_NivelInstruccion" TextField="nombre" ShowPrompt="false">
                </subsonic:DropDown>
</td>
<td>
Situación Laboral:<subsonic:DropDown ID="ddlSituacionLaboral" runat="server" TableName="Sys_SituacionLaboral" TextField="nombre" ShowPrompt="false">
                </subsonic:DropDown>
</td>
</tr>
</table>
</div>
<hr />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Botones" runat="server">
<div class="botones">
    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" OnClick="btnCancelar_Click" />
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
</div>
<br />
<div> 
    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
 </div>
</asp:Content>