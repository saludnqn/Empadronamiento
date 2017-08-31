<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PacienteUnificar.aspx.cs" Inherits="Empadronamiento.PacienteUnificar" MasterPageFile="~/mPaciente.Master" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>

<asp:Content ID="content3" ContentPlaceHolderID="Cuerpo" runat="server">

    <asp:HiddenField ID="errorDNI" runat="server" />

  

    <div class="container">
        <h1 style="font-size: xx-large; color: black">Unificación de Pacientes
      <button id="btnHelp" class="btn btn-primary btn-lg" onclick="poponload()">
          <i class="fa fa-info-circle">Ayuda</i>
      </button>
        </h1>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3>
                            <asp:Label runat="server">Identificación del Paciente Principal</asp:Label>
                        </h3>
                    </div>

                    <div class="panel-body">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:Label ID="lblDNI" class="col-sm-5 control-label" runat="server">Documento único (DU)</asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtDni" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <button id="btnSearch" runat="server" class="form-control btn btn-primary" onserverclick="btnBuscar_Click">
                                        <i class='fa fa-search'>Buscar</i>
                                    </button>
                                </div>
                                <div class="col-sm-6">
                                    <button id="btnClean" runat="server" class="form-control" onserverclick="btnBorrar_Click">
                                        <i class='fa fa-trash'>Limpiar</i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:Panel ID="pnlPaciente" runat="server" Visible="False" css="form-control">
                                    <div class="well well-lg">
                                        <table class="table table-condensed">
                                            <tr>
                                                <td>Estado:
                                                </td>
                                                <td colspan="20">
                                                    <asp:Label ID="lblEstado" runat="server" Font-Bold="True"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>DU:<asp:Label ID="lblidPaciente" runat="server" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDU" runat="server" Text="Label"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Apellido
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblApellido" runat="server" Text="Label"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Nombres
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblNombre" runat="server" Text="Label"></asp:Label>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>Fecha Nac.:
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblFechaNacimiento" runat="server" Text="Label"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Sexo:
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblSexo" runat="server" Text="Label"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>

                                </asp:Panel>
                            </div>
                            <div class="form-group">
                                <asp:Panel ID="pnlSinDatosPaciente" class="form-control" runat="server" Visible="False">
                                    <span style="color: red">No se encontró paciente para el número ingresado.</span>
                                </asp:Panel>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!--Sección de búsqueda para asignar al paciente-->
            <div class="col-md-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3>
                            <asp:Label runat="server">Identificación de Registros a asignar al Paciente Principal </asp:Label>
                        </h3>
                    </div>

                    <div class="panel-body">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:Label ID="lblBuscarPor" runat="server" class="col-sm-2 control-label">Buscar por:</asp:Label>
                                <div class="col-sm-5">
                                    <asp:DropDownList ID="ddlFiltro" class="form-control" runat="server">
                                        <asp:ListItem Value="1">Nro de documento</asp:ListItem>
                                        <asp:ListItem Value="5">Numero Temporal</asp:ListItem>
                                        <asp:ListItem Value="2">Apellido</asp:ListItem>
                                        <asp:ListItem Value="3">Nombre</asp:ListItem>
                                        <asp:ListItem Value="4">Apellido+Nombres</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-5">
                                    <asp:TextBox ID="txtFiltro" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <button id="btnBuscar" runat="server" class="form-control btn btn-primary" onserverclick="btnBuscar0_Click">
                                        <i class='fa fa-search'>Buscar</i>
                                    </button>
                                </div>
                                <div class="col-sm-6">
                                    <button id="btnBorrar" runat="server" class="form-control" onserverclick="btnBorrar0_Click">
                                        <i class='fa fa-trash'>Limpiar</i>
                                    </button>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">

                            <div class="col-md-12">

                                <asp:Panel ID="pnlRegistros" runat="server" Visible="False" css="form-control">

                                    <div class="col-md-12">

                                        <asp:GridView ID="gvLista" runat="server" CssClass="table table-hover" AutoGenerateColumns="False"
                                            DataKeyNames="idPaciente" Font-Size="9pt"
                                            EmptyDataText="No se encontraron registros para los parametros de búsqueda ingresados">
                                            <PagerStyle HorizontalAlign="Center" />

                                            <RowStyle Font-Names="Arial"
                                                Font-Size="9pt" />
                                            <AlternatingRowStyle />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sel.">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="CheckBox1" runat="server" EnableViewState="true" />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="5%"
                                                        HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="numeroDocumento" HeaderText="DNI">
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="apellido" HeaderText="Apellidos">
                                                    <ItemStyle Width="30%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="nombre" HeaderText="Nombres">
                                                    <ItemStyle Width="30%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="fechaNacimiento" HeaderText="Fecha Nac.">
                                                    <ItemStyle Width="10%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="sexo" HeaderText="Sexo">
                                                    <ItemStyle Width="5%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="estado" HeaderText="Estado">
                                                    <ItemStyle Width="5%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="motivo" HeaderText="Motivo">
                                                    <ItemStyle Width="5%" />
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle />
                                            <HeaderStyle
                                                Font-Names="Arial" Font-Size="8pt" BackColor=" #d9edf7" Font-Bold="True" />
                                            <SelectedRowStyle Font-Bold="True" />
                                            <SortedAscendingCellStyle />
                                            <SortedAscendingHeaderStyle />
                                            <SortedDescendingCellStyle />
                                            <SortedDescendingHeaderStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="col-md-6">
                                        <asp:Button ID="btnMoverYEliminar" runat="server" class="form-control btn btn-danger" ToolTip="Asigna los registros al paciente principal y borra el paciente seleccionado" Text=" Asignar registros y Eliminar" OnClientClick="return Pregunto()" OnClick="btnMoverYEliminar0_Click" />
                                    </div>
                                    <div class="col-md-6">
                                        <asp:Button ID="btnMover" runat="server" CssClass="form-control btn btn-warning"  Text="Asignar registros" ToolTip="Asigna los registros al paciente principal y borra el paciente seleccionado" OnClientClick="return Pregunto()" OnClick="btnMover_Click" />

                                    </div>

                                </asp:Panel>

                            </div>
                        </div>
                    </div>

                    <asp:Panel ID="pnlSinDatos" css="form-control" runat="server" Visible="false">
                        <span style="color: red">No se encontraron datos para los filtros determinados.</span>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>





    <script type="text/javascript">



         $(document).ready(function () {
            $('#aspnetForm')
                .formValidation({
                    framework: 'bootstrap',
                    icon: {
                        valid: 'fa fa-check',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        '<%= txtDni.UniqueID %>': {
                            validators: {
                                notEmpty: {
                                    message: 'El número de documento no puede estar vacío'
                                },
                                regexp: {
                                    regexp: /^[0-9]\d{6}|d{7}/,  
                                    message: 'Debe ingresar sólo número '
                                }
                            }
                        },
                    }
                });
        });



        function poponload() {
            windowHelp = window.open("PacienteUnificarHelp.aspx", "mywindow", "location=no,menubar=no,status=no,scrollbars=no,width=0,height=0");
            windowsHelp.moveTo(0,0);
        }

        function Pregunto() {
            if (confirm('¿Está seguro de asignar los registros seleccionados al paciente principal?'))
                return true;
            else
                return false;
        }


       


    </script>
</asp:Content>
