<%@ Page Title="" Language="C#" MasterPageFile="~/mPaciente.Master" AutoEventWireup="true" CodeBehind="Validar.aspx.cs" Inherits="Empadronamiento.Validar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Superior" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Cuerpo" runat="server">

        <div class="container">
            <div class="row">
                <div>

                    <div class="col-sm-4">                        
                        <asp:TextBox ID="txtPrueba1" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <%--<button type="submit" class="btn btn-info" name="signup" value="Sign up">Submit</button>--%>
                    <asp:Button ID="btnGuardar" runat="server" class="btn btn-info" OnClick="btnGuardar_Click" Text="Button" />
                </div>
            </div>
        </div>

        <%--ctl00$Cuerpo$txtPrueba1--%>
    <script type="text/javascript">
        var pepe = $("#<%= txtPrueba1.ClientID%>");
        var capo = "<%= txtPrueba1.ClientID %>";
        alert(capo);
        $(document).ready(function () {
            $('#aspnetForm').formValidation({
                message: 'This value is not valid',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    '<%= txtPrueba1.UniqueID %>': {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'El nombre es requerido'
                            }
                        }
                    }
                }
            });
        });
</script>
</asp:Content>

<%--<asp:Content ID="Content5" ContentPlaceHolderID="Cuerpo2" runat="server">
    <form id="form2"  class="form-horizontal">
        <div class="container">
            <div class="row">
                <div>

                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="txtPrueba" placeholder="First name" />
                        <%--<asp:TextBox ID="txtPrueba" CssClass="form-control" runat="server"></asp:TextBox>--%>
                    <%--</div>
                    <button type="submit" class="btn btn-info" name="signup" value="Sign up">Submit</button>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#form2').formValidation({
                message: 'This value is not valid',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtPrueba: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'The first name is required'
                            }
                        }
                    }
                }
            });
        });
</script>
</asp:Content>--%>

<asp:Content ID="Content4" ContentPlaceHolderID="Botones" runat="server">
</asp:Content>
