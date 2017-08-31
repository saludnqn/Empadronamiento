using System;
using System.Data;
using System.Web.UI.WebControls;
using DalSic;

namespace Empadronamiento
{
    public partial class PacienteCeliaco : System.Web.UI.Page
    {

    // -------------------------------------------------------------------------------------------------------------

        protected void Page_Load(object sender, EventArgs e)
        {           
            if (!IsPostBack)
            {
                PanelResultadoGrilla.Visible = false;
            }           
        }    

    // -------------------------------------------------------------------------------------------------------------

        protected void btnBuscarDNI_Click(object sender, EventArgs e)
        {
            cargarLista();
            PanelResultadoGrilla.Visible = true;
            lblMensaje.Text = string.Empty;
        }

    // -------------------------------------------------------------------------------------------------------------

        private void cargarLista()
        {                        
            gvLista.DataSource = SPs.GetPacientesPorDocumentoSinOSIdentificado(int.Parse(txtDNI.Text)).GetDataSet().Tables[0];

            if (gvLista.DataSource != null)
            {
                gvLista.DataBind();
            }
        }

    // -------------------------------------------------------------------------------------------------------------

        protected void gvLista_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        
        }

        // -----------------------------------------------------------------------------------------------------------------

        //// ,nota: Cada vez que se carga una fila en el grid se ejecuta el método "gvLista_RowDataBound"

        protected void gvLista_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        
        }

        // -----------------------------------------------------------------------------------------------------------------

        protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvLista.PageIndex = e.NewPageIndex;
            cargarLista();
        }

        // -----------------------------------------------------------------------------------------------------------

        private bool DatoValido(int idPaciente)
        {
            lblMensaje.Text = string.Empty;

            // Consulto en la tabla pacientes celíacos
            SubSonic.Select p = new SubSonic.Select();            
            p.From(DalSic.SysPacienteCeliaco.Schema);
            p.Where(SysPacienteCeliaco.Columns.IdPaciente).IsEqualTo(idPaciente);
            
            DataTable dt = p.ExecuteDataSet().Tables[0];

            if (dt.Rows.Count > 0)
            {
                lblMensaje.Text = "El paciente se encuentra registrado como celíaco. <br/>";
                return false;
            }
            else
            {
                return true;  
            }         
        }

        // -----------------------------------------------------------------------------------------------------------

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;

            foreach (GridViewRow row in gvLista.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chk = (CheckBox)row.FindControl("chkCeliaco");
                    Label lblIdPaciente = (Label)row.FindControl("lblIdPaciente");

                    int idPaciente = int.Parse(lblIdPaciente.Text);

                    if ((chk.Checked) && (DatoValido(idPaciente)))
                    {
                        SysPacienteCeliaco pacienteCeliaco = new SysPacienteCeliaco();
                        pacienteCeliaco.IdPaciente = idPaciente;
                        pacienteCeliaco.Activo = "SI";
                        pacienteCeliaco.FechaAlta = DateTime.Now;
                        pacienteCeliaco.Save();

                        lblMensaje.Text = "Paciente agregado";
                    }
                }
            }
        }

        // -----------------------------------------------------------------------------------------------------------

        protected void btnExportar_XLS_Click(object sender, EventArgs e)
        {
            string fileName = Server.MapPath(@"\tmp\RegistroDePacientesCeliacos.xls");

            DataSet pacientesCeliacos = SPs.PacientesCeliacosXLS().GetDataSet();

            pacientesCeliacos.WriteXml(fileName);

            Response.Buffer = true;
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "application/octect-stream";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
            Response.WriteFile(fileName);
            Response.Flush();
            Response.End();
        }

        // -----------------------------------------------------------------------------------------------------------

    }
}
