<%@ Page Title="" Language="C#" MasterPageFile="mConfiguracion.Master" AutoEventWireup="true"
    CodeBehind="PacienteCeliaco.aspx.cs" Inherits="Empadronamiento.PacienteCeliaco" %>

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
    .style3
    {
        height: 18px;
    }
    .style4
    {
        width: 390px;
        height: 12px;
    }
    .style6
    {
        width: 50px;
    }
    .style7
    {
        width: 267px;
    }
    .style8
    {
        height: 12px;
    }
    .style9
    {
        width: 76px;
    }
    .style10
    {
        width: 3px;
    }
    .style11
    {
        width: 23px;
    }
    </style>
</asp:Content>

<asp:Content ID="content3" ContentPlaceHolderID="Superior" runat="server">    
   Registro de Pacientes Celíacos sin obra social
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="Cuerpo" runat="server">    
    
    <table style="width: 100%;">
        <tr>
            <td>
                <table style="width:100%;">
                    <tr>
                        <td>
                        
                            <asp:RequiredFieldValidator ID="rfvDNI" runat="server" 
                                ControlToValidate="txtDNI" ErrorMessage="El campo DNI no puede ser vacío" 
                                ValidationGroup="0">
                            </asp:RequiredFieldValidator>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                        
                            <asp:CompareValidator ID="cvDni" runat="server" ControlToValidate="txtDNI" 
                                ErrorMessage="Debe ingresar solo números" Operator="DataTypeCheck" 
                                Type="Integer" ValidationGroup="0" ValueToCompare="0">Debe ingresar solo numeros
                            </asp:CompareValidator>
                            
                        </td>
                    </tr>
                    </table>
                <table style="width:100%;">
                    <tr>
                        <td>
                <table style="width:100%;">
                    <tr>
                        <td class="style6">
                            &nbsp;</td>
                        <td class="style7">
                            &nbsp;</td>
                        <td class="style9">
                            &nbsp;</td>
                        <td bgcolor="Gray" class="style10" rowspan="3">
                            &nbsp;</td>
                        <td class="style11">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="style6">
                            DNI</td>
                        <td class="style7">
                        
                            <asp:TextBox ID="txtDNI" runat="server" TabIndex="1" Width="226px"></asp:TextBox>
                            
                        </td>
                        <td class="style9">
                            <asp:Button ID="btnBuscarDNI" runat="server" Text="Buscar" ValidationGroup="0" onclick="btnBuscarDNI_Click" />
                            </td>
                        <td class="style11">
                            &nbsp;</td>
                        <td>
                                                        <asp:Button ID="btnExportar_XLS" runat="server" onclick="btnExportar_XLS_Click" 
                                                            Text="Exportar el listado completo a Excel" />
                            </td>
                    </tr>
                    <tr>
                        <td class="style6">
                            </td>
                        <td class="style7">
                        
                            &nbsp;</td>
                        <td class="style9">
                            </td>
                        <td class="style11">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="PanelResultadoGrilla" runat="server">
                                <table style="width:100%;">
                                    <tr>
                                        <td class="style3">
                                            <asp:Label ID="lblMensaje" runat="server" Font-Bold="True" ForeColor="#993300"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvLista" runat="server" AllowPaging="True" 
                                                AutoGenerateColumns="False" CellPadding="5" CellSpacing="10" 
                                                DataKeyNames="idPaciente" 
                                                EmptyDataText="No se encontraron datos para los filtros ingresados" 
                                                EnableTheming="True" Font-Bold="False" Font-Names="Arial" Font-Size="13pt" 
                                                ForeColor="#333333" onpageindexchanging="gvLista_PageIndexChanging" 
                                                onrowcommand="gvLista_RowCommand" onrowdatabound="gvLista_RowDataBound" 
                                                Width="100%">
                                                <RowStyle BackColor="#F7F6F3" Font-Names="Arial" Font-Size="10pt" 
                                                    ForeColor="#333333" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Celiaco">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkCeliaco" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="idPaciente" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIdPaciente" runat="server" Text='<%# Bind("idPaciente") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="apellido" HeaderText="Apellido" />
                                                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                                                    <asp:BoundField DataField="sexo" HeaderText="Sexo" />
                                                    <asp:BoundField DataField="fechaNacimiento" HeaderText="Fch. Nac." />
                                                    <asp:BoundField DataField="ObraSocial" HeaderText="Obra Social" />
                                                </Columns>
                                                <FooterStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="#990000" ForeColor="White" HorizontalAlign="Right" />
                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                <HeaderStyle BackColor="#990000" Font-Bold="False" Font-Italic="False" 
                                                    Font-Names="Arial" Font-Size="10pt" ForeColor="White" />
                                                <EditRowStyle BackColor="#999999" />
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table style="width: 100%; height: 56px;">
                                                <tr>
                                                    <td class="style4">
                                                        <asp:Label ID="Label1" runat="server" 
                                                            Text="Luego de chequer al paciente como celíaco hacer click en"></asp:Label>
                                                    </td>
                                                    <td class="style8">
                                                        <asp:Button ID="btnAgregar" runat="server" onclick="btnAgregar_Click" 
                                                            Text="Agregar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>   
    
    
</asp:Content>

<asp:Content ID="content" ContentPlaceHolderID="Botones" runat="server">
</asp:Content>

