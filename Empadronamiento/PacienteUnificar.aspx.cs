using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using SubSonic;
using System.Collections.Generic;
using DalSic;
using System.Drawing;


namespace Empadronamiento
{
    public partial class PacienteUnificar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            
                MostrarPaciente();

        }


        private void MostrarPaciente()
        {
            ///muestra solo el primer paciente con ese numero de documento.
            int i = 0;

            if (!String.IsNullOrEmpty(txtDni.Text))
            {

                try
                {
                    int dni = Int32.Parse(txtDni.Text);
                    /////////////////////////////////////////////////////
                    ///modificacacion para dar prioridad al paciente validado
                    /////////////////////////////////////////////////////
                    SysPacienteCollection lst = new SubSonic.Select()
                    .From(Schemas.SysPaciente)
                    .Where(SysPaciente.Columns.NumeroDocumento).IsEqualTo(dni)
                    .And(SysPaciente.Columns.IdEstado).IsEqualTo(3)///primero busca el paciente validado
                    .And(SysPaciente.Columns.Activo).IsEqualTo(1)
                    .ExecuteAsCollection<SysPacienteCollection>();

                    foreach (SysPaciente oPaciente in lst)
                    {
                        if (i == 0)
                        {
                            lblEstado.Text = "VALIDADO";
                            lblEstado.ForeColor = Color.Red;
                            lblidPaciente.Text = oPaciente.IdPaciente.ToString();
                            lblDU.Text = oPaciente.NumeroDocumento.ToString();
                            lblApellido.Text = oPaciente.Apellido;
                            lblNombre.Text = oPaciente.Nombre;
                            lblFechaNacimiento.Text = oPaciente.FechaNacimiento.ToShortDateString();
                            switch (oPaciente.IdSexo)
                            {
                                case 1: lblSexo.Text = "Sin definir"; break;
                                case 2: lblSexo.Text = "Femenino"; break;
                                case 3: lblSexo.Text = "Masculino"; break;
                            }
                            pnlPaciente.Visible = true;
                            pnlSinDatosPaciente.Visible = false;
                        }
                        i += 1;
                    }
                    /////////////////////////////////////////////////////
                    // si no encontró un paciente validado busca a un identificado
                    /////////////////////////////////////////////////////
                    //  if (lst.Count == 0)
                    if (i == 0)
                    {
                        SysPacienteCollection lst2 = new SubSonic.Select()
                            .From(Schemas.SysPaciente)
                            .Where(SysPaciente.Columns.NumeroDocumento).IsEqualTo(dni)
                            .And(SysPaciente.Columns.IdEstado).IsEqualTo(1)/// busca el paciente IDENTIFICADO
                        .And(SysPaciente.Columns.Activo).IsEqualTo(1)
                            .ExecuteAsCollection<SysPacienteCollection>();

                        foreach (SysPaciente oPaciente in lst2)
                        {
                            if (i == 0)
                            {
                                lblEstado.Text = "IDENTIFICADO";
                                lblEstado.ForeColor = Color.Green;
                                lblidPaciente.Text = oPaciente.IdPaciente.ToString();
                                lblDU.Text = oPaciente.NumeroDocumento.ToString();
                                lblApellido.Text = oPaciente.Apellido;
                                lblNombre.Text = oPaciente.Nombre;
                                lblFechaNacimiento.Text = oPaciente.FechaNacimiento.ToShortDateString();
                                switch (oPaciente.IdSexo)
                                {
                                    case 1: lblSexo.Text = "Sin definir"; break;
                                    case 2: lblSexo.Text = "Femenino"; break;
                                    case 3: lblSexo.Text = "Masculino"; break;
                                }
                                pnlPaciente.Visible = true;
                                pnlSinDatosPaciente.Visible = false;
                            }
                            i += 1;
                        }
                    }

                    if (i == 0)
                    {
                        pnlPaciente.Visible = false;
                        pnlSinDatosPaciente.Visible = true;
                    }
                }
                catch (Exception e)
                {
                    string popupScript = "<script language='JavaScript'> alert('Los datos ingresados no son válidos')</script>";
                    Page.RegisterClientScriptBlock("PopupScript", popupScript);
                }
            }
           }


        protected void btnBuscar0_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (String.IsNullOrEmpty(txtDni.Text))
                {
                    this.errorDNI.Value = "1";
                }
                else
                {
                    CargarGrilla();
                }

            }
        }

        

        private void CargarGrilla()
        {
            try
            {
                gvLista.DataSource = LeerDatos();
                gvLista.DataBind();
            }
            catch (Exception ex)
            {
                pnlSinDatos.Visible = true;
                pnlRegistros.Visible = false;

            }

        }

        private object LeerDatos()
        {
            //Condiciona a que el paciente buscado y el que se va a unificar no sean el mismo!
            string str_condicion = " WHERE P.activo=1 and P.idPaciente not in (" + lblidPaciente.Text + ")";

            switch (ddlFiltro.SelectedValue)
            {
                case "1": str_condicion += " and P.numeroDocumento=" + txtFiltro.Text + " and P.idEstado<>2"; break; /// numero de documento
                case "2": str_condicion += " and P.apellido like '%" + txtFiltro.Text + "%'"; break;///solo por apellido
                case "3": str_condicion += " and P.nombre like '%" + txtFiltro.Text + "%'"; break;/// solo por nombre
                case "4": /// combinacion apellido+nombre
                    {
                        try
                        {
                            int signomas = txtFiltro.Text.IndexOf("+");
                            int hfin = txtFiltro.Text.Length - signomas - 1;
                            string apel = txtFiltro.Text.Substring(0, signomas);
                            string nomb = txtFiltro.Text.Substring(signomas + 1, hfin);
                            str_condicion += " and P.apellido like '%" + apel + "%' and P.nombre like '%" + nomb + "%'";
                        }
                        catch (Exception ex)
                        {
                            string popupScript = "<script language='JavaScript'> alert('error en el filtro')</script>";
                            Page.RegisterClientScriptBlock("PopupScript", popupScript);
                        }
                    }
                    break;
                case "5": str_condicion += " and P.numeroDocumento =" + txtFiltro.Text + " and P.idEstado=2"; break;
            }

            DataTable Ds = DalSic.SPs.GetPacientes(str_condicion).GetDataSet().Tables[0];

            if (Ds.Rows.Count == 0)
            {
                pnlSinDatos.Visible = true;
                pnlRegistros.Visible = false;
            }
            else
            {
                pnlRegistros.Visible = true;
                pnlSinDatos.Visible = false;
            }
            return Ds;

        }



        protected void btnMover_Click(object sender, EventArgs e)
        {

            if (haySeleccion())
            {
                MoverRegistros(false);

                string popupScript = "<script language='JavaScript'> alert('Los datos se reasignaron al paciente principal')</script>";
                Page.RegisterClientScriptBlock("PopupScript", popupScript);
                CargarGrilla();
            }
            else
            {
                string popupImprimir = "<script language='JavaScript'> alert('Debe seleccionar al menos un paciente para realizar la modificación.') </script>";
                Page.RegisterStartupScript("PopupScriptImprimir", popupImprimir);
            }


        }

        private bool haySeleccion()
        {
            bool hay = false;
            foreach (GridViewRow row in gvLista.Rows)
            {
                CheckBox a = ((CheckBox)(row.Cells[0].FindControl("CheckBox1")));
                if (a.Checked == true)
                {
                    hay = true; break;
                }
            }
            return hay;
        }


        private void MoverRegistros(bool eliminarpacientitos)
        {
            if (lblidPaciente.Text != "")
            {
                foreach (GridViewRow row in gvLista.Rows)
                {
                    CheckBox a = ((CheckBox)(row.Cells[0].FindControl("CheckBox1")));
                    if (a.Checked == true)
                    {
                        Actualizar(gvLista.DataKeys[row.RowIndex].Value.ToString(), eliminarpacientitos);
                    }
                }
            }
        }

        private void Actualizar(string idPaciente_Old, bool eliminarpacientitos)
        {
            try
            {
                ///llamar a store con los parametros para actualizar
                ///
                /// 
                int idPacientePrincipal = int.Parse(lblidPaciente.Text);
                int idPacienteSecundario = int.Parse(idPaciente_Old);
                DataSet Ds = new DataSet();
                Ds = SPs.SysUnificaPaciente(idPacientePrincipal, idPacienteSecundario, eliminarpacientitos).GetDataSet(); ///poner [Sys_UnificaPaciente] solo       

            }
            catch (Exception ex)
            {
                string popupScript = "<script language='JavaScript'> alert('No se ha podido reasignar. Verifique con el Administrador del Sistema')</script>";
                Page.RegisterClientScriptBlock("PopupScript", popupScript);
            }
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            txtDni.Text = "";
            pnlPaciente.Visible = false;
            pnlSinDatosPaciente.Visible = false;
            lblidPaciente.Text = "";
        }

        protected void btnBorrar0_Click(object sender, EventArgs e)
        {
            txtFiltro.Text = "";
            pnlRegistros.Visible = false;
            pnlSinDatos.Visible = false;
            ddlFiltro.SelectedValue = "1";
        }

        protected void btnMoverYEliminar0_Click(object sender, EventArgs e)
        {
            if (haySeleccion())
            {
                MoverRegistros(true);

                string popupScript = "<script language='JavaScript'> alert('Los datos se reasignaron al paciente principal')</script>";
                Page.RegisterClientScriptBlock("PopupScript", popupScript);
                CargarGrilla();
            }
            else
            {
                string popupImprimir = "<script language='JavaScript'> alert('Debe seleccionar al menos un paciente para asignarle paciente.') </script>";
                Page.RegisterStartupScript("PopupScriptImprimir", popupImprimir);
            }
        }

        protected void cvFiltro_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;
            switch (ddlFiltro.SelectedValue)
            {
                case "1":
                    try
                    {
                        int doc = int.Parse(txtFiltro.Text.Trim());
                    }
                    catch (Exception ex)
                    {
                        // cvFiltro.ErrorMessage = "error" + ex.Message;
                        args.IsValid = false; return;
                    }
                    break;
                case "4": /// combinacion apellido+nombre
                    {
                        try
                        {
                            int signomas = txtFiltro.Text.IndexOf("+");
                            if (signomas == -1)
                            {
                                //       cvFiltro.ErrorMessage = "escriba el apellido y el nombre separado por el signo '+'";
                                args.IsValid = false; return;
                            }
                        }
                        catch (Exception ex)
                        {
                            //  cvFiltro.ErrorMessage = "error" + ex.Message;
                            args.IsValid = false; return;
                        }
                    }
                    break;
                case "5":
                    try
                    {
                        int doc = int.Parse(txtFiltro.Text.Trim());
                    }
                    catch (Exception ex)
                    {
                        //  cvFiltro.ErrorMessage = "error" + ex.Message;
                        args.IsValid = false; return;
                    }
                    break;
            }

        }


    }

}
