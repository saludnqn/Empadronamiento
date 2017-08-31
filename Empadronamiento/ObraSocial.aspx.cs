using System;
using System.Data;
using DalPadron;

namespace Empadronamiento
{
    public partial class ObraSocial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
                lblMensaje.Text = "";
                int Doc = SubSonic.Sugar.Web.QueryString<int>("Doc");
            if (Doc > 0)
            {
                CargarOS(Doc);
            }
        }

        private void CargarOS(int Doc)
        {
            //cheuqeo la osocial
            DataTable dtp = SPs.ListarObraSocial(Doc).GetDataSet().Tables[0];
            if (dtp.Rows.Count > 0)
            {
                gvOSocial.DataSource = dtp;
                gvOSocial.DataBind();
            }
            else
            {
                lblMensaje.Text = "Paciente sin Obra Social.";
            }
        }
    }
}
