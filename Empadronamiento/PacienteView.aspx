<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PacienteView.aspx.cs" MasterPageFile="~/mPaciente.Master"
    Inherits="Empadronamiento.PacienteView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Cuerpo" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Datos Principales</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtEstado" runat="server"><b>Estado:</b></asp:Label>
                                <asp:Label ID="lblEstado" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtMotiviNI" runat="server"><b>MotivoNi:</b></asp:Label>
                                <asp:Label ID="lblMotivoNI" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="lblDocumentoDNI" runat="server"><b>DU:</b></asp:Label>
                                <asp:Label ID="lblNumeroDoc" runat="server"></asp:Label>
                                <asp:Label ID="lblDocumentoExt" runat="server" Visible="false"><b>Documento Extranjero:</b></asp:Label>
                                <asp:Label ID="lblExtranjero" runat="server" Visible="false"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtApellido" runat="server"><b>Apellido:</b></asp:Label>
                                <asp:Label ID="lblApellido" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtNombre" runat="server"><b>Nombre(s):</b></asp:Label>
                                <asp:Label ID="lblNombre" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtFechaNacimiento" runat="server"><b>Fecha de nacimiento:</b></asp:Label>
                                <asp:Label ID="lblFechaNac" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtSexo" runat="server"><b>Sexo:</b></asp:Label>
                                <asp:Label ID="lblSexo" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtNacionalidad" runat="server"><b>Nacionalidad:</b></asp:Label>
                                <asp:Label ID="lblNacionalidad" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtLugarNac" runat="server"><b>Lugar Nacimiento:</b></asp:Label>
                                <asp:Label ID="lblLugarNacimiento" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtTFijo" runat="server"> <b>Teléfono Fijo:</b></asp:Label>
                                <asp:Label ID="lblTFijo" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtTCelular" runat="server"> <b>Teléfono Celular:</b></asp:Label>
                                <asp:Label ID="lblTCelular" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtEmail" runat="server"> <b>Email:</b></asp:Label>
                                <asp:Label ID="lblEmail" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtContacto" runat="server"> <b>Contacto:</b></asp:Label>
                                <asp:Label ID="lblContacto" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtOSocial" runat="server"><b>Obra Social:</b></asp:Label>
                                <asp:Label ID="lblOSocial" runat="server" ToolTip="Obra Social al Momento del Alta del Paciente"></asp:Label>
                                <asp:ImageButton ID="imgSumar" Visible="false" runat="server" Height="46px" ImageUrl="~/Images/sumar.png" OnClick="imgSumar_Click" ToolTip="Constancia Programa Sumar" Width="48px" />
                            </div>
                        </div>
                        <div class="row" id="defuncion">
                            <div class="col-sm-12">
                                <asp:Label ID="txtDefuncion" runat="server"><b>Fecha defunción:</b></asp:Label>
                                <asp:Label ID="lblDefuncion" runat="server"></asp:Label>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        <h3 class="panel-title">Datos Domicilio</h3>
                    </div>
                    <div class="panel-body">

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtCalle" runat="server"><b>Calle:</b></asp:Label>
                                <asp:Label ID="lblCalle" runat="server"></asp:Label>
                                <asp:Label ID="txtNumero" runat="server"><b>Altura:</b></asp:Label>
                                <asp:Label ID="lblNum" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtBarrio" runat="server"><b>Barrio:</b></asp:Label>
                                <asp:Label ID="lblBarrio" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtOBarrio" runat="server"><b>Otro Barrio:</b></asp:Label>
                                <asp:Label ID="lblOBarrio" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtManzana" runat="server"><b>Manzana:</b></asp:Label>
                                <asp:Label ID="lblManzana" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtDepartamento" runat="server"><b>Departamento:</b></asp:Label>
                                <asp:Label ID="lblDepartamento" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtPiso" runat="server"><b>Piso:</b></asp:Label>
                                <asp:Label ID="lblPiso" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtEdificio" runat="server"><b>Edificio:</b></asp:Label>
                                <asp:Label ID="lblEdificio" runat="server"></asp:Label>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtParcela" runat="server"><b>Parcela:</b></asp:Label>
                                <asp:Label ID="lblParcela" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtLote" runat="server"><b>Lote:</b></asp:Label>
                                <asp:Label ID="lblLote" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtCampo" runat="server"><b>Campo:</b></asp:Label>
                                <asp:Label ID="lblCampo" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtCamino" runat="server"><b>Camino:</b></asp:Label>
                                <asp:Label ID="lblCamino" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtLatitud" runat="server"><b>Latitud:</b></asp:Label>
                                <asp:Label ID="lblLatitud" runat="server"></asp:Label>
                                <asp:Label ID="txtLongitud" runat="server"><b>Longitud:</b></asp:Label>
                                <asp:Label ID="lblLongitud" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtUrbano" runat="server"><b>Tipo:</b></asp:Label>
                                <asp:Label ID="lblUrbano" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtReferencia" runat="server"><b>Referencia:</b></asp:Label>
                                <asp:Label ID="lblReferencia" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtCPostal" runat="server"><b>Código postal:</b></asp:Label>
                                <asp:Label ID="lblCPostal" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtLocalidad" runat="server"><b>Localidad:</b></asp:Label>
                                <asp:Label ID="lblLocalidad" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtDptoDomicilio" runat="server"><b>Departamento:</b></asp:Label>
                                <asp:Label ID="lblDptoDomicilio" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="txtProvincia" runat="server"><b>Provincia:</b></asp:Label>
                                <asp:Label ID="lblProvincia" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        <h3 class="panel-title">Datos del progenitor</h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:Label ID="txtParentesco" runat="server"><b>Parentesco:</b></asp:Label>
                                    <asp:Label ID="lblParentesco" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtTipoDocP" runat="server"><b>DU:</b></asp:Label>
                                    <asp:Label ID="lblDocP" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtApellidoP" runat="server"><b>Apellido:</b></asp:Label>
                                    <asp:Label ID="lblApellidoP" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtNombreP" runat="server"><b>Nombre:</b></asp:Label>
                                    <asp:Label ID="lblNombreP" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtFechaNacP" runat="server"><b>Fecha Nacimiento:</b></asp:Label>
                                    <asp:Label ID="lblFecNacP" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="Label1" runat="server"><b>Nacionalidad:</b></asp:Label>
                                    <asp:Label ID="lblNacionalidadP" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtNacimientoP" runat="server"><b>Lugar de nacimiento:</b></asp:Label>
                                    <asp:Label ID="lblLNacimientoP" runat="server"></asp:Label>
                                </div>


                            </div>
                        </div>

                        <div class="col-md-6">

                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:Label ID="txtParentesco0" runat="server"><b>Parentesco:</b></asp:Label>
                                    <asp:Label ID="lblParentesco0" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtDocP0" runat="server"><b>DU:</b></asp:Label>
                                    <asp:Label ID="lblDocP0" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtApellidoP0" runat="server"><b>Apellido:</b></asp:Label>
                                    <asp:Label ID="lblApellidoP0" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtNombreP0" runat="server"><b>Nombre:</b></asp:Label>
                                    <asp:Label ID="lblNombreP0" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtFecNacP0" runat="server"><b>Fecha Nacimiento:</b></asp:Label>
                                    <asp:Label ID="lblFecNacP0" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtNacionalidadP0" runat="server"><b>Nacionalidad:</b></asp:Label>
                                    <asp:Label ID="lblNacionalidadP0" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-12">
                                    <asp:Label ID="txtLNacimientoP0" runat="server"><b>Lugar de nacimiento:</b></asp:Label>
                                    <asp:Label ID="lblLNacimientoP0" CssClass="negrita" runat="server"></asp:Label>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="col-md-4">
                    <asp:Button ID="btnEditar" runat="server" CssClass="btn btn-primary form-control" Text="Editar Paciente" ToolTip="Modificar los Datos del Paciente"
                        OnClick="btnEditar_Click" />
                </div>

                <div class="col-md-4">
                    <asp:Button ID="btnVolver" runat="server" CssClass="form-control" Text="Volver" OnClientClick="JavaScript: window.history.back(1); return false;" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Botones" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {
            var fallecido = $('#<%= lblDefuncion.ClientID %>').text();
            if (fallecido) {
                $("#defuncion").show();
            }
            else {
                $("#defuncion").hide();
            }

        });

    </script>

</asp:Content>




