<%@ Page Title="" Language="C#" MasterPageFile="~/mPaciente.Master" AutoEventWireup="true" CodeBehind="PacienteList.aspx.cs" Inherits="Empadronamiento.PacienteList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Cuerpo" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-xs-6 col-sm-8 col-md-12 col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Empadronamiento de Pacientes
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <asp:Label ID="lblDni" runat="server" Text="Documento: " class="col-xs-6 col-md-4 control-label"></asp:Label>
                                <div class="col-xs-6 col-md-8">
                                    <asp:TextBox ID="txtDni" runat="server" autocomplete="off" MaxLength="9" class="form-control" ToolTip="Solo números"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblApellido" runat="server" Text="Apellido: " class="col-xs-6 col-sm-4 control-label"></asp:Label>
                                <div class="col-xs-6 col-sm-8">
                                    <asp:TextBox ID="txtApellido" runat="server" autocomplete="off" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <asp:Label ID="lblFechaDeNacimiento" runat="server" Text="Fecha de Nac.: " class="col-xs-6 col-sm-4 control-label"></asp:Label>
                                <div class="col-xs-6 col-sm-8">
                                    <div class="input-group input-append date" id="datePicker">
                                        <asp:TextBox runat="server" ID="txtFecNacBusqueda" class="form-control">                    
                                        </asp:TextBox>
                                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblNombre" runat="server" Text="Nombre: " CssClass="col-xs-6 col-md-4 control-label"></asp:Label>
                                <div class="col-xs-6 col-md-8">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <hr>
                        </div>
                        <h3 class="panel-title">Datos Madre/Tutor
                        </h3>
                        <br />
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblDniMadre" runat="server" Text="Documento: " class="col-xs-6 col-sm-5 control-label"></asp:Label>
                                <div class="col-xs-6 col-sm-7">
                                    <asp:TextBox ID="txtDniMadre" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-1 col-xs-6 col-md-5 ">
                                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" class="btn btn-primary btn-lg btn-block" OnClick="btnBuscar_Click"/>
                                </div>
                                <div class="col-md-offset-1 col-xs-6 col-md-5">
                                    <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" OnClick="btnNuevo_Click"
                                        ToolTip="Ingresar un nuevo Paciente" class="btn btn-primary btn-lg btn-block" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblApellidoMadre" runat="server" Text="Apellido (Soltera): " class="col-xs-6 col-sm-5 control-label"></asp:Label>
                                <div class="col-xs-6 col-sm-7">
                                    <asp:TextBox ID="txtApellidoMadre" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblNombreMadre" runat="server" Text="Nombre: " class="col-xs-6 col-sm-5 control-label"></asp:Label>
                                <div class="col-xs-6 col-sm-7">
                                    <asp:TextBox ID="txtNombreMadre" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-xs-12 col-md-12">
                        <hr>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12 col-md-8">
                                <div class="col-xs-12 col-md-6">
                                    <h4>Referencia Estados:</h4>
                                </div>
                                <div class="col-xs-12 col-md-2">
                                    <h4><span class="label label-success">Validado</span></h4>
                                </div>
                                <div class="col-xs-12 col-md-2">
                                    <h4><span class="label label-warning">Identificado</span></h4>
                                </div>
                                <div class="col-xs-12 col-md-2">
                                    <h4><span class="label label-danger">Temporal</span></h4>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="col-xs-3 col-sm-8 col-md-12 col-lg-12 table-responsive">
                            <h4>Padrón Unico de Pacientes</h4>
                            <asp:GridView ID="gvPacientes" runat="server" CssClass="table table-responsive" GridLines="None" PagerStyle-CssClass="pgr"
                                AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="False" OnSorting="gridView_Sorting"
                                AllowPaging="True" OnPageIndexChanging="gvPacientes_PageIndexChangind" EmptyDataText="<b>No se encontraron datos.</b>"
                                OnRowDataBound="gvPacientes_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="numeroDocumento" HeaderText="Nro Doc" />
                                    <asp:BoundField DataField="apellido" HeaderText="Apellido" />
                                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                                    <asp:BoundField DataField="sexo" HeaderText="Sexo" />
                                    <asp:BoundField DataField="fechaNacimiento" DataFormatString="{0:dd/MM/yyy}" HeaderText="Fec.Nac" />
                                    <asp:BoundField DataField="historiaclinica" HeaderText="HC" />
                                    <%--<asp:BoundField DataField="fallecido" HeaderText="Fallecido"></asp:BoundField>--%>
                                    <asp:HyperLinkField DataNavigateUrlFields="idPaciente" DataNavigateUrlFormatString="~/Paciente/PacienteView.aspx?id={0}"
                                        HeaderText="Ver" Text="<i style='color:black' class='fa fa-eye fa-fw'></i>" />
                                    <asp:HyperLinkField DataNavigateUrlFields="idPaciente" DataNavigateUrlFormatString="~/Paciente/PacienteEdit.aspx?id={0}"
                                        HeaderText="Editar" Text="<i style='color:black' class='fa fa-pencil fa-fw'></i>" />
                                    <%--<asp:HyperLinkField DataNavigateUrlFields="idPaciente" DataNavigateUrlFormatString="~/Paciente/PacienteDefuncion.aspx?id={0}"
                                        HeaderText="Defunción" Text="<i style='color:black' class='fa fa-file fa-fw'></i>" />--%>
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                                <AlternatingRowStyle CssClass="alt" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6 col-sm-8 col-md-12 col-lg-12 table-responsive">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-info ">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">Padrón de Obras Sociales
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:GridView ID="gvPersonas" runat="server" CssClass="table table-responsive" GridLines="None" PagerStyle-CssClass="pgr"
                                    AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="false" EmptyDataText="No se encontraron datos."
                                    PageSize="10" AllowPaging="True" OnPageIndexChanging="gvPersonas_PageIndexChangind">
                                    <Columns>
                                        <asp:BoundField DataField="tipoDocumento" HeaderText="Tipo" />
                                        <asp:BoundField DataField="Documento" HeaderText="Número" />
                                        <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                                        <asp:BoundField DataField="ObraSocial" HeaderText="Obra Social" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">


        $('#datePicker')
        .datepicker({
            format: 'dd/mm/yyyy',
            language: 'es',
            autoclose: 1,
        });


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
                                    message: 'El número de documento no debe ser vacío, salvo que busque por apellido y nombre'
                                },
                                regexp: {
                                    regexp: /^[0-9]\d{6}|\d{7}/,  
                                    message: 'El documento ingresado no es válido '
                                }
                            }
                        },
                        '<%= txtApellido.UniqueID %>': {
                            // Disable validators
                            enabled: true,
                            validators: {
                                notEmpty: {
                                    message: 'El apellido no puede estar vacío, salvo que se busque por documento'
                                },
                                stringLength: {
                                    min: 2,
                                    max: 60,
                                    message: 'El apellido ingresado no es un apellido válido'
                                },
                                
                            }
                        },
                        '<%= txtDniMadre.UniqueID %>': {
                            enabled: false,
                            validators: {
                                notEmpty: {
                                    message: 'El número de documento no debe ser vacío'
                                },
                                regexp: {
                                    regexp: /^[0-9]\d{6}|d{7}/,   // /^(?!(000|666|9))\d{3}(?!00)\d{2}(?!0000)\d{4}$/,
                                    message: 'Debe ingresar sólo número '
                                }
                            }
                        },
                        '<%= txtApellidoMadre.UniqueID %>': {
                            validators: {
                                enabled: true,
                                notEmpty: {
                                    message: 'El apellido de la madre/tutor no puede estar vacío, salvo que busque por los campos del paciente.'
                                },
                                stringLength: {
                                    min: 2,
                                    max: 60,
                                    message: 'El apellido ingresado no es un apellido válido'
                                },
                            }
                        },
                    }
                })
                .on('keydown keyup change input', '[name="<%= txtDni.UniqueID %>"], [name="<%= txtApellido.UniqueID %>"], [name="<%= txtDniMadre.UniqueID %>"],[name="<%= txtApellidoMadre.UniqueID %>"],[name="<%=txtFecNacBusqueda.UniqueID %>"]', function (e) {

                    var apellido = $('#aspnetForm').find('[name="<%= txtApellido.UniqueID %>"]').val(),
                        dni = $('#aspnetForm').find('[name="<%= txtDni.UniqueID %>"]').val(),
                        dniMama = $('#aspnetForm').find('[name="<%= txtDniMadre.UniqueID %>"]').val(),
                        apellidoMadreTutor = $('#aspnetForm').find('[name="<%= txtApellidoMadre.UniqueID %>"]').val(),
                        fv = $('#aspnetForm').data('formValidation');
                    
                    switch ($(this).attr('name')) {
                        // User is focusing the ssn field
                        case '<%= txtDni.UniqueID %>':

                            fv.enableFieldValidators('<%= txtApellido.UniqueID %>', dni === '').revalidateField('<%= txtApellido.UniqueID %>');
                            
                            if (dni && fv.getOptions('<%= txtDni.UniqueID %>', null, 'enabled') === false) {
                                fv.enableFieldValidators('<%= txtDni.UniqueID %>', true).revalidateField('<%= txtDni.UniqueID %>');
                            } else if (dni === '' && apellido !== '') {
                                fv.enableFieldValidators('<%= txtDni.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                            } 
                            
                            //Deshabilito busqueda por tutor
                             fv.enableFieldValidators('<%= txtApellidoMadre.UniqueID %>', false).revalidateField('<%= txtApellidoMadre.UniqueID %>');
                             fv.enableFieldValidators('<%= txtDniMadre.UniqueID %>', false).revalidateField('<%= txtDniMadre.UniqueID %>');
                        break;

                            // El usuario esta haciendo foco en apellido
                    case '<%= txtApellido.UniqueID %>':

                            if (apellido === '') {
                                fv.enableFieldValidators('<%= txtDni.UniqueID %>', true).revalidateField('<%= txtDni.UniqueID %>');
                            } else if (dni === '') {
                                fv.enableFieldValidators('<%= txtDni.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                            }
                        //Deshabilito busqueda por tutor
                             fv.enableFieldValidators('<%= txtApellidoMadre.UniqueID %>', false).revalidateField('<%= txtApellidoMadre.UniqueID %>');
                             fv.enableFieldValidators('<%= txtDniMadre.UniqueID %>', false).revalidateField('<%= txtDniMadre.UniqueID %>');

                        if (apellido && dni === '' && fv.getOptions('<%= txtApellido.UniqueID %>', null, 'enabled') === false) {
                            fv.enableFieldValidators('<%= txtApellido.UniqueID %>', true).revalidateField('<%= txtApellido.UniqueID %>');
                        }
                        break;

                        case '<%=txtFecNacBusqueda.UniqueID %>':
                            if (apellido !== '')
                            {
                                fv.enableFieldValidators('<%= txtApellido.UniqueID %>', true).revalidateField('<%= txtApellido.UniqueID %>');
                                fv.enableFieldValidators('<%= txtDni.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                                fv.enableFieldValidators('<%= txtApellidoMadre.UniqueID %>', false).revalidateField('<%= txtApellidoMadre.UniqueID %>');
                            }
                            break;

                    case '<%= txtDniMadre.UniqueID %>':

                            if (dniMama !== '') {
                                fv.enableFieldValidators('<%= txtDniMadre.UniqueID %>', true).revalidateField('<%= txtDniMadre.UniqueID %>');
                                fv.enableFieldValidators('<%= txtDni.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                                fv.enableFieldValidators('<%= txtApellido.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                            }
                        fv.enableFieldValidators('<%= txtApellidoMadre.UniqueID %>', false).revalidateField('<%= txtApellidoMadre.UniqueID %>');
                        break;

                        case '<%= txtApellidoMadre.UniqueID %>':
                      
                        if (apellidoMadreTutor !== '') {
                            fv.enableFieldValidators('<%= txtApellidoMadre.UniqueID %>', true).revalidateField('<%= txtApellidoMadre.UniqueID %>');
                            fv.enableFieldValidators('<%= txtDniMadre.UniqueID %>', false).revalidateField('<%= txtDniMadre.UniqueID %>');
                            fv.enableFieldValidators('<%= txtDni.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                            fv.enableFieldValidators('<%= txtApellido.UniqueID %>', false).revalidateField('<%= txtDni.UniqueID %>');
                        } else if (apellidoMadreTutor === '')
                        {
                            fv.enableFieldValidators('<%= txtApellidoMadre.UniqueID %>', false).revalidateField('<%= txtApellidoMadre.UniqueID %>');

                            if (dni !== '') { fv.enableFieldValidators('<%= txtDni.UniqueID %>', true).revalidateField('<%= txtDni.UniqueID %>'); }
                            if (apellido !== '') { fv.enableFieldValidators('<%= txtApellido.UniqueID %>', true).revalidateField('<%= txtApellido.UniqueID %>'); }
                            if (dniMama !== '') { fv.enableFieldValidators('<%= txtDniMadre.UniqueID %>', true).revalidateField('<%= txtDniMadre.UniqueID %>'); }

                            if (dni ==='' && apellido==='' && dniMama === '')
                            {
                            fv.enableFieldValidators('<%= txtDniMadre.UniqueID %>', true).revalidateField('<%= txtDniMadre.UniqueID %>');
                            fv.enableFieldValidators('<%= txtDni.UniqueID %>', true).revalidateField('<%= txtDni.UniqueID %>');
                            fv.enableFieldValidators('<%= txtApellido.UniqueID %>', true).revalidateField('<%= txtApellido.UniqueID %>');
                            }

                        };
                        
                            break;

                        default:
                            break;
                    }
                });
        });


    </script>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Botones" runat="server">
</asp:Content>
