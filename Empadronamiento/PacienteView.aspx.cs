using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DalSic.Utilidades;
using System.Web.UI.WebControls;
using DalSic;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System.Text;
using System.IO;
using System.Data;
using Empadronamiento.Reportes;
using Salud.Security.SSO;

namespace Empadronamiento
{
    public partial class PacienteView : System.Web.UI.Page
    {
        //static bool pacienteSumarActivo = true;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                DalSic.SysPaciente pac = new DalSic.SysPaciente(id);

                if (!pac.IsNew)
                {
                    if (pac.NumeroExtranjero != "")
                    {
                        lblNumeroDoc.Text = "";
                        //lblExtranjero.Text = "Doc. Extranjero: " + pac.NumeroExtranjero.ToString();
                        lblExtranjero.Text = pac.NumeroExtranjero.ToString();
                    }
                    else
                    {
                        //lblNumeroDoc.Text = "DU: " + pac.NumeroDocumento.ToString();
                        lblNumeroDoc.Text = pac.NumeroDocumento.ToString();
                        lblExtranjero.Text = "";
                    }
                    lblEstado.Text = pac.SysEstado.Nombre;
                    lblMotivoNI.Text = pac.SysMotivoNI.Nombre;
                    if ((pac.SysMotivoNI.Nombre != "SELECCIONAR") || (pac.SysMotivoNI.Nombre != "SIN DATOS"))
                        lblMotivoNI.Text = pac.SysMotivoNI.Nombre;
                    else lblMotivoNI.Text = "";
                    if (pac.FechaNacimiento.ToShortDateString() == "01/01/1900")
                        lblFechaNac.Text = "";
                    else lblFechaNac.Text = pac.FechaNacimiento.ToShortDateString();
                    lblApellido.Text = pac.Apellido;
                    lblNombre.Text = pac.Nombre;
                    lblSexo.Text = pac.SysSexo.Nombre;
                    if (pac.SysObraSocial.Nombre != "SELECCIONAR")
                    {
                        lblOSocial.Text = pac.SysObraSocial.Nombre;
                    }
                    else lblOSocial.Text = "";

                    /*Esta parte habilita para imprimir el certificado de Plan Sumar si el paciente está en el programa. Solo si es nivel central*/
                    if (SSOHelper.Configuration["idHospital"].ToString() == "0")
                    {
                        DalSic.PnBeneficiario beneficiario = new DalSic.PnBeneficiario("numero_doc", pac.NumeroDocumento);
                        DalSic.PnSmiafiliado afiliado = new DalSic.PnSmiafiliado("afidni", pac.NumeroDocumento);
                        //Ruben dice que la condición de activo/inactivo no es necesaria, debe salir si existe en PN_Beneficiario
                        //sino no debe salir nada. 
                        if (beneficiario.NumeroDoc != null || afiliado.Afidni != null)
                        {
                            this.imgSumar.Visible = true;
                        }
                        /*fin de sección cheque plan sumar*/
                    }

                    lblContacto.Text = !String.IsNullOrEmpty(pac.InformacionContacto) ? pac.InformacionContacto : "Sin datos";

                    if (pac.SysPai.Nombre != "SELECCIONAR")
                        lblNacionalidad.Text = pac.SysPai.Nombre;
                    else lblNacionalidad.Text = "";
                    //lugar de nacimiento
                    if (pac.SysProvincium.Nombre != "SELECCIONAR")
                        lblLugarNacimiento.Text = pac.SysProvincium.Nombre;
                    //pac.SysProvincium.Nombre;
                    else lblLugarNacimiento.Text = "";

                    lblTFijo.Text = !String.IsNullOrEmpty(pac.TelefonoFijo) ? pac.TelefonoFijo : "Sin datos";
                    lblTCelular.Text = !String.IsNullOrEmpty(pac.TelefonoCelular) ? pac.TelefonoCelular : "Sin datos";
                    lblEmail.Text = !String.IsNullOrEmpty(pac.Email) ? pac.Email : "Sin datos";
                    lblCalle.Text = !String.IsNullOrEmpty(pac.Calle) ? pac.Calle : "Sin datos";
                    lblNum.Text = !String.IsNullOrEmpty(pac.Numero.ToString()) ? pac.Numero.ToString() : "Sin datos";
                    lblEdificio.Text = !String.IsNullOrEmpty(pac.Edificio) ? pac.Edificio : "Sin datos";
                    lblPiso.Text = !String.IsNullOrEmpty(pac.Piso) ? pac.Piso : "Sin datos";
                    lblDepartamento.Text = !String.IsNullOrEmpty(pac.Departamento) ? pac.Departamento : "Sin datos";
                    lblManzana.Text = !String.IsNullOrEmpty(pac.Manzana) ? pac.Manzana : "Sin datos";
                    lblLatitud.Text = !String.IsNullOrEmpty(pac.Latitud) ? pac.Latitud : "Sin datos";
                    lblLongitud.Text = !String.IsNullOrEmpty(pac.Longitud) ? pac.Longitud : "Sin datos";
                    lblProvincia.Text = pac.SysProvincium.Nombre != "SELECCIONAR" ? pac.SysProvincium.Nombre : "Sin datos";
                    lblDptoDomicilio.Text = pac.SysDepartamento.Nombre != "SELECCIONAR" ? pac.SysDepartamento.Nombre : "Sin datos";
                    lblLocalidad.Text = pac.SysLocalidad.Nombre != "SELECCIONAR" ? pac.SysLocalidad.Nombre : "Sin datos";
                    lblCPostal.Text = !String.IsNullOrEmpty(pac.SysLocalidad.CodigoPostal.ToString()) ? pac.SysLocalidad.CodigoPostal.ToString() : "Sin datos";
                    lblBarrio.Text = pac.SysBarrio.Nombre != "SELECCIONAR" ? pac.SysBarrio.Nombre : "Sin datos";
                    lblOBarrio.Text = pac.OtroBarrio.ToString();
                    lblReferencia.Text = !String.IsNullOrEmpty(pac.Referencia) ? pac.Referencia : "Sin datos";
                    //lblDefuncion.Text = pac.Fallecido == true ? pac.SysDefuncionRecords.First<SysDefuncion>().Fecha.ToString().Substring(0,10):""; 
                    lblUrbano.Text = pac.EsUrbano == true ? "Urbano":"Rural";
                    lblCamino.Text = !String.IsNullOrEmpty(pac.Camino.ToString()) ? pac.Camino.ToString():"Sin datos";
                    lblCampo.Text = !String.IsNullOrEmpty(pac.Campo.ToString()) ? pac.Camino.ToString() : "Sin datos";
                    lblLote.Text = !String.IsNullOrEmpty(pac.Lote) ? pac.Lote : "Sin datos";
                    lblParcela.Text = !String.IsNullOrEmpty(pac.Parcela.ToString())? pac.Parcela.ToString() : "Sin datos";

                    if (pac.SysParentescoRecords.Count > 0)
                    {
                        SysParentesco par = pac.SysParentescoRecords[0];
                        lblParentesco.Text = !String.IsNullOrEmpty(par.TipoParentesco) ? par.TipoParentesco : "Sin datos";
                        lblDocP.Text = !String.IsNullOrEmpty(par.NumeroDocumento.ToString()) ? par.NumeroDocumento.ToString() : "Sin datos";
                        lblApellidoP.Text = !String.IsNullOrEmpty(par.Apellido) ? par.Apellido : "Sin datos";
                        lblNombreP.Text = !String.IsNullOrEmpty(par.Nombre)? par.Nombre : "Sin datos";
                        lblFecNacP.Text = par.FechaNacimiento.ToShortDateString() == "01/01/1900" ? "": par.FechaNacimiento.ToShortDateString();
                        lblNacionalidadP.Text = par.SysPai.Nombre != "SELECCIONAR" ? par.SysPai.Nombre : "Sin datos" ;
                        lblLNacimientoP.Text = par.SysProvincium.Nombre != "SELECCIONAR" ? par.SysProvincium.Nombre : "Sin datos";
                    }
                    if (pac.SysParentescoRecords.Count > 1)
                    {
                        SysParentesco par = pac.SysParentescoRecords[1];
                        lblParentesco0.Text = !String.IsNullOrEmpty(par.TipoParentesco)? par.TipoParentesco : "Sin datos";
                        
                        lblDocP0.Text = !String.IsNullOrEmpty(par.NumeroDocumento.ToString()) ? par.NumeroDocumento.ToString():"Sin datos";
                        lblApellidoP0.Text = !String.IsNullOrEmpty(par.Apellido) ? par.Apellido:"Sin datos";
                        lblNombreP0.Text = !String.IsNullOrEmpty(par.Nombre) ? par.Nombre : "Sin datos";
                        lblFecNacP0.Text = par.FechaNacimiento.ToShortDateString() == "01/01/1900" ? "" : "Sin datos";
                        lblNacionalidadP0.Text = par.SysPai.Nombre != "SELECCIONAR" ? par.SysPai.Nombre  : "Sin datos" ;
                        lblNacionalidadP0.Text = par.SysProvincium.Nombre != "SELECCIONAR" ? par.SysProvincium.Nombre : "Sin datos";
                    }
                    
                }
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            SysPaciente p = new SysPaciente(id);
            Response.Redirect("PacienteEdit.aspx?id=" + p.IdPaciente.ToString());
        }

        protected void imgSumar_Click(object sender, ImageClickEventArgs e)
        {//Este método genera invoca a la función que genera el Certificado PDF
          
                int id = Convert.ToInt32(Request.QueryString["id"]);
                ConstanciaSumar cs = new ConstanciaSumar();
                MemoryStream oStream = cs.imprimirConstancia(id);
                string nombreArchivo = "Constancia Sumar";

                //Este response es para que aparezca el popUp del pdf
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + nombreArchivo + ".pdf");

                Response.BinaryWrite(oStream.ToArray());
                Response.End();
       
        }

    }
}