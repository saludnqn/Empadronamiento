<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PacienteUnificarHelp.aspx.cs" Inherits="Empadronamiento.PacienteUnificarHelp" MasterPageFile="~/mPaciente.Master" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>

<asp:Content ID="content3" ContentPlaceHolderID="Cuerpo" runat="server">

    <div class="container">
        <div class="row form-group">
            <div class="col-xs-12">
                <ul class="nav nav-pills nav-justified thumbnail setup-panel">
                    <li class="active"><a href="#step-1">
                        <h4 class="list-group-item-heading">Paso 1</h4>
                        <p class="list-group-item-text"></p>
                    </a></li>
                    <li class="disabled"><a href="#step-2">
                        <h4 class="list-group-item-heading">Paso 2</h4>
                        <p class="list-group-item-text"></p>
                    </a></li>
                    <li class="disabled"><a href="#step-3">
                        <h4 class="list-group-item-heading">Paso 3</h4>
                        <p class="list-group-item-text"></p>
                    </a></li>
                </ul>
            </div>
        </div>
        <div class="row setup-content" id="step-1">
            <div class="col-xs-12">
                <div class="col-md-12 well text-center">
                    <h4><b>Identificación del Paciente Principal</b></h4>
                    <p class="text-justify">En la sección de la izquierda deberá buscar el paciente con el número de documento único (DU) al que se le desea asignar los registros hospitalarios que fueron asociados a otro paciente por error.</p>
                    <button id="activate-step-2" class="btn btn-primary btn-lg">Activar paso 2</button>
                </div>
            </div>
        </div>
        <div class="row setup-content" id="step-2">
            <div class="col-xs-12">
                <div class="col-md-12 well text-center">
                    <h4><b>Identificación de Registros a asignar al Paciente Principal</b></h4>
                    <p class="text-justify"> En la sección de la derecha deberá buscar el paciente (de cualquiera de las siguientes maneras: DU; Nombre; Apellido; Apellodo+Nombre) que posee los registros que serán asignados al paciente principal (que se ha identificado en el paso 1) </p>
                    <button id="activate-step-3" class="btn btn-primary btn-lg">Activar paso 3</button>
                </div>
            </div>
        </div>
        <div class="row setup-content" id="step-3">
            <div class="col-xs-12">
                <div class="col-md-12 well">
                    <h4 class="text-center"><b>Unificación de registros médicos</b></h4>
                    <p class="text-justify"> Finalmente deberá seleccionar <b>MARCANDO el campo</b>, del paciente que desea unificar al paciente principal. (ES IMPORTANTE ANTES DE REALIZAR UNA UNIFICACIÓN VERIFICAR QUE LOS DATOS CORRESPONDAN CON EL PRIMERO). </p>
                    <p class="text-justify"> Existen 2 posibilidades:
                        <ul>
                            <li>
                                <p class="text-danger"><b>Asignar registros y eliminar:</b> Esta opción asocia todos los registros del paciente seleccionado al paciente principal y luego lo elimina del sistema.</p>
                                
                            </li>
                            <li>
                                <p class="text-warning"><b>Asignar registros:</b> Esta opción asocia todos los registros del paciente seleccionado al paciente principal pero <b>NO</b> elimina el paciente del sistema.</p>
                            </li>
                        </ul>

                    </p>

                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {

            var navListItems = $('ul.setup-panel li a'),
                allWells = $('.setup-content');

            allWells.hide();

            navListItems.click(function (e) {
                e.preventDefault();
                var $target = $($(this).attr('href')),
                    $item = $(this).closest('li');

                if (!$item.hasClass('disabled')) {
                    navListItems.closest('li').removeClass('active');
                    $item.addClass('active');
                    allWells.hide();
                    $target.show();
                }
            });

            $('ul.setup-panel li.active a').trigger('click');

            
            $('#activate-step-2').on('click', function (e) {
                $('ul.setup-panel li:eq(1)').removeClass('disabled');
                $('ul.setup-panel li a[href="#step-2"]').trigger('click');
                $(this).remove();
            })

            $('#activate-step-3').on('click', function (e) {
                $('ul.setup-panel li:eq(2)').removeClass('disabled');
                $('ul.setup-panel li a[href="#step-3"]').trigger('click');
                $(this).remove();
            })
        });

    </script>

</asp:Content>
