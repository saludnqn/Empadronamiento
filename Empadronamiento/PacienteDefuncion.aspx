<%@ Page Language="C#" MasterPageFile="~/mPaciente.Master" AutoEventWireup="true" CodeBehind="PacienteDefuncion.aspx.cs" Inherits="Empadronamiento.PacienteDefuncion" Theme="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-horizontal .has-feedback .form-control-feedback {
            top: 0;
            right: -11px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Cuerpo" runat="server">
    <asp:HiddenField ID="hfMedico" runat="server" />
    <asp:HiddenField ID="hfupdate" runat="server" />
    <%--<asp:HiddenField ID="hfGuardado" Value="si" runat="server" />--%>

    <asp:Panel ID="error" runat="server" Visible="false">
        <div class="container">
            <div class="alert alert-danger alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong>Error!</strong> Se ha producido un error inesperado, deberá comunicarse con informática al <strong>0299-4495590/591</strong>.
            </div>
        </div>
    </asp:Panel>


    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Registro de defunción</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-5">
                        <div class="well">
                            <div class="row">
                                <asp:Label ID="lblDocumento" runat="server"><b>Documento:</b></asp:Label>
                                <asp:Label ID="txtDocumento" runat="server"></asp:Label>
                            </div>
                            <div class="row">
                                <asp:Label ID="lblApellidoNombres" runat="server"><b>Apellido y Nombres:</b></asp:Label>
                                <asp:Label ID="txtApellidoNombres" runat="server"></asp:Label>
                            </div>
                            <div class="row">
                                <asp:Label ID="lblEdad" runat="server"><b>Edad:</b></asp:Label>
                                <asp:Label ID="txtEdad" runat="server"></asp:Label>
                            </div>
                            <div class="row">
                                <asp:Label ID="lblSexo" runat="server"><b>Sexo:</b></asp:Label>
                                <asp:Label ID="txtSexo" runat="server"></asp:Label>
                            </div>
                            <div class="row">
                                <asp:Label ID="lblOS" runat="server"><b>Obra Social:</b></asp:Label>
                                <asp:Label ID="txtOS" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <h3 class="panel-title">Datos de la defunción</h3>
                            </div>
                            <div id="loader"><i class="fa fa-4x fa-cog fa-spin"></i></div>
                            <div id="panelDefuncion" class="panel-body" hidden>
                                <div class="row">
                                    <div class="form-group">
                                        <asp:Label ID="lblFechaDefuncion" runat="server" Text="Fecha y hora: " class="col-sm-5 control-label"></asp:Label>
                                        <div class="col-sm-4 date">
                                            <div class="input-group input-append date" id="datePicker">
                                                <asp:TextBox runat="server" ID="txtFechaDefuncion" class="form-control">                    
                                                </asp:TextBox>
                                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                            </div>
                                        </div>
                                        <div class="col-sm-3 date">
                                            <div class="input-group clockpicker">
                                                <asp:TextBox runat="server" ID="txtHoraDefuncion" class="form-control"></asp:TextBox>
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <asp:Label ID="lblMedico" runat="server" Text="Médico que informa: " class="col-sm-5 control-label"></asp:Label>
                                        <div class="col-sm-7">
                                            <asp:DropDownList ID="ddlMedico" runat="server" class="medicos form-control" DataValueField="idProfesional" DataTextField="nombre">
                                            </asp:DropDownList>
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <asp:Label ID="lblCausaMuerte" runat="server" Text="Causa de muerte: " class="col-sm-5 control-label"></asp:Label>
                                        <div class="col-sm-7">
                                            <asp:TextBox ID="txtCausaMuerte" runat="server" class="form-control" TextMode="MultiLine" Width="100%"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <asp:Label ID="lblPersonalIngresoMorge" runat="server" Text="Ingresado a morgue por: " class="col-sm-5 control-label"></asp:Label>
                                        <div class="col-sm-7">
                                            <asp:TextBox runat="server" TextMode="MultiLine" Width="100%" ID="txtPersonalIngresaMorgue" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <asp:Label ID="lblEmpresaRetira" runat="server" Text="Empresa que lo retira: " class="col-sm-5 control-label"></asp:Label>
                                        <div class="col-sm-7">
                                            <asp:TextBox runat="server" TextMode="MultiLine" Width="100%" ID="txtEmpresaQueRetira" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <asp:Label ID="lblObservaciones" runat="server" Text="Observaciones: " class="col-sm-5 control-label"></asp:Label>
                                        <div class="col-sm-7">
                                            <asp:TextBox runat="server" TextMode="MultiLine" Width="100%" ID="txtObservaciones" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" class="btn btn-primary btn-lg btn-block" Text="Guardar" />
                                    </div>

                                    <div class="col-sm-3">
                                        <asp:LinkButton ID="btnVolver" runat="server" class="btn btn-default btn_lg btn-block" Text="Cancelar" OnClick="btnVolver_Click" OnClientClick="return confirmacionCancel();"></asp:LinkButton>
                                    </div>

                                    <div class="col-sm-4" align="right">
                                        <asp:LinkButton ID="btnAnularDefuncion" runat="server" class="btn btn-danger btn_lg btn-block" OnClick="btnAnularDefuncion_Click" Visible="false" Text="Anular defunción" OnClientClick="return confirmacionAnular();"></asp:LinkButton>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>

</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="Botones" runat="server">


    <script type="text/javascript">


        //Verifico si los datos han sido guardados correctamente
        <%--if($("#<%=hfGuardado.ClientID%>").val()=="si")
        {
            setTimeout(function () {
            $(".alert").fadeTo(1000, 0).slideUp(1000, function () {
                $(this).remove();
        });
        }, 3000)

        };--%>



        function confirmacionAnular() {

            if (confirm("¿Está seguro que desea anular esta defunción? el registro será eliminado."))
                return true;
            else
                return false;
        }

        function confirmacionCancel() {
            if (confirm("¿Está seguro que desea cancelar la operación? los datos no será guardados."))
                return true;
            else
                return false;
        }


        $('#datePicker')
        .datepicker({
            format: 'dd/mm/yyyy',
            language: 'es',
            autoclose: 1,
        })
        .on('changeDate', function (e) {

            $('#aspnetForm').formValidation('revalidateField', '<%= txtFechaDefuncion.UniqueID %>')
        });


        $('.clockpicker').clockpicker({
            placement: 'bottom', // clock popover placement
            align: 'left',       // popover arrow align
            donetext: 'Guardar',     // done button text
            autoclose: true,    // auto close when minute is selected
            vibrate: true        // vibrate the device when dragging clock hand

        }).on('change', function (e) {

            $('#aspnetForm').formValidation('revalidateField', '<%= txtHoraDefuncion.UniqueID %>')
        });


        $(function () {
            var ddlMedico;
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("~/Paciente/PacienteDefuncion.aspx/GetProfesionales") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $("#loader").show();
                },
                success: function (r) {
                    $("#loader").hide();
                    $("#panelDefuncion").show();
                    ddlMedico = $("[id*=ddlMedico]");
                    ddlMedico.empty().append('<option id=ddlMedico value="0"></option>')

                    $.each(r.d, function () {
                        ddlMedico.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    if ($('#<%= hfupdate.ClientID %>').val() == "si") {
                        //Dejo seleccionado el que estaba por base de datos
                        $("#<%=ddlMedico.ClientID%>")[0].value = $("#<%=hfMedico.ClientID%>").val();
                    }

                    $("[id*=ddlMedico]").select2({
                        //maximumSelectionLength: 4
                        //data: ddlMedico
                    })
                    .change(function (e) {
                        $('#aspnetForm').formValidation('revalidateField', 'ddlMedico');
                        //Actualizando el valor del medico seleccionado
                        $("#<%=hfMedico.ClientID %>").val(($("#<%=ddlMedico.ClientID %>").val()));

                    }).end()
                }
            });

            $('#aspnetForm').formValidation({
                framework: 'bootstrap',
                message: 'El valor no es válido!',
                icon: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh fa-spin'
                },
                fields: {
                    '<%= txtFechaDefuncion.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'La fecha de defunción es requerida'
                            }
                        },
                        date: {
                            format: 'DD/MM/YYYY',
                            message: 'El formato de fecha no es válido'
                        }
                    },
                    '<%= txtHoraDefuncion.UniqueID %>': {
                        row: '.col-sm-3',
                        validators: {
                            notEmpty: {
                                message: 'La hora de defunción es requerida'
                            }
                        }
                    },
                    '<%= ddlMedico.UniqueID %>': {
                        row: '.col-sm-7',
                        validators: {
                            callback: {
                                message: 'Debe seleccionar un médico',
                                callback: function (value, validator, $field) {
                                    //Validamos que no haya seleccionado un vacio value=0
                                    var options = validator.getFieldElements('<%= ddlMedico.UniqueID %>').val();
                                    return (options != 0);
                                }
                            }
                        }
                    }
                },

            });


        });


    </script>




</asp:Content>

