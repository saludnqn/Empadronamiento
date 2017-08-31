using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalSic;
using System.Data;
using System.Collections;
using System.IO;
using Salud.Security.SSO;

namespace DalSic.HistoriaClinica
{
    public partial class NroHistoriaClinicaxEfector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
                if (!IsPostBack)
                {
                    lblHc.Text = "";
                    txtDni.Focus();

                }            
        }

        private void CargarGrilla()
        {
            int dni = 0;
            Int32.TryParse(txtDni.Text, out dni);
            int hc = 0;
            Int32.TryParse(txtHC.Text, out hc);            
            gvHClinicas.DataSource = SPs.SysGetNroHClinicaxEfector(SSOHelper.CurrentIdentity.IdEfector, dni, hc, txtApellido.Text.Trim(), txtNombre.Text.Trim()).GetDataSet();
            gvHClinicas.DataBind();
            //sugiero el proximo Nro de HC en el efector
            DataTable mhc = SPs.SysGetUltimaHC(SSOHelper.CurrentIdentity.IdEfector).GetDataSet().Tables[0];
            lblHc.Text = "Próximo número de Historia Clínica sugerida para el efector: " + mhc.Rows[0][0].ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarGrilla();
            if (gvHClinicas.Rows.Count < 1)
            {
                lblMensaje.Text = "El Paciente buscado no posee Nro de Historia Clínica en el Efector";
            }
            else
            {
                lblMensaje.Text = "";
            }
        }

        protected void gvHClinicas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvHClinicas.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }
    }
}
