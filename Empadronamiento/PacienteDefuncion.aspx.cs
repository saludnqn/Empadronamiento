using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using DalSic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Salud.Security.SSO;
using SubSonic;

namespace Empadronamiento
{
    public partial class PacienteDefuncion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                DalSic.SysPaciente pac = new DalSic.SysPaciente(id);
                DataTable dtd = new DataTable();

                if (pac != null)
                {
                    txtDocumento.Text = pac.NumeroDocumento.ToString();
                    txtApellidoNombres.Text = pac.Apellido.ToString() + " " + pac.Nombre.ToString(); ;
                    txtEdad.Text = pac.Edad.ToString();
                    txtSexo.Text = pac.SysSexo.Nombre.ToString();
                    txtOS.Text = pac.SysObraSocial.Nombre.ToString();


                    SubSonic.Select query = new SubSonic.Select();
                    query.From(DalSic.SysDefuncion.Schema);
                    query.Where(SysDefuncion.Columns.IdPaciente).IsEqualTo(id).And(SysDefuncion.Columns.Activo).IsEqualTo(true);
                    
                    dtd = query.ExecuteDataSet().Tables[0];

                    if (dtd.Rows.Count > 0) //Se encontró registro de defunción asociado
                    {
                        cargarRegistro(dtd);
                        btnAnularDefuncion.Visible = true;
                        hfupdate.Value = "si";
                    }
                    else
                    {
                        hfupdate.Value = "no";
                    }

                }

            }
        }


        private void cargarRegistro(DataTable dtd)
        {
            foreach (DataRow row in dtd.Rows)
            {//Falta controlar los nulos o blancos
                txtFechaDefuncion.Text = row["fecha"].ToString().Substring(0, 10);
                txtHoraDefuncion.Text = row["hora"].ToString().Substring(0, 5);
                txtCausaMuerte.Text = row["CausaMuerte"].ToString();
                txtPersonalIngresaMorgue.Text = row["ingresoMorguePersonal"].ToString();
                txtEmpresaQueRetira.Text = row["egresoPersonal"].ToString();
                txtObservaciones.Text = row["observaciones"].ToString();
                hfMedico.Value = row["idProfesional"].ToString();
            }


        }

        [WebMethod]
        public static List<ListItem> GetProfesionales()
        {
            string query = "SELECT idProfesional,Apellido,Nombre FROM Sys_Profesional WHERE activo = 1 and idProfesional != -1 order by Apellido, nombre";
            string constr = ConfigurationManager.ConnectionStrings["SicConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> profesionales = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            profesionales.Add(new ListItem
                            {
                                Value = sdr["idprofesional"].ToString(),
                                Text = sdr["Apellido"].ToString() + " " + sdr["Nombre"].ToString(),
                            });
                        }
                    }
                    con.Close();

                    return profesionales;
                }
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            
            if (hfupdate.Value == "si")
            {
                actualizar();
            }
            else
            {
                insertar();
            }

            //Finalmente debería insertar la fecha de defunción en sys_paciente
            int id = Convert.ToInt32(Request.QueryString["id"]);
            DalSic.SysPaciente pac = new DalSic.SysPaciente(id);

            //ACtualizo la syspaciente asignando verdadero a fallecido
            //pac.Fallecido = true;
            
            pac.Save();

            //Termina de insertar y sale si no hay error
            if (this.error.Visible == false)
            {
                Response.Redirect("~/Paciente/PacienteList.aspx");

            }
            

        }


        private void insertar()
        {
            try
            {
                
                SysDefuncion defuncion = new SysDefuncion();
                defuncion.IdPaciente = Convert.ToInt32(Request.QueryString["id"]);
                defuncion.Fecha = txtFechaDefuncion.Text;
                defuncion.Hora = txtHoraDefuncion.Text;
                defuncion.CausaMuerte = txtCausaMuerte.Text;
                defuncion.IdProfesional = Convert.ToInt32(hfMedico.Value);
                defuncion.EgresoPersonal = txtEmpresaQueRetira.Text;
                defuncion.IngresoMorguePersonal = txtPersonalIngresaMorgue.Text;
                defuncion.Observaciones = txtObservaciones.Text;
                defuncion.Activo = true;
                defuncion.IdSsoUserAlta = Convert.ToInt32(SSOHelper.CurrentIdentity.Id);
                defuncion.IdSsoUserModificacion = Convert.ToInt32(SSOHelper.CurrentIdentity.Id);
                defuncion.FechaAlta = DateTime.Now;
                defuncion.FechaModificacion = DateTime.Now;
                
                defuncion.Save();
                

            }
            catch (Exception ex)
            {
                this.error.Visible = true;
            }    
        }

        private void actualizar()
        {
            try
            {
                
                //Hacemos el update
                SubSonic.Select query = new SubSonic.Select();
                query.From(SysDefuncion.Schema);
                query.Where(SysDefuncion.Columns.IdPaciente).IsEqualTo(Convert.ToInt32(Request.QueryString["id"]));
                SysDefuncion q = query.ExecuteSingle<SysDefuncion>();

                q.IdPaciente = q.IdPaciente; //Esto no debería cambiar ya que está asociado al mismo paciente
                q.Fecha = txtFechaDefuncion.Text;
                q.Hora = txtHoraDefuncion.Text;
                q.CausaMuerte = txtCausaMuerte.Text;
                q.IdProfesional = hfMedico.Value == "" ? q.IdProfesional : Convert.ToInt32(hfMedico.Value);
                q.EgresoPersonal = txtEmpresaQueRetira.Text;
                q.IngresoMorguePersonal = txtPersonalIngresaMorgue.Text;
                q.Observaciones = txtObservaciones.Text;
                q.IdSsoUserModificacion = Convert.ToInt32(SSOHelper.CurrentIdentity.Id);
                q.Activo = true;
                q.FechaModificacion = DateTime.Now;
                q.Save();
                

            }
            catch (Exception ex)
            {
                this.error.Visible = true;
                
            }
            

        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            //Aca hay que volver
            Response.Redirect("~/Paciente/PacienteList.aspx");
        }

        protected void btnAnularDefuncion_Click(object sender, EventArgs e)
        {
            //Hacemos la baja lógica del registro, la información quedara en la  base de datos




            int idPaciente = Convert.ToInt32(Request.QueryString["id"]);

            SubSonic.Select query = new SubSonic.Select();
            query.From(SysDefuncion.Schema);
            query.Where(SysDefuncion.Columns.IdPaciente).IsEqualTo(idPaciente).And(SysDefuncion.Columns.Activo).IsEqualTo(true);
            SysDefuncion q = query.ExecuteSingle<SysDefuncion>();

            
            q.Activo = false;
            q.Save();
            
            //Finalmente debería asignar al campo fallecido FALSE
            int id = Convert.ToInt32(idPaciente);
            DalSic.SysPaciente pac = new DalSic.SysPaciente(id);
            
            //pac.Fallecido = false;

            pac.Save();

            Response.Redirect("~/Paciente/PacienteList.aspx");

        }
    }
}