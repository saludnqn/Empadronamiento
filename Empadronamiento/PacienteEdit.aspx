<%@ Page Title="" Language="C#" MasterPageFile="~/mPaciente.Master" AutoEventWireup="true" CodeBehind="PacienteEdit.aspx.cs" Inherits="Empadronamiento.PacienteEdit" %>

<%@ Register Src="~/UserControls/PacienteProvincial.ascx" TagPrefix="uc1" TagName="PacienteProvincial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Cuerpo" runat="server">

    <style>
        .form-horizontal .has-feedback .form-control-feedback {
            top: 0;
            right: -11px;
        }

        #telFijo > div:nth-child(1) > i:nth-child(3), i:nth-child(4) {
            top: 0;
            right: -25px;
        }

        div.panel-body:nth-child(2) > div:nth-child(6) > div:nth-child(1) > div:nth-child(4) > div:nth-child(1) > i:nth-child(3) {
            top: 0;
            right: -25px;
        }

        .linkRenaper {
            color: #ffffff !important;
        }

        /*
 * Off Canvas
 * --------------------------------------------------
 * Greater thav 768px shows the menu by default and also flips the semantics
 * The issue is to show menu for large screens and to hide for small
 * Also need to do something clever to turn off the tabs for when the navigation is hidden
 * Otherwise keyboard users cannot find the focus point
 * (For now I will ignore that for mobile users and also not worry about
 * screen re-sizing popping the menu out.)
 */
        @media screen and (min-width: 768px) {
            .row-offcanvas {
                position: relative;
                -webkit-transition: all .45s ease-out;
                -moz-transition: all .45s ease-out;
                transition: all .45s ease-out;
            }

            .row-offcanvas-right {
                right: 25%;
            }

            .row-offcanvas-left {
                left: 40%;
            }

            .row-offcanvas-right .sidebar-offcanvas {
                right: -40%; /* 3 columns */
                background-color: rgb(255, 255, 255);
            }

            .row-offcanvas-left .sidebar-offcanvas {
                left: -40%; /* 3 columns */
                background-color: rgb(255, 255, 255);
            }

            .row-offcanvas-right.active {
                right: 0; /* 3 columns */
            }

            .row-offcanvas-left.active {
                left: 0; /* 3 columns */
            }

            .row-offcanvas-right.active .sidebar-offcanvas {
                background-color: rgb(254, 254, 254);
            }

            .row-offcanvas-left.active .sidebar-offcanvas {
                background-color: rgb(254, 254, 254);
            }

            .row-offcanvas .content {
                width: 60%; /* 9 columns */
                -webkit-transition: all .45s ease-out;
                -moz-transition: all .45s ease-out;
                transition: all .45s ease-out;
            }

            .row-offcanvas.active .content {
                width: 100%; /* 12 columns */
            }

            .sidebar-offcanvas {
                position: absolute;
                top: 0;
                width: 40%; /* 3 columns */
            }
        }

        @media screen and (max-width: 767px) {
            .row-offcanvas {
                position: relative;
                -webkit-transition: all .45s ease-out;
                -moz-transition: all .45s ease-out;
                transition: all .45s ease-out;
            }

            .row-offcanvas-right {
                right: 0;
            }

            .row-offcanvas-left {
                left: 0;
            }

            .row-offcanvas-right .sidebar-offcanvas {
                right: -50%; /* 6 columns */
            }

            .row-offcanvas-left .sidebar-offcanvas {
                left: -50%; /* 6 columns */
            }

            .row-offcanvas-right.active {
                right: 50%; /* 6 columns */
            }

            .row-offcanvas-left.active {
                left: 50%; /* 6 columns */
            }

            .sidebar-offcanvas {
                position: absolute;
                top: 0;
                width: 50%; /* 6 columns */
            }
        }

        .center-div {
            margin: 0 auto;
            width: 100px;
        }
    </style>

    <asp:ScriptManager ID="scriptMgr" runat="server">
    </asp:ScriptManager>
    <!--Datos Principales -->

    <div class="container-fluid">
        <div class="row row-offcanvas row-offcanvas-left active">
            <div class="col-xs-6 col-sm-5 sidebar-offcanvas" id="sidebar" role="navigation">
                <div class="panel-group" id="accordion1">
                    <div class="panel panel-default" id="panel1">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-target="#renaper" href="#rena">Renaper
                                </a>
                            </h4>
                        </div>
                        <div id="loaderRenaper"><i class="fa fa-4x fa-cog fa-spin"></i></div>
                        <div id="renaper" class="panel-collapse collapse in">

                            <div class="panel-body">
                                <div class="col-md-12 form-group ">
                                    <button id="btnRenaper" class="btn btn-info btn-xs linkRenaper pull-left" type="button">Consulta Renaper</button>
                                </div>
                                <table id="tblRenaper" class="table table-hover">
                                </table>
                            </div>
                            <asp:Label ID="lblInfoRenaper" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="panel panel-default" id="panel2">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-target="#sintys" href="#collapseTwo" class="collapsed">Sintys
                                </a>
                            </h4>
                        </div>
                        <div id="loaderSintys"><i class="fa fa-4x fa-cog fa-spin"></i></div>
                        <div id="sintys" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="col-md-12 form-group ">
                                    <button id="btnSyntis" class="btn btn-info btn-xs linkRenaper pull-left" type="button">Consulta Sintys</button>
                                </div>
                                <table id="tblSintys" class="table table-hover">
                                </table>
                                <asp:Label ID="lblInfoSintys" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default" id="panel3" runat="server" visible="false">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-target="#padron" href="#collapseThree" class="collapsed">Padrón Provincial
                                </a>
                            </h4>

                        </div>
                        <div id="padron" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="col-md-12 form-group ">
                                    <asp:LinkButton ID="lnkPadronPcial" runat="server" OnClick="lnkPadronPcial_Click" Text="Consultar Padrón Pcial" CssClass="btn btn-info btn-xs linkRenaper pull-left">                          
                                    </asp:LinkButton>
                                </div>
                                <div class="col-md-12 form-group">
                                    <asp:Button ID="btnCopiarTodo" runat="server" CssClass="btn btn-info btn-xs" Text="Copiar Todo" Visible="False" OnClick="btnCopiarTodo_Click" TabIndex="20" />
                                    <asp:Button ID="btnCopiarDatosPrincipales" runat="server" CssClass="btn btn-info btn-xs" Text="Copiar Datos Principales" Visible="False" OnClick="btnCopiarDatosPrincipales_Click" TabIndex="21" />
                                    <asp:Button ID="btnCopiarDomicilio" runat="server" CssClass="btn btn-info btn-xs" OnClick="btnCopiarDomicilio_Click" Text="Copiar Domicilio" Visible="False" TabIndex="22" />
                                    <asp:Button ID="btnCopiarProgenitor" runat="server" CssClass="btn btn-info btn-xs" OnClick="btnCopiarProgenitor_Click" Text="Copiar Datos Progenitor" Visible="False" TabIndex="23" />
                                    <asp:Button ID="btnCopiarMadre" runat="server" CssClass="btn btn-info btn-xs" OnClick="btnCopiarMadre_Click" Text="Solo Datos Madre" Visible="False" TabIndex="24" />
                                    <asp:Button ID="btnCopiarPadre" runat="server" CssClass="btn btn-info btn-xs" OnClick="btnCopiarPadre_Click" Text="Solo Datos Padre" Visible="False" TabIndex="25" />
                                </div>
                                <div class="form-group">
                                    <uc1:PacienteProvincial runat="server" ID="PacienteProvincial" Visible="False" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-7 content">

                <div id="alertaError" class="alert alert-dismissable alert-warning">
                    <button id="btnAlerta" type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>Importante!</strong><asp:Label ID="lblMensaje" runat="server"></asp:Label>
                </div>

                <div class="alert alert-warning" role="alert" id="alertaDatosUltimaModificacion" runat="server">
                    <p class="text-left">
                        <strong>Ultima Modificación: </strong>
                        <asp:Label ID="lblDatosUltimaModificacion" runat="server"></asp:Label>
                    </p>
                </div>

                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Datos Principales
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="row-fluid">
                            <div class="form-group">
                                <div class="col-sm-1">
                                    <p class="pull-left">
                                        <button id="btnConsultar" type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas"
                                            contenteditable="false" title="Consultar Datos De Pacientes">
                                            <i class="fa fa-bars fa-3x"></i>
                                        </button>
                                    </p>

                                </div>
                                <div class="col-sm-5">
                                    <div class="alert alert-info" role="alert" id="alertMessage">
                                        <span class="close" data-dismiss="alert">5</span>
                                        <span>
                                            <i class="fa fa-2x fa-arrow-circle-left"></i>
                                            <strong>Atención: </strong>Información de pacientes -Renaper & Sintys-
                                        </span>
                                    </div>

                                </div>

                                <div class=" col-sm-offset-0 col-sm-6">
                                    <asp:HyperLink ID="hlkHClinica" runat="server" ForeColor="DarkGreen" TabIndex="3">Registrar Nro. de Historia Clínica</asp:HyperLink>
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblNumeroDocumento" runat="server" Text="DU: " class="col-sm-2 control-label"></asp:Label>
                                <asp:Label ID="lblExtranjero" runat="server" Text="Doc. Extranjero" class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txtNumeroDocumento" CssClass="form-control" BorderColor="#268fb8" runat="server"
                                        ToolTip="Solo números" TabIndex="4"></asp:TextBox>
                                    <asp:TextBox ID="txtNumeroExtranjero" CssClass="form-control" BorderColor="#268fb8" runat="server"
                                        ToolTip="Ingrese el Número de Identificación Extranjero" TabIndex="5" />
                                    <asp:HiddenField ID="hfIdPaciente" runat="server" Value="0" />
                                </div>
                                <asp:Label ID="lblEstadoPaciente" runat="server" Text="Estado: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddlEstadoP" runat="server" class="form-control" TabIndex="1">
                                    </asp:DropDownList>
                                </div>

                                <asp:Label ID="lblMotivoNI" runat="server" Text="Motivo NI: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddlMotivoNI" runat="server" DataValueField="idMotivoNI"
                                        ToolTip="Seleccione el Motivo de No Identificación" DataTextField="nombre" class="form-control" TabIndex="2">
                                    </asp:DropDownList>
                                </div>

                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblApellido" runat="server" Text="Apellido: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" TabIndex="6"></asp:TextBox>
                                </div>
                                <asp:Label ID="lblNombre" runat="server" Text="Nombre: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" TabIndex="7"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblFechaDeNacimiento" runat="server" Text="Fecha de Nac.: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4 date">
                                    <div class="input-group input-append date" id="datePicker">
                                        <asp:TextBox runat="server" ID="txtFechaNac" class="form-control" TabIndex="8">                    
                                        </asp:TextBox>
                                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <asp:Label ID="lblNacionalidad" runat="server" Text="Nacionalidad: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlNacionalidad" runat="server" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlNacionalidad_SelectedIndexChanged" OnDataBound="ddlNacionalidad_DataBound" DataTextField="nombre"
                                        DataValueField="idPais" CssClass="form-control" TabIndex="9">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblLugarDeNacimiento" runat="server" Text="Lugar de Nac.: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlProvincia" runat="server" DataTextField="nombre" DataValueField="idProvincia" CssClass="form-control" TabIndex="10">
                                    </asp:DropDownList>
                                    <%--<asp:DropDownList ID="ddlProvinciaold" runat="server" AutoPostBack="true" ToolTip="Seleccionar la Provincia"
                                        DataTextField="nombre" DataValueField="idProvincia" CssClass="form-control" TabIndex="10">
                                    </asp:DropDownList>--%>
                                </div>
                                <asp:Label ID="lblSexo" runat="server" Text="Sexo: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlSexo" DataTextField="nombre" DataValueField="idSexo" runat="server" CssClass="form-control" TabIndex="11">
                                    </asp:DropDownList>
                                </div>

                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblTelefonoFijo" runat="server" Text="Teléfono Fijo: " class="col-sm-2 control-label"></asp:Label>
                                <div id="telFijo" class="col-sm-4">
                                    <asp:TextBox ID="txtTFijo" runat="server" CssClass="form-control" TabIndex="12" placeholder="0299 4430987" />
                                </div>
                                <asp:Label ID="lblCelular" runat="server" Text="Celular: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtTCelular" AutoCompleteType="Cellular" runat="server" CssClass="form-control" TabIndex="13" placeholder="0299 155712345" />
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblObraSocial" runat="server" Text="Obra Social: " class="col-sm-2 control-label"></asp:Label>
                                <div id="typehead" class="col-sm-6 typehead" hidden>
                                    <input type="text" class="form-control required typeahead" id="obraSocial" name='obraSocial' placeholder="Obra Social" autocomplete="off" tabindex="14" />
                                </div>
                                <div id="divObraSocial" runat="server" class="col-sm-6" visible="true">
                                    <div class="input-group">
                                        <input id="txtObraSocial" runat="server" type="text" class="form-control" readonly tabindex="15" />
                                        <span class="input-group-btn">
                                            <button id="btnLimpiaObraSocial" class="btn btn-warning" type="button" tabindex="16"><i class="glyphicon glyphicon-remove"></i></button>
                                        </span>
                                        <asp:HiddenField ID="hdfIdObraSocial" runat="server" />
                                        <asp:HiddenField ID="hdfNombre" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblMail" runat="server" Text="e-Mail: " class="col-sm-2 control-label"></asp:Label>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" data-inputmask="'alias': 'email'" TabIndex="17" />
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <div class="col-md-offset-4 col-md-8">
                                    <asp:GridView ID="grdOSociales" runat="server" CssClass="table table-hover table-bordered" AutoGenerateColumns="False"
                                        EmptyDataText="<b>No se encontraron datos de obras sociales para la persona seleccionada.</b>">
                                        <Columns>
                                            <asp:BoundField DataField="ObraSocial" HeaderText="Obra Social" />
                                            <asp:BoundField DataField="baseOrigen" HeaderText="Base Origen" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="form-group">
                                <asp:Label ID="lblObservaciones" runat="server" Text="Observaciones: " class="col-md-2 control-label"></asp:Label>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control" TabIndex="26"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Datos Del Domicilio-->
    <div class="container-fluid">
        <div class="row row-offcanvas row-offcanvas-left active">
            <div class="col-xs-12 col-sm-7 content">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-info ">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">Datos Del Domicilio
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse">
                            <div class="panel-body">
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblProvinciaDomicilio" runat="server" Text="Provincia: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlProvinciaDomicilio" onchange="llenaDepartamento()" runat="server" AutoPostBack="false" DataTextField="nombre"
                                                DataValueField="idProvincia" CssClass="form-control" TabIndex="28">
                                            </asp:DropDownList>
                                        </div>
                                        <asp:Label ID="lblDepartamento" runat="server" Text="Departamento: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlDepartamento" runat="server" DataTextField="nombre" DataValueField="idDepartamento" onchange="llenaLocalidad()" CssClass="form-control" TabIndex="29"></asp:DropDownList>

                                            <%--<asp:DropDownList ID="ddlDepartamentoold" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged"
                                                AutoPostBack="false" ToolTip="Seleccionar el Departamento" DataTextField="nombre"
                                                DataValueField="idDepartamento" TabIndex="29">
                                            </asp:DropDownList>--%>
                                        </div>

                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblLocalidad" runat="server" Text="Localidad: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="ddlLocalidad" runat="server" DataTextField="nombre" DataValueField="idLocalidad" onchange="llenaBarrios()" CssClass="form-control" TabIndex="30">
                                            </asp:DropDownList>
                                            <%--<asp:DropDownList ID="ddlLocalidadOld" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlLocalidad_SelectedIndexChanged"
                                                AutoPostBack="false" ToolTip="Seleccionar Localidad" DataTextField="nombre" DataValueField="idLocalidad"
                                                OnDataBound="ddlLocalidad_DataBound" TabIndex="30">
                                            </asp:DropDownList>--%>
                                        </div>
                                        <asp:Label ID="lblCodigoPostal" runat="server" Text="Código Postal: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtCPostal" runat="server" CssClass="form-control" TabIndex="31"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="form-group">
                                            <asp:Label ID="lblBarrio" runat="server" Text="Barrio: " class="col-md-2 control-label"></asp:Label>
                                            <div class="col-sm-4">
                                                <asp:DropDownList ID="ddlBarrio" runat="server" onchange="seleccionarBarrio()" CssClass="form-control" DataTextField="nombre" DataValueField="idBarrio" TabIndex="32">
                                                </asp:DropDownList>
                                            </div>
                                            <asp:Label ID="lblOtroBarrio" runat="server" Text="Otro Barrio: " class="col-md-2 control-label"></asp:Label>
                                            <div class="col-sm-4">
                                                <asp:TextBox ID="txtOBarrio" runat="server" CssClass="form-control" TabIndex="33"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <%-- <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblDireccion" runat="server" Text="Dirección: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <input id="autocomplete" placeholder="Escribí tu dirección" class="form-control" type="text">
                                                    <asp:HiddenField ID="hdfDireccion" runat="server" />
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblCalle" runat="server" Text="Calle: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" TabIndex="34"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblNumero" runat="server" Text="Nro: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtNumero" CssClass="form-control" runat="server" ToolTip="Solo números" TabIndex="35"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblDepto" runat="server" Text="Depto: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control" ToolTip="Ingreso el número o Letra de su departamento" TabIndex="36"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblPiso" runat="server" Text="Piso: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control" TabIndex="37"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblEdificio" runat="server" Text="Edificio: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="txtEdificio" runat="server" CssClass="form-control" TabIndex="38"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblManzana" runat="server" Text="Manzana: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="txtManzana" runat="server" CssClass="form-control" TabIndex="39"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblCamino" runat="server" Text="Camino: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtCamino" runat="server" CssClass="form-control" TabIndex="46"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblLote" runat="server" Text="Lote: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtLote" runat="server" CssClass="form-control" TabIndex="47"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblParcela" runat="server" Text="Parcela: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-md-8">
                                                    <asp:TextBox ID="txtParcela" runat="server" CssClass="form-control" TabIndex="48"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-6">
                                        <div class="row">
                                            <div class="form-group">
                                                <asp:Label ID="lblDireccion" runat="server" Text="Dirección: " class="col-md-4 control-label"></asp:Label>
                                                <div class="col-sm-8">
                                                    <input id="autocomplete" placeholder="Escribí tu dirección" class="form-control" type="text">
                                                    <asp:HiddenField ID="hdfDireccion" runat="server" />
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row-fluid">
                                            <div class="form-group">
                                                <div class="panel panel-default" style="margin-left: 30px">
                                                    <div class="panel-body">
                                                        <div id="map" class="center-div" style="width: 100%; height: 345px"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="form-group">
                                            <asp:Label ID="lblReferencia" runat="server" Text="Referencia: " class="col-sm-2 control-label"></asp:Label>
                                            <div class="col-sm-4">
                                                <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control" TabIndex="40"></asp:TextBox>
                                            </div>
                                            <asp:Label ID="lblTipo" runat="server" Text="Tipo: " class="col-sm-2 control-label"></asp:Label>
                                            <div class="col-sm-3" data-toggle="buttons">
                                                <asp:Label ID="lblUrbano" class="btn btn-info" runat="server">Urbano                                            
                                            <input type="radio" name="options" id="rbtUrbano" runat="server" tabindex="41" />
                                                    <span class="glyphicon glyphicon-ok"></span>
                                                </asp:Label>
                                                <asp:Label ID="lblRural" class="btn btn-info" runat="server">Rural                                           
                                            <input type="radio" name="options" id="rbtRural" runat="server" tabindex="42" />
                                                    <span class="glyphicon glyphicon-ok"></span>
                                                </asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="form-group">
                                            <asp:Label ID="lblCoordenadas" runat="server" Text="Coordenadas: " class="col-md-2 control-label"></asp:Label>
                                            <asp:Label ID="lblLatitud" runat="server" Text="Latitud: " class="col-md-1 control-label"></asp:Label>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtLatitud" runat="server" CssClass="form-control" TabIndex="43"></asp:TextBox>
                                            </div>
                                            <asp:Label ID="lblLongitud" runat="server" Text="Longitud: " class="col-md-1 control-label"></asp:Label>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtLongitud" runat="server" CssClass="form-control" TabIndex="44"></asp:TextBox>
                                            </div>
                                            <asp:Label ID="lblCampo" runat="server" Text="Campo: " class="col-md-2 control-label"></asp:Label>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtCampo" runat="server" CssClass="form-control" TabIndex="45"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Datos Del Progenitor-->
    <div class="container-fluid">
        <div class="row row-offcanvas row-offcanvas-left active">
            <div class="col-xs-12 col-sm-7 content">
                <div class="panel-group" id="accordionDatosProgenitor">
                    <div class="panel panel-info ">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordionDatosProgenitor" href="#collapseDatosProgenitor">Datos Del Progenitor
                                </a>
                            </h4>
                        </div>
                        <div id="collapseDatosProgenitor" class="panel-collapse">
                            <div class="panel-body">
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <h4>Datos de la Madre</h4>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblApellidoMadre" runat="server" Text="Apellido: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtApellidoM" runat="server" CssClass="form-control" TabIndex="50"></asp:TextBox>
                                        </div>
                                        <asp:Label ID="lblNombreMadre" runat="server" Text="Nombre: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtNombreM" runat="server" CssClass="form-control" TabIndex="51" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblDniMadre" runat="server" Text="DU: " class="col-md-2 control-label"></asp:Label>
                                        <asp:Label ID="lblIdParentescoM" Visible="false" runat="server">0</asp:Label>
                                        <div id="nroM" class="col-sm-4">
                                            <asp:TextBox ID="txtNumeroM" runat="server" CssClass="form-control" TabIndex="49"></asp:TextBox>
                                        </div>
                                        <asp:Label ID="lblFechaNacimientoMadre" runat="server" Text="Fecha De Nac.: " class="col-sm-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <div class="input-group date form_date " data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="dd-mm-yyyy">
                                                <asp:TextBox runat="server" ID="txtFNacMadre" class="form-control" data-date-format="dd/mm/yyyy" placeholder="dd/mm/aaaa" TabIndex="52">                    
                                                </asp:TextBox>
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar" /></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">

                                        <asp:Label ID="lblLugarDeNacimientoMadre" runat="server" Text="Lugar de Nac.: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlLugarNacimientoM" runat="server" CssClass="form-control" ToolTip="Seleccionar la Provincia"
                                                DataTextField="nombre" DataValueField="idProvincia" TabIndex="53">
                                            </asp:DropDownList>
                                        </div>
                                        <asp:Label ID="lblNAcionalidadMadre" runat="server" Text="Nacionalidad: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlNacionalidadM" runat="server" CssClass="form-control" DataTextField="nombre" DataValueField="idPais" TabIndex="54">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <hr />

                                <div class="row-fluid">
                                    <div class="form-group">
                                        <h4>Datos del Padre</h4>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblApellidoPadre" runat="server" Text="Apellido: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtApellidoPadre" CssClass="form-control" runat="server" ToolTip="Solo números" TabIndex="56"></asp:TextBox>
                                        </div>
                                        <asp:Label ID="lblNombrePadre" runat="server" Text="Nombre: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtNombrePadre" runat="server" CssClass="form-control" TabIndex="57"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblDniPadre" runat="server" Text="DU: " class="col-md-2 control-label"></asp:Label>
                                        <asp:Label ID="lblIdParentescoP" Visible="false" runat="server">0</asp:Label>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtDUPadre" runat="server" CssClass="form-control" TabIndex="55"></asp:TextBox>
                                        </div>
                                        <asp:Label ID="lblFechaNacimientoPadre" runat="server" Text="Fecha De Nac.: " class="col-sm-2 control-label"></asp:Label>
                                        <div class="col-sm-4">
                                            <div class="input-group date form_date " data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="dd-mm-yyyy">
                                                <asp:TextBox runat="server" ID="txtFNacPadre" class="form-control" data-date-format="dd/mm/yyyy" placeholder="dd/mm/aaaa" TabIndex="58">                    
                                                </asp:TextBox>
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar" /></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="form-group">
                                        <asp:Label ID="lblLugarNacimientoPadre" runat="server" Text="Lugar Nac.: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlLugarNacimientoP" runat="server" CssClass="form-control" ToolTip="Seleccionar la Provincia"
                                                DataTextField="nombre" DataValueField="idProvincia" TabIndex="59">
                                            </asp:DropDownList>
                                        </div>
                                        <asp:Label ID="lblNacionalidadPadre" runat="server" Text="Nacionalidad: " class="col-md-2 control-label"></asp:Label>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlNacionalidadP" runat="server" CssClass="form-control" DataTextField="nombre" DataValueField="idPais" TabIndex="60">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title">Campos Requeridos</h5>
                </div>

                <div class="modal-body">
                    <!-- The messages container -->
                    <ul id="errors"></ul>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Botones" runat="server">
    <asp:UpdatePanel ID="upBotones" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="text-align: center">
                <asp:Button ID="btnGuardarRem" runat="server" CssClass="btn btn-info" Text="Guardar y Volver" ToolTip="Vuelve a Remediar"
                    OnClick="btnGuardarRem_Click" TabIndex="61" />
                <asp:Button ID="btnGuardarClasif" runat="server" CssClass="btn btn-info" Text="Guardar y Clasificar" ToolTip="Vuelve a Clasificacion"
                    OnClick="btnGuardarClasif_Click" TabIndex="62" />
                <asp:Button ID="btnGuardarCP" runat="server" CssClass="btn btn-info" Text="Guardar y VolverCPerinatal" ToolTip="Vuelve a ControlPerinatal"
                    OnClick="btnGuardarCP_Click" TabIndex="63" />
                <asp:Button ID="btnGuardarCM" runat="server" CssClass="btn btn-info" Text="Guardar y VolverCMenor" ToolTip="Vuelve a ControlMenor"
                    OnClick="btnGuardarCM_Click" TabIndex="64" />
                <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-info" Text="Guardar" OnClick="btnGuardar_Click" TabIndex="65" />
                <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-info" Text="Cancelar" OnClick="btnCancelar_Click" TabIndex="66" />
                <asp:Label EnableViewState="False" ID="Label1" runat="server"></asp:Label>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:HiddenField ID="hdfFormValido" runat="server" />
    <asp:HiddenField ID="hdfMotivo" Value="0" runat="server" />
    <asp:HiddenField ID="hdfUrbano" runat="server" />
    <asp:HiddenField ID="hdfCodigoPaisCelular" runat="server" />
    <asp:HiddenField ID="hdfCodigoPaisTelFijo" runat="server" />
    <asp:HiddenField ID="hdfDocumentoValido" runat="server" />
    <asp:HiddenField ID="hdfProvinciaDomicilio" runat="server" />
    <asp:HiddenField ID="hdfDepartamento" runat="server" />
    <asp:HiddenField ID="hdfLocalidad" runat="server" />
    <asp:HiddenField ID="hdfBarrio" runat="server" />

    <script type="text/javascript">
        $("#autocomplete").on('focus', function () {
            geolocate();
        });

        var placeSearch, autocomplete;
        var componentForm = {
            administrative_area_level_2: 'long_name', //Departamento
            street_number: 'short_name', //Nro de Calle
            route: 'long_name', //Nombre Calle
            locality: 'long_name', //Localidad
            country: 'long_name',
            postal_code: 'short_name'
        };

        window.onload = function initAutocomplete() {

            //Esta parte muestra notificaciones al usuario
            $('#btnConsultar').pulsate();
            $("#alertMessage").fadeTo(5000, 0).slideUp(1000, function () {
                $(this).remove();
            });

            // Create the autocomplete object, restricting the search to geographical
            // location types.           

            var validaDni = $('#<%= hdfDocumentoValido.ClientID %>').val();
            if (validaDni == "false") {
                $('#<%= btnGuardar.ClientID %>').hide();
                $('#alertaError').show();
            }
            else {
                $('#<%= btnGuardar.ClientID %>').show();
                $('#alertaError').hide();
            }

            var latit = parseFloat($('#<%= txtLatitud.ClientID %>').val());
            var long = parseFloat($('#<%= txtLongitud.ClientID %>').val());

            if ((isNaN(latit)) || (isNaN(long))) {
                latit = -38.95;
                long = -68.0667;
            }

            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: latit, lng: long },
                //center: new google.maps.LatLng(lat, lng),
                zoom: 13
            });

            autocomplete = new google.maps.places.Autocomplete(
                /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
                {
                    types: ['geocode'],
                    componentRestrictions: { country: 'ar' }
                });
            autocomplete.bindTo('bounds', map);

            var infowindow = new google.maps.InfoWindow();
            var marker = new google.maps.Marker({
                map: map,
                position: { lat: latit, lng: long },
                draggable: true,
                anchorPoint: new google.maps.Point(0, -29)
            });

            infowindow.setContent('<div><strong>' + $('#<%= txtCalle.ClientID %>').val() + ' ' + $('#<%= txtNumero.ClientID%>').val() + '</strong>');
            infowindow.open(map, marker);

            google.maps.event.addListener(marker, 'dragend', function () {
                geocodePosition(marker.getPosition());
            });

            function geocodePosition(pos) {
                infowindow.close();

                geocoder = new google.maps.Geocoder();
                geocoder.geocode
                 ({
                     latLng: pos
                 },
                     function (results, status) {
                         if (status == google.maps.GeocoderStatus.OK) {
                             var calle = "";
                             var numero = "";

                             var resultado = results[0];
                             debugger;
                             for (var i = 0; i < resultado.address_components.length; i++) {
                                 var tipoDeDireccion = resultado.address_components[i].types[0];

                                 if (componentForm[tipoDeDireccion]) {

                                     switch (tipoDeDireccion) {
                                         case "street_number": numero = results[i].address_components[i].short_name;
                                             break;
                                         case "route": calle = results[i].address_components[i].short_name;
                                             break;
                                     }
                                 }
                             }

                             $('#<%= txtCalle.ClientID %>').val(calle);
                             $('#<%= txtNumero.ClientID %>').val(numero);

                             infowindow.setContent('<div><strong>' + calle + '</strong><br>' + numero);
                             infowindow.open(map, marker);

                             var latitud = pos.lat();
                             var longitud = pos.lng();

                             document.getElementById('<%= txtLatitud.ClientID %>').value = latitud;
                             document.getElementById('<%= txtLongitud.ClientID %>').value = longitud;
                         }
                         else {
                             $("#mapErrorMsg").html('Cannot determine address at this location.' + status).show(100);
                         }
                     }
                 );
                 }

            // When the user selects an address from the dropdown, populate the address
            // fields in the form.            
            autocomplete.addListener('place_changed', function () {
                infowindow.close();
                marker.setVisible(false);

                var place = autocomplete.getPlace();

                if (!place.geometry) {
                    window.alert("Autocomplete's returned place contains no geometry");
                    return;
                }

                // If the place has a geometry, then present it on a map.
                if (place.geometry.viewport) {
                    map.fitBounds(place.geometry.viewport);
                } else {
                    map.setCenter(place.geometry.location);
                    map.setZoom(17);  // Why 17? Because it looks good.
                }

                marker.setIcon(/** @type {google.maps.Icon} */({
                    url: place.icon,
                    size: new google.maps.Size(71, 71),
                    origin: new google.maps.Point(0, 0),
                    anchor: new google.maps.Point(17, 34),
                    scaledSize: new google.maps.Size(35, 35)
                }));
                marker.setPosition(place.geometry.location);
                marker.setVisible(true);
                marker.getDraggable();

                var address = '';
                if (place.address_components) {
                    address = [
                      (place.address_components[0] && place.address_components[0].short_name || ''),
                      (place.address_components[1] && place.address_components[1].short_name || ''),
                      (place.address_components[2] && place.address_components[2].short_name || '')
                    ].join(' ');
                }

                infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
                infowindow.open(map, marker);

                var latitud = place.geometry.location.lat();
                var longitud = place.geometry.location.lng();

                document.getElementById('<%= txtLatitud.ClientID %>').value = latitud;
                document.getElementById('<%= txtLongitud.ClientID %>').value = longitud;

                for (var i = 0; i < place.address_components.length; i++) {
                    var addressType = place.address_components[i].types[0];

                    if (componentForm[addressType]) {
                        var val = place.address_components[i][componentForm[addressType]];

                        switch (addressType) {
                            case 'administrative_area_level_2': var departamento = limpiar(val);
                                $('#<%= ddlDepartamento.ClientID %> option:contains(' + departamento + ')').attr("selected", "selected");
                                break;
                            case 'street_number': document.getElementById('<%= txtNumero.ClientID %>').value = val;
                                break;
                            case 'route': document.getElementById('<%= txtCalle.ClientID %>').value = val;
                                break;
                            case 'locality': var localidad = limpiar(val);
                                $('#<%= ddlLocalidad.ClientID %> option:contains(' + localidad + ')').attr("selected", "selected");
                                break;
                            case 'country': var pais = limpiar(val);
                                $('#<%= ddlNacionalidad.ClientID %> option:contains(' + pais + ')').attr("selected", "selected");
                                break;
                            case 'postal_code': document.getElementById('<%= txtCPostal.ClientID %>').value = val;
                                break;
                        }
                    }
                }
            });
        }


        // Bias the autocomplete object to the user's geographical location,
        // as supplied by the browser's 'navigator.geolocation' object.
        function geolocate() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var geolocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    var circle = new google.maps.Circle({
                        center: geolocation,
                        radius: position.coords.accuracy
                    });
                    autocomplete.setBounds(circle.getBounds());
                });
            }
        }

        function limpiar(text) {
            var text = text.toLowerCase();
            text = text.replace(/[áàäâå]/, 'a');
            text = text.replace(/[éèëê]/, 'e');
            text = text.replace(/[íìïî]/, 'i');
            text = text.replace(/[óòöô]/, 'o');
            text = text.replace(/[úùüû]/, 'u');
            text = text.replace(/[ýÿ]/, 'y');
            //text = text.replace(/[ñ]/, 'n');
            text = text.replace(/[ç]/, 'c');
            text = text.replace(/['"]/, '');
            text = text.replace(/[^a-zA-Z0-9-]/, '');
            text = text.replace(/\s+/, '-');
            text = text.replace(/' '/, '-');
            text = text.replace(/(_)$/, '');
            text = text.replace(/^(_)/, '');
            var text = text.toUpperCase();
            return text;
        }
    </script>

    <%--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCiyTMjyzxtE_QbIXi8Z1T0p16uMQiKAxc&signed_in=true&libraries=places&callback=initAutocomplete"
        async defer></script>--%>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCiyTMjyzxtE_QbIXi8Z1T0p16uMQiKAxc&libraries=places"></script>


    <script type="text/javascript">
        $('#loaderRenaper').hide();
        $('#loaderSintys').hide();

        $('#btnRenaper').click(function (e) {
            //e.preventDefault();

            var dni = $('#<%= txtNumeroDocumento.ClientID %>').val();

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/consultaRenaper") %>',
                data: "{'dni':'" + dni + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#btnRenaper').hide();
                    $("#loaderRenaper").show();
                },
                success: function (r) {

                    if (r.d != null) {

                        $('#<%= lblInfoRenaper.ClientID %>').hide();
                        $("#loaderRenaper").hide();
                        $('#btnRenaper').show();
                        $("#tblRenaper").show();

                        var customers = new Array();
                        customers.push(["Nombre", "Apellido", "Tipo Doc.", "DNI", "Fecha Nac.", "Sexo"]);
                        customers.push([r.d[0].Nombre, r.d[0].Apellido, r.d[0].TipoDocumento, r.d[0].Documento, r.d[0].FechaNacimiento, r.d[0].Sexo]);

                        //Create a HTML Table element.
                        var table = $("<table class='table table-hover' />");
                        //table[0].border = "1";

                        //Get the count of columns.
                        var columnCount = customers[0].length;

                        //Add the header row.
                        var row = $(table[0].insertRow(-1));
                        for (var i = 0; i < columnCount; i++) {
                            var headerCell = $("<th style='font-size:12px' />");
                            headerCell.html(customers[0][i]);
                            row.append(headerCell);
                        }

                        //Add the data rows.
                        for (var i = 1; i < customers.length; i++) {
                            row = $(table[0].insertRow(-1));
                            for (var j = 0; j < columnCount; j++) {
                                var cell = $("<td style='font-size:11px' />");
                                cell.html(customers[i][j]);
                                row.append(cell);
                            }
                        }

                        var dvTable = $("#tblRenaper");
                        dvTable.html("");
                        dvTable.append(table);
                    } else {
                        $("#loaderRenaper").hide();
                        $('#btnRenaper').show();
                        $("#tblRenaper").hide();
                        $('#<%= lblInfoRenaper.ClientID %>').show();
                        $('#<%= lblInfoRenaper.ClientID %>').text("El DNI ingresado no se encuentra en Renaper");
                    }
                }
            });
        });
        //});

        $('#btnSyntis').click(function (e) {
            //e.preventDefault();

            var dni = $('#<%= txtNumeroDocumento.ClientID %>').val();

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/consultaSintys") %>',
                data: "{'dni':'" + dni + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#btnSyntis').hide();
                    $("#loaderSintys").show();
                },
                success: function (r) {
                    if (r.d != '') {
                        $("#loaderSintys").hide();
                        $('#btnSyntis').show();
                        $('#<%= lblInfoSintys.ClientID %>').hide();
                        $("#tblSintys").show();

                        var customers = new Array();
                        customers.push(["Nombre Completo", "Tipo Doc.", "DNI", "Fecha Nac.", "Sexo"]);
                        customers.push([r.d[0].NombreCompleto, r.d[0].TipoDocumento, r.d[0].Documento, r.d[0].FechaNacimiento, r.d[0].Sexo]);

                        //Create a HTML Table element.
                        var table = $("<table class='table table-hover' />");
                        table[0].border = "1";

                        //Get the count of columns.
                        var columnCount = customers[0].length;

                        //Add the header row.
                        var row = $(table[0].insertRow(-1));
                        for (var i = 0; i < columnCount; i++) {
                            var headerCell = $("<th style='font-size:12px'/>");
                            headerCell.html(customers[0][i]);
                            row.append(headerCell);
                        }

                        //Add the data rows.
                        for (var i = 1; i < customers.length; i++) {
                            row = $(table[0].insertRow(-1));
                            for (var j = 0; j < columnCount; j++) {
                                var cell = $("<td style='font-size:11px'/>");
                                cell.html(customers[i][j]);
                                row.append(cell);
                            }
                        }

                        var dvTable = $("#tblSintys");
                        dvTable.html("");
                        dvTable.append(table);
                    } else {
                        $("#loaderSintys").hide();
                        $('#btnSyntis').show();
                        $("#tblSintys").hide();
                        $('#<%= lblInfoSintys.ClientID %>').show();
                        $('#<%= lblInfoSintys.ClientID %>').text("El DNI no se encuentra en Sintys");
                    }
                },
            });
        });



    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('[data-toggle=offcanvas]').click(function () {
                $('.row-offcanvas').toggleClass('active');
            });
        });
    </script>


    <script type="text/javascript">

        $(document).ready(function () {
            var urbano = $('#<%= hdfUrbano.ClientID %>').val();

            if (urbano == "false")
                $('#<%= lblRural.ClientID %>').attr("class", "btn btn-info active");
            else
                $('#<%= lblUrbano.ClientID %>').attr("class", "btn btn-info active");
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            var obraSocial = $('#<%= txtObraSocial.ClientID %>').val();

            $('#<%= txtNumeroExtranjero.ClientID%>').hide();
            $("#<%= lblExtranjero.ClientID %>").hide();
            $('#alertaError').hide();

            if (obraSocial != "") {
                $('#<%= divObraSocial.ClientID %>').show();
                $('#typehead').hide();
            } else {
                $('#<%= divObraSocial.ClientID %>').hide();
                $('#typehead').show();
            }

            $("#btnLimpiaObraSocial").click(function () {
                $('#<%= txtObraSocial.ClientID %>').val('');
                $('#<%= divObraSocial.ClientID %>').hide();
                $('#typehead').show();
            });
        });
    </script>

    <script type="text/javascript">
        $('#obraSocial').typeahead({
            source: function (query, process) {
                states = [];
                map = {};
                debugger;
                var data = <%= llenarObrasSociales()%>

                $.each(data, function (i, state) {
                    map[state.nombre] = state;
                    states.push(state.nombre);
                });
                process(states);
            },
            updater: function (item) {
                selecIdObraSocial = map[item].idObraSocial;
                selecNombre = map[item].nombre;
                document.getElementById("<%=hdfIdObraSocial.ClientID%>").value = selecIdObraSocial;
                document.getElementById("<%=hdfNombre.ClientID%>").value = selecNombre;
                return item;
            },
        });
    </script>

    <script type="text/javascript">
        $('.date')
        .datepicker({
            format: 'dd/mm/yyyy',
            autoclose: 1,
            language: "es",
        })
        .on('changeDate', function (e) {

            $('#aspnetForm').formValidation('revalidateField', '<%= txtFechaNac.UniqueID %>')
            $('#aspnetForm').formValidation('revalidateField', '<%= txtFNacMadre.UniqueID %>');

        });

        var codigoPaisCelular = $('#<%= hdfCodigoPaisCelular.ClientID %>').val();
        var codigoPaisTelFijo = $('#<%= hdfCodigoPaisTelFijo.ClientID %>').val();

        var paisInicialCelular = devuelvePrefijoPais(codigoPaisCelular);
        var paisInicialTelFijo = devuelvePrefijoPais(codigoPaisTelFijo);

        function devuelvePrefijoPais(codigoPais) {
            var codigo = '';

            switch (codigoPais) {
                case "54": codigo = 'ar';
                    break;
                case "56": codigo = 'cl';
                    break;
                case "598": codigo = 'uy';
                    break;
                case "591": codigo = 'bo';
                    break;
                case "57": codigo = 'co';
                    break;
                case "593": codigo = 'ec';
                    break;
                case "595": codigo = 'py';
                    break;
                case "58": codigo = 've';
                    break;
                default: codigo = 'ar';
                    break;
            }

            return codigo;
        }

        $('#aspnetForm').find('[name="<%= ddlSexo.UniqueID %>"]')
            .change(function (e) {
                // revalidate the color when it is changed
                $('#bootstrapSelectForm').formValidation('revalidateField', '<%= ddlSexo.UniqueID %>');
            })
            .end()
        .find("[name='<%= txtTCelular.UniqueID %>']")
            .intlTelInput({
                utilsScript: 'js/utils.js',
                autoPlaceholder: true,
                preferredCountries: ['ar', 'cl', 'uy'],
                onlyCountries: ['ar', 'cl', 'uy', 'co', 'py', 'bo', 'ec', 've'],
                initialCountry: paisInicialCelular
            });

        $('#aspnetForm').find("[name='<%= txtTFijo.UniqueID %>']")
        .intlTelInput({
            utilsScript: 'js/utils.js',
            autoPlaceholder: true,
            preferredCountries: ['ar', 'cl', 'uy'],
            onlyCountries: ['ar', 'cl', 'uy', 'co', 'py', 'bo', 'ec', 've'],
            initialCountry: paisInicialTelFijo
        });



        //Filtro el combo de localidad según provincia seleccionada
        function llenaDepartamento() {
            var idProvincia = $('#<%= ddlProvinciaDomicilio.ClientID %>').find('option:selected').val();
            //Asigno el valor al hdfProvincia para que quede seteado el selected
            $('#<%= hdfProvinciaDomicilio.ClientID %>').val(idProvincia);

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/llenaDepartamentos") %>',
                data: "{'idProvincia':'" + idProvincia + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlDepartamentos = $("[id*=ddlDepartamento]");
                    ddlDepartamentos.empty().append('<option id="ddlDepartamento" name="ddlDepartamento" selected="selected" CssClass="form-control" value="0">Seleccione Departamento</option>');
                    var x = 0;
                    $.each(r.d, function () {
                        ddlDepartamentos.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    //Limpia los combos de Localidad y Barrio
                    $('#<%=ddlLocalidad.ClientID%>').empty();
                    $('#<%=ddlBarrio.ClientID%>').empty();

                }
            });
        }

        //Filtro el combo de localidad según departamento seleccionado
        function llenaLocalidad() {
            var idDepartamento = $('#<%= ddlDepartamento.ClientID %>').find('option:selected').val();
            //Asigno el valor al hdfDepartamento para que quede seteado el selected
            $('#<%= hdfDepartamento.ClientID %>').val(idDepartamento);

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/llenaLocalidades") %>',
                data: "{'idDepartamento':'" + idDepartamento + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlLocalidades = $("[id*=ddlLocalidad]");
                    ddlLocalidades.empty().append('<option id="ddlLocalidad" name="ddlLocalidad" selected="selected" CssClass="form-control" value="0">Seleccione Localidad</option>');
                    var x = 0;
                    $.each(r.d, function () {
                        ddlLocalidades.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    $('#<%=ddlBarrio.ClientID%>').empty();

                }
            });
        }

        //Filtro el combo de Barrio según localidad seleccionada
        function llenaBarrios() {
            var idLocalidad = $('#<%= ddlLocalidad.ClientID %>').find('option:selected').val();
            //Asigno el valor al hdfLocalidad para que quede seteado el selected
            $('#<%= hdfLocalidad.ClientID %>').val(idLocalidad);

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/llenaBarrios") %>',
                data: "{'idLocalidad':'" + idLocalidad + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlBarrios = $("[id*=ddlBarrio]");
                    ddlBarrios.empty().append('<option id="ddlBarrio" name="ddlBarrio" selected="selected" CssClass="form-control" value="0">Seleccione Barrio</option>');
                    var x = 0;
                    $.each(r.d, function () {
                        ddlBarrios.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                }
            });
        }

        function seleccionarBarrio() {
            var idBarrio = $('#<%= ddlBarrio.ClientID %>').find('option:selected').val();
            //Asigno el valor al hdfBarrio para que quede seteado el selected
            $('#<%= hdfBarrio.ClientID %>').val(idBarrio);
        }


       
        $(document).ready(function () {
       
        var estado = $('#aspnetForm').find('[name="<%=  ddlEstadoP.UniqueID %>"]').val();

            //Este método sirve para mantener el estado del combo MotivoNI después de un postback.
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/llenaDdlMotivoNI") %>',
                data: "{'idEstado':'" + estado + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlCustomers = $("[id*=ddlMotivoNI]");
                    ddlCustomers.empty().append('<option id="ddlMotivoNI" name="ddlMotivoNI" selected="selected" CssClass="form-control" value="0">Seleccione</option>');
                    var x = 0;
                    $.each(r.d, function () {
                        ddlCustomers.append($("<option></option>").val(this['Value']).html(this['Text']));
                        $("#ddlMotivoNI option:contains(Extranjero)").attr('selected', true);
                    });

                    var element = document.getElementById('<%=  ddlMotivoNI.ClientID %>');
                    var motivo = $('#<%= hdfMotivo.ClientID %>').val();

                    for (var z = 0; z < element.length; z++) {
                        if (element.options[z].value == motivo) {
                            if (motivo == 1) {
                                $('#<%= txtNumeroDocumento.ClientID%>').prop("disabled", true);
                            } else if (motivo == 2) {
                                $("#<%= lblNumeroDocumento.ClientID %>").hide();
                                $("#<%= txtNumeroDocumento.ClientID %>").hide();
                                $('#<%= txtNumeroExtranjero.ClientID%>').show();
                                $("#<%= lblExtranjero.ClientID %>").show();
                            }
                        element.value = z;
                    }
                }
                },
            });

            //Llenado de combos relacionados por AJAX

            var provinciaSelected = $('#<%=hdfProvinciaDomicilio.ClientID%>').val();
            if (provinciaSelected == "0") //Esto verifica si tiene que cargar las provincias por primera vez
            {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/llenaProvincias") %>',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddlProvincias = $("[id*=ddlProvinciaDomicilio]");
                        ddlProvincias.empty().append('<option id="ddlProvinciaDomicilio" name="ddlProvinciaDomicilio" selected="selected" CssClass="form-control" value="0">Seleccione Provincia</option>');
                        var x = 0;
                        $.each(r.d, function () {
                            ddlProvincias.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });


                    }
                });
            }

           
            $('#aspnetForm')

            .formValidation({
                framework: 'bootstrap',
                message: 'El valor no es válido!',
                err: {
                    container: '#errors'
                },
                icon: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh fa-spin'
                },
                fields: {
                    '<%= ddlMotivoNI.UniqueID %>': {
                        row: '.col-sm-2',
                        validators: {
                            callback: {
                                message: 'El Motivo es requerido',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlMotivoNI.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return (options != '0') || (estado != 2);
                                }
                            }
                        }
                    },
                    '<%= txtNumeroDocumento.UniqueID %>': {
                        row: '.col-sm-2',
                        validators: {
                            regexp: {
                                regexp: /^[0-9]\d{6,8}$/,
                                message: 'Debe ingresar sólo número '
                            },
                            callback: {
                                message: 'El DNI es requerido',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= txtNumeroDocumento.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    if (estado == 2) {
                                        $('#<%= txtNumeroDocumento.ClientID%>').prop("disabled", true);
                                        return false;
                                    } else if (options != '')
                                        return true;
                                    else
                                        return false;
                                }
                            }
                        }
                    },
                    '<%= txtNumeroExtranjero.UniqueID %>': {
                        row: '.col-sm-2',
                        validators: {
                            notEmpty: {
                                message: 'El DNI extranjero es requerido'
                            }
                        }
                    },
                    '<%= txtApellido.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'El Apellido es requerido'
                            }
                        }
                    },
                    '<%= txtNombre.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'El Nombre es requerido'
                            }
                        }
                    },
                    '<%= ddlSexo.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'Seleccione el sexo',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlSexo.UniqueID %>').val();
                                    return (options != 1);
                                }
                            }
                        }
                    },
                    '<%= txtTCelular.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'El número de celular no es válido',
                                callback: function (value, validator, $field) {

                                    var codigoPais = $field.intlTelInput("getSelectedCountryData");

                                    $('#<%= hdfCodigoPaisCelular.ClientID %>').val(codigoPais.dialCode);

                                    return value === '' || $field.intlTelInput('isValidNumber');
                                }
                            }
                        }
                    },
                    '<%= txtTFijo.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'El número de teléfono no es válido',
                                callback: function (value, validator, $field) {
                                    var codigoPais = $field.intlTelInput("getSelectedCountryData");

                                    $('#<%= hdfCodigoPaisTelFijo.ClientID %>').val(codigoPais.dialCode);

                                    return value === '' || $field.intlTelInput('isValidNumber');
                                }
                            }
                        }
                    },
                    '<%= txtEmail.UniqueID %>': {
                        row: '.col-sm-6',
                        validators: {
                            emailAddress: {
                                message: 'El e-Mail no es válido.'
                            },
                            regexp: {
                                regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                                message: 'El e-Mail no es válido.'
                            }
                        }
                    },
                    '<%= txtFechaNac.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'La fecha es requerida'
                            },
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'El formato de fecha no es válido'
                            }
                        }
                    },
                    '<%= ddlNacionalidad.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'La Nacionalidad es requerida',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlNacionalidad.UniqueID %>').val();
                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= ddlProvincia.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'La Provincia es requerida',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlProvincia.UniqueID %>').val();
                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= ddlProvinciaDomicilio.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'La Provincia es requerida',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlProvinciaDomicilio.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= ddlDepartamento.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'El Departamento es requerido',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlProvincia.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlDepartamento.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= ddlLocalidad.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'La Localidad es requerida',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlLocalidad.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= ddlBarrio.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            callback: {
                                message: 'El Barrio es requerido',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= ddlBarrio.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= txtCalle.UniqueID %>': {
                        row: '.col-md-8',
                        validators: {
                            callback: {
                                message: 'La calle es requerida',
                                callback: function (value, validator, $field) {
                                    var options = validator.getFieldElements('<%= txtCalle.UniqueID %>').val();

                                    var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                    return ((options != '-1') || (estado != '3'));
                                }
                            }
                        }
                    },
                    '<%= txtNumero.UniqueID %>': {
                        row: '.col-md-8',
                        validators: {
                            message: 'El número es requerido',
                            callback: function (value, validator, $field) {
                                var options = validator.getFieldElements('<%= txtNumero.UniqueID %>').val();

                                var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                return ((options != '') || (estado != '3'));
                            }
                        }
                    },
                    '<%= txtReferencia.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            message: 'La referencia es requerida',
                            callback: function (value, validator, $field) {
                                var options = validator.getFieldElements('<%= txtReferencia.UniqueID %>').val();

                                var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                return ((options != '') || (estado != '3'));
                            }
                        }
                    },
                    '<%= txtFNacMadre.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            message: 'La fecha de nacimiento es requerida',
                            callback: function (value, validator, $field) {

                                var options = validator.getFieldElements('<%= txtFNacMadre.UniqueID %>').val();

                                var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();

                                return ((options != '') || (estado != '3'));
                            }
                        }
                    },
                    '<%= txtNumeroM.UniqueID %>': {
                        row: '.col-sm-4',
                        enabled:false,
                        validators: {
                            message: 'El DNI es requerido',
                            regexp: {
                                regexp: /^[0-9]\d{6,8}$/,
                                message: 'El documento ingresado no es válido '
                            },
                            notEmpty: {
                                message: 'El número de documento de la madre no puede estar vacío'
                            },
                            callback: function (value, validator, $field) {
                                var options = validator.getFieldElements('<%= txtNumeroM.UniqueID %>').val();
                                alert(options);
                                var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();
                                alert(estado);
                                return ((options != '') || (estado != '3'));
                            }
                        }
                    },
                    '<%= txtApellidoM.UniqueID %>': {
                        row: '.col-sm-4',
                        enabled: false,
                        validators: {
                            message: 'El Apellido de la madre es requerido',
                            notEmpty: {
                                message: 'El apellido de la madre no puede ser vacío'
                            },
                            stringLength: {
                                min: 2,
                                max: 60,
                                message: 'El apellido ingresado no es válido'
                            },
                            callback: function (value, validator, $field) {

                                var options = validator.getFieldElements('<%= txtApellidoM.UniqueID %>').val();
                                alert(options);
                                var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();
                                alert(estado);
                                return ((options != '') || (estado != '3'));
                            }
                        }
                    },

                    '<%= txtNombreM.UniqueID %>': {
                        row: '.col-sm-4',
                        enabled: true,
                        validators: {
                            message: 'El Nombre de la madre es requerido',
                            notEmpty: {
                                message: 'El nombre de la madre no puede ser vacío'
                            },
                            stringLength: {
                                min: 2,
                                max: 60,
                                message: 'El nombre ingresado no es válido'
                            },
                            callback: function (value, validator, $field) {

                                var options = validator.getFieldElements('<%= txtNombreM.UniqueID %>').val();
                                alert(options);
                                var estado = validator.getFieldElements('<%= ddlEstadoP.UniqueID %>').val();
                                alert(estado);
                                return ((options != '') || (estado != '3'));
                            }
                        }
                    },

                    err: {
                        container: 'popover'
                    }
                }
            }).on('click', '.country-list', function () {
                $('#aspnetForm').formValidation('revalidateField', '<%= txtTCelular.UniqueID %>')
                .formValidation('revalidateField', '<%= txtTFijo.UniqueID %>');

            }).on('change', '[name="<%= ddlEstadoP.UniqueID %>"]', function (e) {

            }).on('change', '[name="<%= ddlEstadoP.UniqueID %>"]', function (e) {
                var estado = $('#aspnetForm').find('[name="<%=  ddlEstadoP.UniqueID %>"]').val();

                $.ajax({
                    type: "POST",
                    url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/llenaDdlMotivoNI") %>',
                    data: "{'idEstado':'" + estado + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddlCustomers = $("[id*=ddlMotivoNI]");
                        ddlCustomers.empty().append('<option id="ddlMotivoNI" name="ddlMotivoNI" selected="selected" CssClass="form-control" value="0">Seleccione</option>');
                        var x = 0;
                        $.each(r.d, function () {
                            ddlCustomers.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    },
                });

                var habilitado = ((estado == "1") || (estado == "3")) ? $('#<%= txtNumeroDocumento.ClientID%>').prop("disabled", false) : $('#<%= txtNumeroDocumento.ClientID%>').prop("disabled", true);

                switch (estado) {
                    case "1": $('#aspnetForm')
                        .formValidation('enableFieldValidators', "<%= txtFechaNac.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlNacionalidad.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlProvincia.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlProvinciaDomicilio.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlDepartamento.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlLocalidad.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlBarrio.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtCalle.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNumero.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtReferencia.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtFNacMadre.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNumeroM.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtApellidoM.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNombreM.UniqueID %>", false);


                        $("#<%= lblNumeroDocumento.ClientID %>").show();
                        $("#<%= txtNumeroDocumento.ClientID %>").show();
                        $('#<%= txtNumeroExtranjero.ClientID%>').hide();
                        $("#<%= lblExtranjero.ClientID %>").hide();

                        $('#<%= txtNumeroDocumento.ClientID%>').val();
                        break;
                    case "2": $('#aspnetForm')
                        .formValidation('enableFieldValidators', "<%= txtNumeroDocumento.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtFechaNac.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlNacionalidad.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlProvincia.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlProvinciaDomicilio.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlDepartamento.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlLocalidad.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlBarrio.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtCalle.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNumero.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtReferencia.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtFNacMadre.UniqueID %>", false);


                        $('#<%= txtNumeroDocumento.ClientID%>').val('');
                        break;
                    case "3": $('#aspnetForm')
                        .formValidation('enableFieldValidators', "<%= txtNumeroDocumento.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtFechaNac.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlNacionalidad.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlProvincia.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlProvinciaDomicilio.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlDepartamento.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlLocalidad.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= ddlBarrio.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtCalle.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtNumero.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtReferencia.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtFNacMadre.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtNumeroM.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtApellidoM.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNombreM.UniqueID %>", false);

                        $("#<%= lblNumeroDocumento.ClientID %>").show();
                        $("#<%= txtNumeroDocumento.ClientID %>").show();
                        $('#<%= txtNumeroExtranjero.ClientID%>').hide();
                        $("#<%= lblExtranjero.ClientID %>").hide();

                        $('#<%= txtNumeroDocumento.ClientID%>').val();
                        break;
                }

            }).on('change', '[name="<%= txtNumeroDocumento.UniqueID %>"]', function (e) {
                var estado = $('#aspnetForm').find('[name="<%=  ddlEstadoP.UniqueID %>"]').val();

                if ((estado == "1") || (estado == "3")) {
                    var dni = $('#<%= txtNumeroDocumento.ClientID%>').val();

                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveUrl("~/Paciente/PacienteEdit.aspx/verificarNroDocumento") %>',
                        data: "{'dni':'" + dni + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            if (r.d != "") {
                                $('#alertaError').show();
                                $("#<%= lblMensaje.ClientID %>").text(r.d);
                                $("#<%= btnGuardar.ClientID %>").hide();
                                $('#<%= hdfDocumentoValido.ClientID %>').val("false");
                            } else {
                                $("#alertaError").hide();
                                $("#<%= lblMensaje.ClientID %>").text('');
                                $("#<%= btnGuardar.ClientID %>").show();
                                $('#<%= hdfDocumentoValido.ClientID %>').val("true");
                            }
                        },
                    });
                }

            }).on('change', '[name="<%= ddlMotivoNI.UniqueID %>"],[name="<%= txtNumeroM.UniqueID %>"],[name="<%= txtNombreM.UniqueID %>"],[name="<%= txtApellidoM.UniqueID %>"]', function (e) {
                var motivo = $('#aspnetForm').find('[name="<%= ddlMotivoNI.UniqueID %>"]').val();
                
                $('#<%= hdfMotivo.ClientID %>').val(motivo);

                switch (motivo) {
                    case "1": $('#aspnetForm')
                    .formValidation('enableFieldValidators', "<%= txtNumeroDocumento.UniqueID %>", false)
                    .formValidation('enableFieldValidators', "<%= txtFechaNac.UniqueID %>", true)
                    .formValidation('enableFieldValidators', "<%= txtNumeroM.UniqueID %>", true)
                    .formValidation('enableFieldValidators', "<%= txtApellidoM.UniqueID %>", true)
                    .formValidation('enableFieldValidators', "<%= txtNombreM.UniqueID %>", true);

                        $("#<%= lblNumeroDocumento.ClientID %>").show();
                        $("#<%= txtNumeroDocumento.ClientID %>").show();
                        $('#<%= txtNumeroExtranjero.ClientID%>').hide();
                        $("#<%= lblExtranjero.ClientID %>").hide();
                        break;
                    case "2": $('#aspnetForm')
                        .formValidation('enableFieldValidators', "<%= txtNumeroExtranjero.UniqueID %>", true)
                        .formValidation('enableFieldValidators', "<%= txtFechaNac.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlNacionalidad.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlProvincia.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlProvinciaDomicilio.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlDepartamento.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlLocalidad.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= ddlBarrio.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtCalle.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNumero.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtReferencia.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtFNacMadre.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNumeroM.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtApellidoM.UniqueID %>", false)
                        .formValidation('enableFieldValidators', "<%= txtNombreM.UniqueID %>", false);
                        

                        $("#<%= lblNumeroDocumento.ClientID %>").hide();
                        $("#<%= txtNumeroDocumento.ClientID %>").hide();
                        $('#<%= txtNumeroExtranjero.ClientID%>').show();
                        $("#<%= lblExtranjero.ClientID %>").show();
                        break;
                }

             

            }).on('success.form.fv', function (e) {
                // Reset the message element when the form is valid
                $('#errors').html('');
            }).on('err.field.fv', function (e, data) {
                data.fv.disableSubmitButtons(true);

                var messages = data.fv.getMessages(data.element);

                // Remove the field messages if they're already available
                $('#errors').find('li[data-field="' + data.field + '"]').remove();

                // Loop over the messages
                for (var i in messages) {
                    // Create new 'li' element to show the message
                    $('<li/>')
                        .attr('data-field', data.field)
                        .wrapInner(
                            $('<a/>')
                                .attr('href', 'javascript: void(0);')
                                .html(messages[i])
                                .on('click', function (e) {
                                    // Hide the modal first
                                    $('#messageModal').modal('hide');

                                    // Focus on the invalid field
                                    data.element.focus();
                                })
                        )
                        .appendTo('#errors');
                }

                // Hide the default message
                // data.element.data('fv.messages') returns the field messages element
                data.element
                    .data('fv.messages')
                    .find('.help-block[data-fv-for="' + data.field + '"]')
                    .hide();

                $("#<%= hdfFormValido.ClientID %>").val("false");

            }).on('success.field.fv', function (e, data) {
                data.fv.disableSubmitButtons(false);

                $('#errors').find('li[data-field="' + data.field + '"]').remove();
            }).on('success.form.fv', function (e) {

                $("#<%= hdfFormValido.ClientID %>").val("true");
            }).on('err.validator.fv', function (e, data) {

                if (data.field === '<%= txtEmail.UniqueID %>') {
                    // The email field is not valid

                    data.element
                        .data('fv.messages')
                        // Hide all the messages
                        .find('.help-block[data-fv-for="' + <%= txtEmail.UniqueID %> + '"]').hide()
                        // Show only message associated with current validator
                        .filter('[data-fv-validator="' + data.validator + '"]').show();
                }
            }).on('err.form.fv', function (e) {
                // Show the message modal
                $('#messageModal').modal('show');
            });
        });
    </script>

</asp:Content>
