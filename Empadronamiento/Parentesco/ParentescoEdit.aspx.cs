using System;
using Salud.Security.SSO;

namespace DalSic.Parentesco
{
    public partial class ParentescoEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {               
                int id = Convert.ToInt32(Request.QueryString["id"]);

                DalSic.SysParentesco par = new DalSic.SysParentesco(id);
                // si no es nuevo entonces cargo los datos y los muestro
                if (!par.IsNew)
                {
                    txtApellido.Text = par.Apellido;
                    txtNombre.Text = par.Nombre;
                    txtNumero.Text = par.NumeroDocumento.ToString();
                    txtFechaN.Text = par.FechaNacimiento.ToShortDateString();
                    ddlProvincia.SelectedValue = par.IdProvincia.ToString();
                    ddlNacionalidad.SelectedValue = par.IdPais.ToString();
                    ddlParentesco.SelectedValue = par.TipoParentesco.ToString();

                }
            }            
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //llamo una instancia del objeto
            int id = Convert.ToInt32(Request.QueryString["id"]);
            DalSic.SysParentesco par = new DalSic.SysParentesco(id);

            par.IdPaciente = id;
            par.TipoParentesco = ddlParentesco.SelectedValue;
            par.Apellido = txtApellido.Text;
            par.Nombre = txtNombre.Text;
            par.NumeroDocumento = Convert.ToInt32(txtNumero.Text);
            par.FechaNacimiento = Convert.ToDateTime(txtFechaN.Text);
            par.IdProvincia = Convert.ToInt32(ddlProvincia.SelectedValue);
            par.IdPais = Convert.ToInt32(ddlNacionalidad.SelectedValue);

            //hardcodeado el usuario logueado (en la creacion)
            par.IdUsuario = SSOHelper.CurrentIdentity.Id;
            //guardo la fecha actual de modificacion
            par.FechaModificacion = DateTime.Now;

            try
            {
                par.Save();                
                lblMensaje.Text = "Los datos fueron guardados correctamente";
            }
            catch (Exception ex)
            {
                // Poner la logica de error
                lblMensaje.Text = "Los datos no fueron guardados correctamente";
                throw;
            }

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/PacienteList.aspx", false);
        }
    }
}
