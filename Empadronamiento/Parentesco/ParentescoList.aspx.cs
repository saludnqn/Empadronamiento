using System;
using System.Web.UI.WebControls;
using DalSic;

namespace DalSic.Parentesco {
    public partial class ParentescoList : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {               
                int id = Convert.ToInt32(Request.QueryString["id"]);
                DalSic.SysPaciente pac = new DalSic.SysPaciente(id);

                lblApellido.Text = pac.Apellido;
                lblNombre.Text = pac.Nombre;
                lblDocumento.Text = Convert.ToString(pac.NumeroDocumento);
                hlParentesco.NavigateUrl = string.Format("ParentescoEdit.aspx?id={0}", pac.IdPaciente);

                SysParentescoCollection p = new DalSic.SysParentescoCollection().Where("idPaciente", pac.IdPaciente);
                gvParentesco.DataSource = p.OrderByAsc("TipoParentesco").Load();
                gvParentesco.DataBind();
            }            
        }

         protected void gvParentesco_PageIndexChanging(object sender, GridViewPageEventArgs e) 
         {
            gvParentesco.PageIndex = e.NewPageIndex;
         }

        }
}

