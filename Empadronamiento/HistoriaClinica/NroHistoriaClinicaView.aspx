<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NroHistoriaClinicaView.aspx.cs" Inherits="DalSic.HistoriaClinica.NroHistoriaClinicaView" MasterPageFile="~/mPaciente.Master" %>

<asp:Content ID="content0" ContentPlaceHolderID="head" runat="server">
     <script src="../js/jquery-1.12.0.js"></script>
</asp:Content>
<asp:Content ID="content1" ContentPlaceHolderID="Superior" runat="server">
  Número de Historia Clínica Existente
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
<div>
<table width="80%">
<tr>
<td>
Documento del Paciente: <asp:Label ID="lblDoc" runat="server"></asp:Label>
</td>
<td>
Fecha de Nacimiento: <asp:Label ID="lblFNac" runat="server"></asp:Label><asp:HiddenField ID="hfIdPaciente" runat="server" />
</td>
</tr>
<tr>
<td>
Apellido: <asp:Label ID="lblApellido" runat="server"></asp:Label>
</td>
<td>
Nombres: <asp:Label ID="lblNombres" runat="server"></asp:Label>
</td>
</tr>
<tr>
<td>
Sexo: <asp:Label ID="lblSexo" runat="server"></asp:Label>
</td>
<td>
Información de Contacto: <asp:Label ID="lblContacto" runat="server"></asp:Label>
</td>
</tr>
<tr>
<td>
Número de Historia Clínica: <asp:Label ID="lbltHC" runat="server"></asp:Label>
</td>
<td>
Fecha de Registro: <asp:Label ID="lblFecha" runat="server"></asp:Label>
</td>
</tr>
</table><br />
<div class="botones">
    <asp:Button ID="btnEditar" runat="server" Text="Editar" onclick="btnEditar_Click" />
    <input type="button" value="Volver" onclick="history.go(-1)" />
    <asp:Button ID="btnVolverPaciente" runat="server" Text="Volver Paciente" onclick="btnVolverPaciente_Click" />
 </div>   
</div>
</asp:Content>


