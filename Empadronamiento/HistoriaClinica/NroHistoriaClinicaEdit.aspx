<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NroHistoriaClinicaEdit.aspx.cs" Inherits="DalSic.HistoriaClinica.NroHistoriaClinicaEdit" MasterPageFile="~/mPaciente.Master" Theme="Login" %>

<asp:Content ID="content0" ContentPlaceHolderID="head" runat="server">
     <script src="../js/jquery-1.12.0.js"></script>
</asp:Content>
<asp:Content ID="content1" ContentPlaceHolderID="Superior" runat="server">
  Asignación del Número de Historia Clínica en el Efector Actual
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
<div>
Ingrese el Nro del Documento del Paciente: <asp:TextBox ID="txtDni" runat="server" ToolTip="Ingrese el número de Documento a buscar" MaxLength="8" ></asp:TextBox>
    <asp:CompareValidator ID="cv" runat="server" ErrorMessage="Solo numeros" ControlToValidate="txtDni" Operator="DataTypeCheck" Type="Integer" SetFocusOnError="true" ValidationGroup="1">*</asp:CompareValidator>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" onclick="btnBuscar_Click" />
<br /><br />
<hr />
<br />
<table>
<tr>
<td>
Documento del Paciente: <asp:Label ID="lblDoc" runat="server"></asp:Label><asp:HiddenField ID="hfidPac" runat="server" />
</td>
<td>Fecha de Nacimiento: <asp:Label ID="lblFNac" runat="server"></asp:Label>
</td>
</tr>
<tr>
<td>
Apellido: <asp:Label ID="lblApellido" runat="server"></asp:Label>
</td>
<td>
Nombres: <asp:Label ID="lblNombres" runat="server"></asp:Label><asp:HiddenField ID="hfIdRel" runat="server" />
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
<td><br />
Número de Historia Clínica: <asp:TextBox ID="txtHC" runat="server" CssClass="boxcortos" ToolTip="Número de Historia Clínica en el Efector actual"></asp:TextBox>
</td>
</tr>
</table>
<p>
<asp:Label ID="lblHc" runat="server" Text=""></asp:Label>
</p><br /><br />
<p>
<asp:Label ID="lblMensaje" runat="server" Text="" CssClass="lblmsn"></asp:Label>
</p><br />
 <asp:ValidationSummary ID="valSum" DisplayMode="SingleParagraph" ShowMessageBox="true"
            runat="server" HeaderText="Debe ingresar datos válidos:" ValidationGroup="1" />
<div class="botones">
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" 
        onclick="btnGuardar_Click" />
    <input type="button" value="Cancelar" onclick="history.go(-1)">
 </div>   
</div>
</asp:Content>