using System;
using DalSic;
using Salud.Security.SSO;

namespace DalSic.HistoriaClinica
{
    public partial class ConsultasHClinicas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                txtDni.Focus();
                if (!IsPostBack)
                {
                    txtDni.Focus();
                    CargarGrilla();
                }            
        }

        private void CargarGrilla()
        {            
            int dni = 0;
            Int32.TryParse(txtDni.Text, out dni);
            gvHClinicas.DataSource = SPs.SysGetHistoriasClinicas(dni).GetDataSet();
            gvHClinicas.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarGrilla();
            if (gvHClinicas.Rows.Count < 1)
            {
                lblMensaje.Text = "No se encontró al Paciente buscado";
            }
            else
            {
                lblMensaje.Text = "";
            }
        }

    }
}
