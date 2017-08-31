using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Salud.Security.SSO;
using System.Data;
using DalSic;

namespace Empadronamiento
{
    public partial class PacienteList : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnNuevo.Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteList.aspx.btnNuevo");
            gvPacientes.Columns[6].Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteView.aspx");
            gvPacientes.Columns[7].Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteEdit.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDni.Focus();
                this.Form.DefaultButton = btnBuscar.UniqueID;
            }
        }

        protected void gvPacientes_PageIndexChangind(object sender, GridViewPageEventArgs e)
        {
            btnBuscar_Click(null, null);
            gvPacientes.PageIndex = e.NewPageIndex;
            gvPacientes.DataBind();
        }

        protected void gridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dataTable = gvPacientes.DataSource as DataTable;

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);
                gvPacientes.DataSource = dataView;
                gvPacientes.DataBind();
            }
        }

        private string ConvertSortDirectionToSql(SortDirection sortDirection)
        {
            string newSortDirection = String.Empty;

            switch (sortDirection)
            {
                case SortDirection.Ascending:
                    newSortDirection = "ASC";
                    break;
                case SortDirection.Descending:
                    newSortDirection = "DESC";
                    break;
            }
            return newSortDirection;
        }

        protected void gvPacientes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (DataBinder.Eval(e.Row.DataItem, "estado").ToString())
                {
                    
                    case "Identificado":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#f6ce95");
                        e.Row.ToolTip = "Pacientes Identificados";
                        break;
                    case "Temporal":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#e27c79");
                        e.Row.ToolTip = "Pacientes Temporales";
                        break;
                    case "Validado":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#91cf91");
                        e.Row.ToolTip = "Pacientes Validados";
                        break;
                    case "Inactivo":
                        e.Row.BackColor = System.Drawing.Color.Azure;
                        e.Row.ToolTip = "Pacientes Inactivos";
                        break;
                    default: e.Row.BackColor = System.Drawing.Color.White;
                        break;
                }
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            
            SubSonic.Select s = new SubSonic.Select();
            s.From(SysPaciente.Schema);

            //busqueda por documento
            if (txtDni.Text.Length > 0)
            {
                int nrodoc = 0;
                nrodoc = Convert.ToInt32(txtDni.Text);

                gvPersonas.DataSource = DalPadron.SPs.ListarObraSocial(nrodoc).GetDataSet().Tables[0];
                gvPersonas.DataBind();

                gvPacientes.DataSource = SPs.GetPacientesPorDocumento(nrodoc).GetDataSet();
                gvPacientes.DataBind();

                return;
            }

            DateTime fnac;
            DateTime? fnac2 = null;
            if (DateTime.TryParse(txtFecNacBusqueda.Text, out fnac))
            {
                fnac2 = fnac;
            }
            //Busqueda por Nro Doc de la Madre
            int docM = 0;
            if (txtDniMadre.Text != "")
            {
                docM = Convert.ToInt32(txtDniMadre.Text);
            }
            
            gvPacientes.DataSource = SPs.GetPacientesPorNombres(fnac2, txtNombre.Text.Trim(), txtApellido.Text.Trim(), docM, txtNombreMadre.Text.Trim(), txtApellidoMadre.Text.Trim()).GetDataSet();
            gvPacientes.DataBind();
            

        }
        protected void gvPersonas_PageIndexChangind(object sender, GridViewPageEventArgs e)
        {
            btnBuscar_Click(null, null);
            gvPersonas.PageIndex = e.NewPageIndex;
            gvPersonas.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            if (txtDni.Text.Trim().Length > 0)
                Response.Redirect("PacienteEdit.aspx?dni=" + txtDni.Text.Trim());
            else
                Response.Redirect("PacienteEdit.aspx");
        }
    }
}