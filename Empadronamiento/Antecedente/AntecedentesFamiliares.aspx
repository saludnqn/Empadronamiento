    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AntecedentesFamiliares.aspx.cs" Inherits="Empadronamiento.Antecedente.AntecedentesFamiliares" MasterPageFile="~/mConsultorio.Master"
 %>

<%@ Register src="~/ConsultaAmbulatoria/UserControls/DiagnosticoPrincipal.ascx" tagname="DiagnosticoPrincipal" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Turnos.css" rel="stylesheet" type="text/css" />
    <link href="../../App_Themes/consultorio/ical.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="../../js/jquery-ui-1.7.1.custom.css" />
    <link href="../Resources/jquery-ui-1.8.20.css" rel="stylesheet" type="text/css" />
    <script src="../Resources/jQuery-ui-1.8.18.min.js" type="text/javascript"></script>
    <script src="../Resources/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../Laboratorio/script/ValidaFecha.js"></script>
    <%--    <li><a runat="server" href="#tabInterconsulta">Interconsulta</a></li>--%>
    <script type="text/javascript" src='<%= ResolveUrl("../../ControlMenor/js/jquery-1.5.1.min.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("../../ControlMenor/js/jquery-ui-1.8.9.custom.min.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("../../ControlMenor/js/jquery.dataTables.min.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("../../ControlMenor/js/jquery.ui.selectmenu.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("../../ControlMenor/js/ui.checkbox.js") %>'></script>
    <script type="text/javascript" src='<%= ResolveUrl("../../ControlMenor/js/json2.js") %>'></script>
    <%--    <li><a runat="server" href="#tabInterconsulta">Interconsulta</a></li>--%>
    <link href='<%= ResolveUrl("../../ControlMenor/css/redmond/jquery.ui.all.css") %>'
        rel="stylesheet" type="text/css" />
    <link href='<%= ResolveUrl("../../ControlMenor/css/datatable.css") %>' rel="stylesheet"
        type="text/css" />
    <link href='<%= ResolveUrl("../../ControlMenor/css/jquery.ui.selectmenu.css") %>'
        rel="stylesheet" type="text/css" />
    <link href='<%= ResolveUrl("../../ControlMenor/css/ui.checkbox.css") %>' rel="stylesheet"
        type="text/css" />
  
   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cuerpo" runat="server">
    
    
    <table >
        <tr>



            <td rowspan="10" style="vertical-align: top">
                <table class="myTabla" >
                    <tr>
                        <td>
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <table style="width: 100%;">
                                            <tr>
                                                <td colspan="9" style="height: 14px; text-align: left">
                                                    <table style="width:100%;">
                                                        <tr>
                                                            <td colspan="2" style="text-align: left; height: 23px;">
                                                                &nbsp;
                                                            &nbsp;&nbsp;
                                                                <asp:Label ID="lPaciente" runat="server" ForeColor="#336699" style="text-align: center" CssClass="ui-priority-primary"></asp:Label>
                                                            </td>
                                                            <td style="height: 23px"></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style1">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                <asp:Label ID="ldniPaciente" runat="server" ForeColor="#336699" CssClass="ui-priority-primary" Visible="False"></asp:Label>
                                                                                </td>
                                                            <td class="auto-style2">
                                                                &nbsp;</td>
                                                            <td class="auto-style2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                    
                                                                <asp:Label ID="lbExistenRegistros" runat="server" Text="No existen registros de Antecedentes Familiares para el Paciente" Visible="False"></asp:Label>
                                                                   <div id="tab2" style="width: 610px; height: 150px; overflow: auto;">
                        <asp:TreeView ID="TreeView1" runat="server" BorderStyle="Solid" BorderWidth="2px"
                            Width="600px" Font-Bold="False" BackColor="#EAEAEA" SkipLinkText="" ShowLines="True"
                            ExpandDepth="0">
                            <RootNodeStyle Font-Bold="True" ForeColor="Black" />
                            <NodeStyle Font-Bold="False" ForeColor="Black" />
                        </asp:TreeView>
                                                                       </div>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" style="height: 14px" title="Haga clic ">
                                                                <hr />
                                                            </td>
                                                            <td style="height: 14px" title="Haga clic "></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Button ID="BtnMasAntecedentes" runat="server" OnClick="BtnMasAntecedentes_Click" style="text-align: center" Text="+" Width="40px" ToolTip="Haga click aquí para cargar un nuevo antecedente" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height: 23px;" colspan="2">
                                                                <asp:Panel ID="PanelAlta" runat="server" Visible="False">
                                                                    <table style="width:600px;">
                                                                        <tr>
                                                                            <td style="height: 22px">&nbsp;</td>
                                                                            <td colspan="2" style="height: 22px">&nbsp;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3" style="height: 22px">Nuevo Antecedente</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height: 22px">Seleccione Parentesco</td>
                                                                            <td colspan="2" style="height: 22px">
                                                                                <asp:DropDownList ID="ddlParentesco" runat="server" DataTextField="nombre" DataValueField="id" Height="25px" TabIndex="52" Width="315px">
                                                                                    <asp:ListItem Value=""></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height: 22px">Diag. Parentesco:</td>
                                                                            <td colspan="2" style="height: 22px">&nbsp;<uc1:DiagnosticoPrincipal ID="DiagnosticoPrincipal" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&nbsp;</td>
                                                                           
                                                                            <td colspan="2">&nbsp;</td>
                                                                           
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <hr />
                                                                                <br />
                                                                                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" style="font-weight: 700" TabIndex="33" Text="Guardar" ToolTip="Guardar datos" ValidationGroup="0" Width="80px" />
                                                                                <asp:Button ID="btnEliminar" runat="server" OnClick="btnEliminar_Click" Text="Eliminar" Visible="False" Width="80px" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&nbsp;</td>
                                                                            <td>&nbsp;</td>
                                                                            <td style="text-align: right">
                                                                                &nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td style="height: 23px"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                &nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="width: 218px">
                                                    &nbsp;</td>
                                                <td style="width: 218px">
                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ValidationGroup="0" ShowSummary="False" />
                                                </td>
                                                <td style="width: 218px">&nbsp;</td>
                                                <td style="width: 217px">
                                                                &nbsp;</td>
                                                <td style="width: 467px; text-align: right;">
                                                    <asp:Label ID="lblUsuario" runat="server" Font-Bold="True" ForeColor="#CC3300" Text="Usuario:" Visible="False"></asp:Label>
                                                </td>
                                                <td style="width: 59px">
                                                    &nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td style="width: 142px">
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>

                    </tr>
                    <tr>
                        <td class="style1">&nbsp;</td>

                    </tr>
                </table>
            </td>



            <td rowspan="10" style="vertical-align: top">&nbsp;</td>


        </tr>

    </table>
         
   


    </asp:Content>