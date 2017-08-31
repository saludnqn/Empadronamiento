<%@ Page Title="" Language="C#" MasterPageFile="mConfiguracion.Master" Theme="Login" AutoEventWireup="true"
    CodeBehind="PacienteSms.aspx.cs" Inherits="Empadronamiento.PacienteSms" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
        .pager span
        {
            color: #00898c;
            font-weight: bold;
            font-size: 14pt;
            text-align: center;
            margin: 0 3px 0 3px;
        }
    </style>
</asp:Content>
<asp:Content ID="content3" ContentPlaceHolderID="Superior" runat="server">
   Pacientes Clasificados que pueden tomar turnos por SMS
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">
    <table width="70%">
        <tr>
            <td>
                Establecimiento/Efector:
            </td>
            <td style="width: auto">
                <asp:DropDownList ID="ddlEfector" runat="server" TabIndex="1" DataTextField="nombre"
                    DataValueField="idEfector" AutoPostBack="false" ToolTip="Seleccionar una opción">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Nro Documento:
            </td>
            <td>
                <asp:TextBox ID="txtDni" runat="server" Text="0" Width="80px"></asp:TextBox>
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click1" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblCantidad" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="gvPacientesSms" runat="server" CssClass="mGrid" GridLines="None"
        PagerStyle-CssClass="pager" AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="False"
        PageSize="10" AllowPaging="True" ToolTip="Tabla de resultados con paginación enumerada. Ver al pie para su navegación." OnPageIndexChanging="gvPacientesSms_PageIndexChangind"
        EmptyDataText="<b>No se encontraron datos.</b>">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="numeroDocumento" HeaderText="Nro. Documento" />
            <asp:BoundField DataField="apellido" HeaderText="Apellido" />
            <asp:BoundField DataField="nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="fechaClasificacion" HeaderText="Fecha Clasificación" />
            <asp:BoundField DataField="rcgv" HeaderText="RCGV" />
            <asp:BoundField DataField="efector" HeaderText="Establecimiento" />
        </Columns>
        <PagerStyle CssClass="pgr" />
        <AlternatingRowStyle CssClass="alt" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" ForeColor="#333333" Font-Size="Small" Font-Bold="True" />
        <HeaderStyle BackColor="#00898c" ForeColor="White" VerticalAlign="Middle" Font-Bold="True"
            HorizontalAlign="Center" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="Botones" runat="server">
</asp:Content>
