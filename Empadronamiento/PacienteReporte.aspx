<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/mPaciente.Master" CodeBehind="PacienteReporte.aspx.cs" Inherits="Empadronamiento.PacienteReporte" Theme="Login" Title="Búsqueda e Identificación de Pacientes" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>

<asp:Content ID="content3" ContentPlaceHolderID="Cuerpo" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Búsqueda de pacientes</h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label ID="lblEfector" runat="server" Text="Efector/Establecimiento:" class="col-sm-4 control-label"></asp:Label>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="ddlEfector" placeholder="Seleccione efector/establecimiento" runat="server" TabIndex="1" class="form-control" DataTextField="nombre"
                                        DataValueField="idEfector" ToolTip="Seleccione una opción">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblApellido" runat="server" Text="Apellido:" class="col-sm-4 control-label"></asp:Label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtApellidoBusqueda" class="col-sm-8 form-control" runat="server" TabIndex="2"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label ID="lblSexo" runat="server" Text="Sexo: " class="col-sm-4 control-label"></asp:Label>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="ddlSexo" class="col-sm-8 form-control" runat="server" DataTextField="nombre" DataValueField="idSexo" TabIndex="3"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblEstado" runat="server" Text="Estado: " class="col-sm-4 control-label"></asp:Label>
                                <div class="col-sm-8">
                                    <asp:DropDownList ID="ddlEstado" class="col-sm-8 form-control" runat="server" DataTextField="nombre" DataValueField="idEstado" TabIndex="4"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">

                            <asp:Label ID="lblFechaInicio" runat="server" Text="Fecha inicio:" class="col-sm-4 control-label"></asp:Label>
                            <div class="col-sm-8">
                                <div class="input-group input-append date" id="datePicker">
                                    <asp:TextBox runat="server" ID="txtFInicio" class="form-control" TabIndex="2">                    
                                    </asp:TextBox>
                                    <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <asp:Label ID="lblFechaFin" runat="server" Text="Fecha fin:" class="col-sm-4 control-label"></asp:Label>
                            <div class="col-sm-8">
                                <div class="input-group input-append date" id="datePicker1">
                                    <asp:TextBox runat="server" ID="txtFFin" class="form-control" TabIndex="2">                    
                                    </asp:TextBox>
                                    <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                            </div>
                        </div>
                        <%--Dejamos espacio para el botón--%>
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-offset-1 col-md-2">
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" class="btn btn-primary btn-lg btn-block" OnClick="btnBuscar_Click" TabIndex="7" />
                            </div>
                        </div>
                        <%-- Dejamos espacio para el botón--%>
                        <div class="col-md-12">
                            <br />
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <hr>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-10">
                                <div class="col-md-6">
                                    <h3>Referencia de estados:</h3>
                                </div>
                                <div class="col-md-2">
                                    <h3><span class="label label-success">Validado</span></h3>
                                </div>
                                <div class="col-md-2">
                                    <h3><span class="label label-warning">Identificado</span></h3>
                                </div>
                                <div class="col-md-2">
                                    <h3><span class="label label-danger">Temporal</span></h3>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <h3 class="infoBox">
                                    <asp:Label ID="lblEncontrados" runat="server" Text="Pacientes encontrados: " class=" control-label" Visible="false"></asp:Label>
                                    <asp:Label ID="lblMensaje" class="badge" runat="server"></asp:Label>
                                </h3>

                                <asp:GridView ID="gvPacientes" runat="server" class="table table-hover" GridLines="None" PagerStyle-CssClass="pgr"
                                    AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="false" EmptyDataText="<b>No se encontraron datos.</b>"
                                    PageSize="10" AllowPaging="True" OnSorting="gridView_Sorting"
                                    OnPageIndexChanging="gvPacientes_PageIndexChangind" OnRowDataBound="gvPacientes_RowDataBound">
                                    <Columns>
                                        <asp:BoundField DataField="apellido" HeaderText="Apellido" />
                                        <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                                        <asp:BoundField DataField="numeroDocumento" HeaderText="Nro Doc" />
                                        <asp:BoundField DataField="sexo" HeaderText="Sexo" />
                                        <asp:BoundField DataField="fechaNacimiento" HeaderText="Fec.Nac" />
                                        <asp:BoundField DataField="telefono" HeaderText="Telefono" />
                                        <asp:BoundField DataField="DomicilioBarrio" HeaderText="Barrio" />
                                        <asp:BoundField DataField="fechaTurno" HeaderText="FechaTurno" />
                                        <asp:BoundField DataField="centroSalud" HeaderText="Centro Salud" />
                                        <asp:BoundField DataField="Observacion" HeaderText="Observacion" />
                                        <asp:HyperLinkField DataNavigateUrlFields="idPaciente" DataNavigateUrlFormatString="~/Paciente/PacienteView.aspx?id={0}"
                                            HeaderText="Ver" Text="Ver" />
                                        <asp:HyperLinkField DataNavigateUrlFields="idPaciente" DataNavigateUrlFormatString="~/Paciente/PacienteEdit.aspx?id={0}&llamada=ConsultaPaciente"
                                            HeaderText="Editar" Text="Editar" />
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                    <AlternatingRowStyle CssClass="alt" />
                                </asp:GridView>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $('.date')
       .datepicker({
           format: 'dd/mm/yyyy',
           language: 'es',
           autoclose: 1,
       });
    </script>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Botones" runat="server">
</asp:Content>
