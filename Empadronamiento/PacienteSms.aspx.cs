using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SubSonic;
using DalSic;

namespace Empadronamiento
{
    public partial class PacienteSms : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);            
        }

        protected void Page_Load(object sender, EventArgs e)
        {         
            if (!IsPostBack)
            {
                lblCantidad.Text = "";
                lblMensaje.Text = "";
                txtDni.Focus();
                cargarCombo();
            }            
        }

        private void cargarCombo()
        {
            SubSonic.Select ef = new SubSonic.Select();
            ef.From(SysEfector.Schema);
            ef.Where(SysEfector.Columns.IdZona).IsEqualTo(9);
            ef.And(SysEfector.Columns.Complejidad).IsEqualTo(2);
            ef.OrderAsc("nombre");
            ddlEfector.DataSource = ef.ExecuteTypedList<SysEfector>();
            ddlEfector.DataBind();
            ddlEfector.Items.Insert(0, new ListItem("TODOS", "0"));
        }

        protected void btnBuscar_Click1(object sender, EventArgs e)
        {
            buscarDatos();
        }

        private void buscarDatos()
        {
            lblMensaje.Text = "";
            lblCantidad.Text = "";
            int efector;
            efector = Convert.ToInt32(ddlEfector.SelectedValue);
            int dni;
            Int32.TryParse(txtDni.Text, out dni);
            if (dni > 0)
            {
                if (txtDni.Text.Length > 5)
                {
                    dni = Convert.ToInt32(txtDni.Text);
                }
                else
                {
                    lblMensaje.CssClass = "txtrojo";
                    lblMensaje.Text = "No es un número válido";
                }
            }
            DateTime? finicio = null;
            DateTime? ffin = null;
            DateTime inicio;
            DateTime fin;
            if (DateTime.TryParse("01/05/2011", out inicio))
                finicio = inicio;
            if (DateTime.TryParse("01/01/2013", out fin))
                ffin = fin;
            //consulta especifica de clasificacion
            DataTable dc = SPs.RemGetClasificadosConsultas(efector, dni, finicio, ffin, 0, -1).GetDataSet().Tables[0];
            dc.DefaultView.Sort = "idEfector ASC";
            if (dc.Rows.Count > 0)
            {
                gvPacientesSms.DataSource = dc;
                gvPacientesSms.DataBind();
                lblCantidad.Text = "Registros existentes: " + dc.Rows.Count.ToString();
            }
            else lblCantidad.Text = "Sin registros de Clasificacíon";
            gvPacientesSms.DataBind();
        }

        protected void gvPacientesSms_PageIndexChangind(object sender, GridViewPageEventArgs e)
        {
            gvPacientesSms.PageIndex = e.NewPageIndex;
            buscarDatos();
        }
    }
}
