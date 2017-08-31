using DalSic;
using Newtonsoft.Json;
using Salud.Security.SSO;
using Empadronamiento.Reportes;
using SubSonic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace Empadronamiento
{
    public partial class PacienteEdit : System.Web.UI.Page
    {

        #region helperObraSocial
        public class helperObraSocial
        {
            private int idObraSoacial;

            public int IdObraSoacial
            {
                get { return idObraSoacial; }
                set { idObraSoacial = value; }
            }

            private string nombre;

            public string Nombre
            {
                get { return nombre; }
                set { nombre = value; }
            }
        }

        #endregion

        #region Atributos

        private string IdArgentina
        {
            get
            {
                return ConfigurationManager.AppSettings["idArgentina"].ToString();
            }
        }
        private string IdNeuquen
        {
            get
            {
                return ConfigurationManager.AppSettings["idNeuquen"].ToString();
            }
        }
        private string IdConfluencia
        {
            get
            {
                return ConfigurationManager.AppSettings["idConfluencia"].ToString();
            }
        }
        private string IdNqn
        {
            get
            {
                return ConfigurationManager.AppSettings["idNqn"].ToString();
            }
        }
        private int idObraSocial { get; set; }

        #endregion

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            
            btnGuardarRem.Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteEdit.aspx.btnGuardarRem");
            btnGuardarClasif.Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteEdit.aspx.btnGuardarClasif");
            btnGuardarCP.Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteEdit.aspx.btnGuardarCP");
            btnGuardarCM.Visible = SSOHelper.CurrentIdentity.TestPermissionByEfector("/PacienteEdit.aspx.btnGuardarCM");
        }

        [Serializable]
        public class MyJsonDictionary<K, V> : ISerializable
        {
            Dictionary<K, V> dict = new Dictionary<K, V>();

            public MyJsonDictionary() { }

            protected MyJsonDictionary(SerializationInfo info, StreamingContext context)
            {
                throw new NotImplementedException();
            }

            public void GetObjectData(SerializationInfo info, StreamingContext context)
            {
                foreach (K key in dict.Keys)
                {
                    info.AddValue(key.ToString(), dict[key]);
                }
            }

            public void Add(K key, V value)
            {
                dict.Add(key, value);
            }

            public V this[K index]
            {
                set { dict[index] = value; }
                get { return dict[index]; }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (hdfDocumentoValido.Value == "false")
                txtNumeroDocumento.Focus();

            if (!IsPostBack)
            {
                string strIdHospital = SSOHelper.Configuration["idHospital"] as string;

                if (strIdHospital != "0")
                    panel3.Visible = true;
                else
                    panel3.Visible = false;

                txtNumeroDocumento.Focus();

                CargarCombos();

                int id = Convert.ToInt32(Request.QueryString["id"]);
                DalSic.SysPaciente pac = new DalSic.SysPaciente(id);
                //Inicializo la variable oculta para ver 
                hdfProvinciaDomicilio.Value = "0";

                if (!pac.IsNew)
                {
                    alertaDatosUltimaModificacion.Visible = true;
                    cargarPaciente(id);
                }
                else
                {
                    // Aqui entra si es un paciente nuevo
                    alertaDatosUltimaModificacion.Visible = false;

                    txtNumeroDocumento.Text = Request.QueryString["dni"];
                    ddlNacionalidad.SelectedValue = IdArgentina;
                    ddlNacionalidad_SelectedIndexChanged(null, null);
                    //ddlProvinciaDomicilio.SelectedValue = IdNeuquen;
                    //ddlProvinciaDomicilio_SelectedIndexChanged(null, null);
                    //ddlDepartamento.SelectedValue = IdConfluencia;
                    //ddlDepartamento_SelectedIndexChanged(null, null);
                    //ddlLocalidad.SelectedValue = IdNqn;
                    //ddlLocalidad_SelectedIndexChanged(null, null);
                }
            }
        }

        private void CargarCombos()
        {
            SubSonic.Select pa = new SubSonic.Select();
            pa.From(SysPai.Schema);
            pa.OrderAsc("nombre");
            List<SysPai> paises = pa.ExecuteTypedList<SysPai>();
            ddlNacionalidad.DataSource = paises;
            ddlNacionalidad.DataBind();

            ddlNacionalidadM.DataSource = paises;
            ddlNacionalidadM.DataBind();
            ddlNacionalidadM.Items.Insert(0, new ListItem("SELECCIONAR", "-1"));

            ddlNacionalidadP.DataSource = paises;
            ddlNacionalidadP.DataBind();
            ddlNacionalidadP.Items.Insert(0, new ListItem("SELECCIONAR", "-1"));

            SubSonic.Select pd = new SubSonic.Select();
            pd.From(SysProvincium.Schema);
            pd.Where(SysProvincium.Columns.IdPais).IsEqualTo(IdArgentina);
            ddlProvincia.DataSource = pd.ExecuteTypedList<SysProvincium>();
            ddlProvincia.DataBind();
            ddlProvincia.Items.Insert(0, new ListItem("Seleccione Provincia", "-1"));

            ddlLugarNacimientoP.DataSource = pd.ExecuteTypedList<SysProvincium>();
            ddlLugarNacimientoP.DataBind();
            ddlLugarNacimientoP.Items.Insert(0, new ListItem("SELECCIONAR", "-1"));

            ddlLugarNacimientoM.DataSource = pd.ExecuteTypedList<SysProvincium>();
            ddlLugarNacimientoM.DataBind();
            ddlLugarNacimientoM.Items.Insert(0, new ListItem("SELECCIONAR", "-1"));

            SubSonic.Select e = new SubSonic.Select();
            e.From(SysEstado.Schema);
            List<SysEstado> estados = e.ExecuteTypedList<SysEstado>();
            ddlEstadoP.DataTextField = "nombre";
            ddlEstadoP.DataValueField = "idEstado";
            ddlEstadoP.DataSource = estados;
            ddlEstadoP.DataBind();
            ddlEstadoP.SelectedIndex = ddlEstadoP.Items.IndexOf(ddlEstadoP.Items.FindByText("Identificado"));

            SubSonic.Select m = new SubSonic.Select();
            m.From(SysMotivoNI.Schema);
            m.InnerJoin(SysRelEstadoMotivoNI.Schema);
            m.Where(SysRelEstadoMotivoNI.IdEstadoColumn).IsEqualTo(ddlEstadoP.SelectedValue);
            ddlMotivoNI.DataSource = m.ExecuteTypedList<SysMotivoNI>();
            ddlMotivoNI.DataBind();

            //ddlMotivoNI.DataSource = SPs.SysGetMotivoNI(int.Parse(ddlEstadoP.SelectedValue)).ExecuteTypedList<SysMotivoNI>();
            //ddlMotivoNI.DataBind();

            SubSonic.Select s = new SubSonic.Select();
            s.From(SysSexo.Schema);
            ddlSexo.DataSource = s.ExecuteTypedList<SysSexo>();
            ddlSexo.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);

            if (id == 0) id = int.Parse(hfIdPaciente.Value);

            if (hdfFormValido.Value == "true")
            {
                DalSic.SysPaciente pac = new DalSic.SysPaciente(id);

                pac.FechaAlta = DateTime.Now;
                pac.Apellido = txtApellido.Text.ToUpper();
                pac.Nombre = txtNombre.Text.ToUpper();
                if (id == 0) pac.FechaAlta = DateTime.Now;
                pac.IdSexo = Convert.ToInt32(ddlSexo.SelectedValue);
                //valido que la fecha no se mayor a la actual
                DateTime fec = Convert.ToDateTime("01/01/1900");
                DateTime.TryParse(txtFechaNac.Text, out fec);
                if ((fec <= DateTime.Now) && (txtFechaNac.Text != ""))
                {
                    pac.FechaNacimiento = Convert.ToDateTime(txtFechaNac.Text);
                }
                //nacionalidad
                pac.IdPais = Convert.ToInt32(ddlNacionalidad.SelectedValue);
                //lugar de nacimiento
                pac.IdProvincia = Convert.ToInt32(ddlProvincia.SelectedValue);
                pac.Calle = txtCalle.Text.ToUpper();

                if (!string.IsNullOrEmpty(txtNumero.Text))
                {
                    string[] altura = txtNumero.Text.Split('-');

                    pac.Numero = (altura.Length > 1) ? (int.Parse(altura[0]) + int.Parse(altura[1])) / 2 : Convert.ToInt32(txtNumero.Text); //Convert.ToInt32(txtNumero.Text);
                }
                else
                    pac.Numero = 0;

                pac.Edificio = txtEdificio.Text.ToUpper();
                pac.Piso = txtPiso.Text.ToUpper();
                pac.Departamento = txtDepartamento.Text.ToUpper();
                pac.Manzana = txtManzana.Text.ToUpper();
                pac.IdProvinciaDomicilio = !String.IsNullOrEmpty(hdfProvinciaDomicilio.Value) ? int.Parse(hdfProvinciaDomicilio.Value) : 0; //Convert.ToInt32(ddlProvinciaDomicilio.SelectedValue);
                pac.IdDepartamento = !String.IsNullOrEmpty(hdfDepartamento.Value) ? int.Parse(hdfDepartamento.Value) : 0;            //Convert.ToInt32(ddlDepartamento.SelectedValue);
                pac.IdLocalidad = !String.IsNullOrEmpty(hdfLocalidad.Value) ? int.Parse(hdfLocalidad.Value) : 0;
                pac.IdBarrio = !String.IsNullOrEmpty(hdfBarrio.Value) ? int.Parse(hdfBarrio.Value) : 0;

                //if (ddlLocalidad.SelectedValue != "") pac.IdLocalidad = Convert.ToInt32(ddlLocalidad.SelectedValue);
                //else pac.IdLocalidad = -1;
                //if (ddlBarrio.SelectedValue != "") pac.IdBarrio = Convert.ToInt32(ddlBarrio.SelectedValue);
                //else pac.IdBarrio = -1;
                //modifico permitiendo el ingreso de Otro Barrio
                pac.OtroBarrio = txtOBarrio.Text.ToUpper();
                pac.Referencia = txtReferencia.Text.ToUpper();

                pac.InformacionContacto = txtContacto.Text.ToUpper();

                if (txtTFijo.Text != "")
                    pac.TelefonoFijo = hdfCodigoPaisTelFijo.Value + " " + txtTFijo.Text;

                if (txtTCelular.Text != "")
                    pac.TelefonoCelular = hdfCodigoPaisCelular.Value + " " + txtTCelular.Text;


                pac.Email = txtEmail.Text;

                if (rbtUrbano.Checked)
                    pac.EsUrbano = true;
                else
                    pac.EsUrbano = false;

                pac.Latitud = txtLatitud.Text;
                pac.Longitud = txtLongitud.Text;

                pac.Campo = txtCampo.Text.ToUpper();
                pac.Camino = txtCamino.Text.ToUpper();
                pac.Lote = txtLote.Text.ToUpper();
                pac.Parcela = txtParcela.Text.ToUpper();
                pac.Activo = true;

                pac.IdUsuario = SSOHelper.CurrentIdentity.Id;
                pac.IdEfector = Convert.ToInt32(SSOHelper.CurrentIdentity.IdEfector);
                pac.FechaUltimaActualizacion = DateTime.Now;

                //Guardo los datos del Parentesco. Traigo con lblbIdParentesco el idParentesco asociado al paciente
                //datos de la madre
                SysParentesco parM = new SysParentesco(lblIdParentescoM.Text);

                if ((txtApellidoM.Text != "") && (txtNombreM.Text != ""))
                {
                    parM.Apellido = txtApellidoM.Text.ToUpper();
                    parM.Nombre = txtNombreM.Text.ToUpper();
                    parM.TipoParentesco = "MADRE";
                    parM.IdTipoDocumento = 1;

                    if (txtNumeroM.Text != "") parM.NumeroDocumento = Convert.ToInt32(txtNumeroM.Text); else parM.NumeroDocumento = 0;
                    if (txtFNacMadre.Text != "") parM.FechaNacimiento = Convert.ToDateTime(txtFNacMadre.Text); //else parM.FechaNacimiento = Convert.ToDateTime("01/01/1900");

                    parM.IdPais = Convert.ToInt32(ddlNacionalidadM.SelectedValue);
                    parM.IdProvincia = Convert.ToInt32(ddlLugarNacimientoM.SelectedValue);
                    parM.IdUsuario = SSOHelper.CurrentIdentity.Id;
                    //guardo la fecha actual de modificacion
                    parM.FechaModificacion = DateTime.Now;
                }
                //datos del padre
                SysParentesco parP = new SysParentesco(lblIdParentescoP.Text);
                if ((txtApellidoPadre.Text != "") & (txtNombrePadre.Text != ""))// & (txtDUPadre.Text != "") & (txtFNacPadre.Text != ""))
                {
                    parP.Apellido = txtApellidoPadre.Text.ToUpper();
                    parP.Nombre = txtNombrePadre.Text.ToUpper();
                    parP.TipoParentesco = "PADRE";
                    parP.IdTipoDocumento = 1;

                    if (!string.IsNullOrEmpty(txtDUPadre.Text)) parP.NumeroDocumento = Convert.ToInt32(txtDUPadre.Text); else parP.NumeroDocumento = 0;
                    if (!string.IsNullOrEmpty(txtFNacPadre.Text)) parP.FechaNacimiento = Convert.ToDateTime(txtFNacPadre.Text); //else parP.FechaNacimiento = DateTime.Parse("01/01/1900");

                    parP.IdPais = Convert.ToInt32(ddlNacionalidadP.SelectedValue);
                    parP.IdProvincia = Convert.ToInt32(ddlLugarNacimientoP.SelectedValue);
                    parP.IdUsuario = SSOHelper.CurrentIdentity.Id;
                    //guardo la fecha actual de modificacion
                    parP.FechaModificacion = DateTime.Now;
                }

                // Estado 2=Temporal
                if (ddlEstadoP.SelectedValue == "2")
                {
                    //no guardo el nro extranjero                        
                    int doc = new Select("numeroDocumento")
                            .From(SysPaciente.Schema)
                            .Where(SysPaciente.Columns.IdEstado).IsEqualTo(2)
                            .GetRecordCount();
                    if (doc > 0)
                    {
                        pac.NumeroDocumento = doc + 1;
                    }

                    if (hdfMotivo.Value == "2")
                    {
                        lblExtranjero.Text = "Doc. Extranjero: ";
                        txtNumeroExtranjero.Visible = true;
                        pac.NumeroExtranjero = txtNumeroExtranjero.Text;
                    }
                }
                else
                {
                    if (txtNumeroDocumento.Text != "") pac.NumeroDocumento = Convert.ToInt32(txtNumeroDocumento.Text);
                }
                pac.IdEstado = Convert.ToInt32(ddlEstadoP.SelectedValue);
                pac.IdMotivoNI = int.Parse(hdfMotivo.Value);// Convert.ToInt32(ddlMotivoNI.SelectedValue);

                int i_obrasocial = 0;
                if (hdfIdObraSocial.Value != "")
                    i_obrasocial = int.Parse(hdfIdObraSocial.Value);

                pac.IdObraSocial = i_obrasocial;
                pac.Save(SSOHelper.CurrentIdentity.Id);

                // guardo el id obra social en la Sys_RelPacienteObraSocial
                if (i_obrasocial > -1)
                {
                    // si el paciente ya tiene cargada la obra social en la relación no la vuelvo a cargar.
                    int existeOS = new SubSonic.Select()
                    .From(Schemas.SysRelPacienteObraSocial)
                    .Where(SysRelPacienteObraSocial.Columns.IdPaciente).IsEqualTo(pac.IdPaciente)
                    .And(SysRelPacienteObraSocial.Columns.IdObraSocial).IsEqualTo(i_obrasocial)
                    .GetRecordCount();

                    if (existeOS <= 0)
                    {
                        SysRelPacienteObraSocial relObraSocial = new SysRelPacienteObraSocial();

                        relObraSocial.FechaAlta = DateTime.Now;
                        relObraSocial.IdObraSocial = i_obrasocial;
                        relObraSocial.IdPaciente = pac.IdPaciente;
                        relObraSocial.NumeroAfiliado = (pac.NumeroAfiliado == null ? "" : pac.NumeroAfiliado);
                        relObraSocial.Save(SSOHelper.CurrentIdentity.Id);
                    }
                }

                if ((txtApellidoM.Text != "") & (txtNombreM.Text != ""))
                {
                    parM.IdPaciente = pac.IdPaciente;
                    parM.Save(SSOHelper.CurrentIdentity.Id);
                }
                if ((txtApellidoPadre.Text != "") & (txtNombrePadre.Text != ""))
                {
                    parP.IdPaciente = pac.IdPaciente;
                    parP.Save(SSOHelper.CurrentIdentity.Id);
                }
                if (Request.QueryString["llamada"] == "Recupero")
                    Response.Redirect("/Recupero/OrdenPrestacion/PacienteList.aspx?PacienteRetorno=" + pac.IdPaciente.ToString() + "&idUsuario=" + Session["idUsuario"]);
                if (Request.QueryString["llamada"] == "LaboTurno")
                    Response.Redirect("/Laboratorio/Turnos/TurnosEdit2.aspx?idPaciente=" + pac.IdPaciente.ToString() + "&Modifica=0");
                if (Request.QueryString["llamada"] == "Consultorio")
                    Response.Redirect("../Consultorio/Turnos/TurnoNuevo.aspx?idPaciente=" + pac.IdPaciente.ToString());
                if (Request.QueryString["llamada"] == "Screening")
                    Response.Redirect("~/Laboratorio/Neonatal/IngresoEdit.aspx?idPaciente=" + pac.IdPaciente.ToString());
                if (Request.QueryString["llamada"] == "LaboProtocolo")
                    Response.Redirect("/Laboratorio/Protocolos/ProtocoloEdit2.aspx?idPaciente=" + pac.IdPaciente.ToString() + "&Operacion=" + Request.QueryString["Operacion"] + "&idServicio=" + Request.QueryString["idServicio"] + "&idUrgencia=" + Request.QueryString["idUrgencia"]);
                if (Request.QueryString["llamada"] == "ConsultaPaciente")
                    Response.Redirect("../Paciente/PacienteReporte.aspx?idPaciente=" + pac.IdPaciente.ToString());
                if (Request.QueryString["llamada"] == "RegistroMx")
                    Response.Redirect("/Mamas/Default.aspx?idPaciente=" + pac.IdPaciente.ToString() + "&idUsuario=" + Session["idUsuario"]);
                if (Request.QueryString["llamada"] == "Prosane")
                    Response.Redirect("/Prosane/ProsameEdit.aspx?idPaciente=" + pac.IdPaciente.ToString());

                string idHospital = SSOHelper.Configuration["idHospital"].ToString();

                if (idHospital == "0") // Solo si es nivel central.
                {
                    //Luego de guardar el paciente llamamos a la clase q chequea las condiciones para agregar a Programa Sumar
                    ConstanciaSumar cs = new ConstanciaSumar();
                    //Si se complen todas las condiciones del storeprocedure el paciente se guarda en la tabla pn_beneficiario
                    cs.insertarBeneficiario(pac.IdPaciente);
                }

                Response.Redirect("PacienteList.aspx", false);
            }
        }

        protected void ddlNacionalidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarProvincia();
        }

        private void CargarProvincia()
        {
            // Busco las provincias de la nacionalidad seleccionada
            //SubSonic.Select n = new SubSonic.Select();
            //n.From(DalSic.SysProvincium.Schema);
            //n.Where(SysProvincium.Columns.IdPais).IsEqualTo(ddlNacionalidad.SelectedValue);
            //n.Or(SysProvincium.Columns.IdProvincia).IsEqualTo(0);
            //n.Or(SysProvincium.Columns.IdProvincia).IsEqualTo(-1);
            //ddlProvincia.DataSource = n.ExecuteTypedList<SysProvincium>();
            //ddlProvincia.DataBind();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string strServer = ConfigurationManager.AppSettings["ipServer"];
            if (Request.QueryString["llamada"] == "Recupero")
                Response.Redirect("/Recupero/OrdenPrestacion/PacienteList.aspx?idUsuario=" + Session["idUsuario"]);
            if (Request.QueryString["llamada"] == "LaboTurno")
                Response.Redirect("/Laboratorio/Turnos/Default.aspx?id={0}&idUsuario=" + Session["idUsuario"]);
            if (Request.QueryString["llamada"] == "ConsultaPaciente")
                Response.Redirect("../Paciente/PacienteReporte.aspx?idUsuario=" + Session["idUsuario"]);
            if (Request.QueryString["llamada"] == "RegistroMx")
                Response.Redirect("/Mamas/Default.aspx?idUsuario=" + Session["idUsuario"]);
            if (Request.QueryString["llamada"] == "Prosane")
                Response.Redirect("/Prosane/ProsameEdit.aspx?idUsuario=" + Session["idUsuario"]);
            Response.Redirect("PacienteList.aspx", false);
        }

        protected void ddlProvinciaDomicilio_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarDepartamento();
        }

        private void CargarDepartamento()
        {
            //ddlDepartamento.Items.Clear();
            ////Selecciono el item del combo Provincia y filtro los departamentos de la provincia
            //SubSonic.Select p = new SubSonic.Select();
            //p.From(DalSic.SysDepartamento.Schema);
            //p.Where(SysDepartamento.Columns.IdProvincia).IsEqualTo(ddlProvinciaDomicilio.SelectedValue);
            //p.Or(SysDepartamento.Columns.IdDepartamento).IsEqualTo(0);
            //p.Or(SysDepartamento.Columns.IdDepartamento).IsEqualTo(-1);
            //ddlDepartamento.DataSource = p.ExecuteTypedList<SysDepartamento>();
            //ddlDepartamento.DataBind();
        }

        //protected void ddlProvinciaDomicilio_DataBound(object sender, EventArgs e)
        //{
        //    ddlProvinciaDomicilio.SelectedValue = ddlProvinciaDomicilio.Items.IndexOf(ddlProvinciaDomicilio.Items.FindByValue(IdNeuquen)).ToString();
        //    ddlProvinciaDomicilio_SelectedIndexChanged(null, null);
        //}

        protected void ddlNacionalidad_DataBound(object sender, EventArgs e)
        {
            ddlNacionalidad.SelectedValue = ddlNacionalidad.Items.IndexOf(ddlNacionalidad.Items.FindByValue(IdArgentina)).ToString();
            ddlNacionalidad_SelectedIndexChanged(null, null);
        }

        //protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    CargarLocalidad();
        //}

        //private void CargarLocalidad()
        //{
        //    //Selecciono el item del combo Departamento y filtro las localidades del departamento
            
        //    SubSonic.Select p = new SubSonic.Select();
        //    p.From(DalSic.SysLocalidad.Schema);
        //    p.Where(SysLocalidad.Columns.IdDepartamento).IsEqualTo(ddlDepartamento.SelectedValue);
        //    p.Or(SysLocalidad.Columns.IdLocalidad).IsEqualTo(0);
        //    p.Or(SysLocalidad.Columns.IdLocalidad).IsEqualTo(-1);
        //    ddlLocalidad.DataSource = p.ExecuteTypedList<SysLocalidad>();
        //    ddlLocalidad.DataBind();
        //}

        //protected void ddlLocalidad_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    CargarBarrio();
        //}

        //private void CargarBarrio()
        //{
        //    //Selecciono el item del combo Localidad y filtro los barrios de la localidad

            
        //    SubSonic.Select b = new SubSonic.Select();
        //    b.From(DalSic.SysBarrio.Schema);
        //    b.Where(SysBarrio.Columns.IdLocalidad).IsEqualTo(ddlLocalidad.SelectedValue);
        //    b.Or(SysBarrio.Columns.IdBarrio).IsEqualTo(0);
        //    b.Or(SysBarrio.Columns.IdBarrio).IsEqualTo(-1);
        //    ddlBarrio.DataSource = b.ExecuteTypedList<SysBarrio>();
        //    ddlBarrio.DataBind();

        //    if ((ddlLocalidad.SelectedItem.Value != "-1") && (ddlLocalidad.SelectedItem.Value != "0"))
        //    {
        //        SubSonic.Select cod = new SubSonic.Select();
        //        cod.From(SysLocalidad.Schema);
        //        cod.Where(SysLocalidad.Columns.IdLocalidad).IsEqualTo(ddlLocalidad.SelectedValue);
        //        SysLocalidad l = new SysLocalidad();
        //        l = cod.ExecuteSingle<SysLocalidad>();
        //        txtCPostal.Text = l.CodigoPostal.ToString();
        //    }
            
        //}

        //protected void ddlLocalidad_DataBound(object sender, EventArgs e)
        //{
        //    ddlLocalidad.SelectedValue = ddlLocalidad.Items.IndexOf(ddlLocalidad.Items.FindByValue(IdNqn)).ToString();
        //    ddlLocalidad_SelectedIndexChanged(null, null);
        //}

        [WebMethod]
        public static string verificarNroDocumento(int dni)
        {
            string mensaje = string.Empty;
            int idPaciente = 0;

            DataTable dtpac = DalSic.SPs.GetPacientesPorDocumento(dni).GetDataSet().Tables[0];

            if (dtpac.Rows.Count > 0)
            {
                idPaciente = int.Parse(dtpac.Rows[0][0].ToString());

                mensaje = "El Paciente ya fue ingresado! Si quiere actualizar sus datos; salga de esta pantalla; busque el mismo y seleccione Editar.";
            }

            return mensaje;
        }

        public class ObSocial
        {
            public string obraSocial { get; set; }
            public string baseOrigen { get; set; }
        }

        private DataTable BuscarNumeroDoc(int id)
        {
            DataTable dtd = new DataTable();

            if (id > 0)
            {
                int intParsed;
                if (int.TryParse(txtNumeroDocumento.Text.Trim(), out intParsed))
                {
                    SubSonic.Select td = new SubSonic.Select();
                    td.From(DalSic.SysPaciente.Schema);
                    td.Where(SysPaciente.Columns.IdEstado).IsEqualTo(ddlEstadoP.SelectedValue);
                    td.And(SysPaciente.Columns.NumeroDocumento).IsEqualTo(intParsed);
                    td.And(SysPaciente.Columns.IdPaciente).IsNotEqualTo(id);
                    dtd = td.ExecuteDataSet().Tables[0];
                }
            }

            return dtd;
        }

        [WebMethod]
        public static List<ListItem> llenaDdlMotivoNI(int idEstado)
        {
            string query = "SELECT m.idMotivoNI, m.nombre FROM Sys_MotivoNI M INNER JOIN Sys_RelEstadoMotivoNI RM ON RM.idMotivoNI = m.idMotivoNI WHERE idEstado = " + idEstado;
            string constr = ConfigurationManager.ConnectionStrings["SicConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> customers = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(new ListItem
                            {
                                Value = sdr["idMotivoNI"].ToString(),
                                Text = sdr["nombre"].ToString()
                            });
                        }
                    }
                    con.Close();

                    return customers;
                }
            }
        }


        [WebMethod]
        public static List<ListItem> llenaProvincias()
        {
            string query = "SELECT idProvincia, nombre FROM Sys_Provincia  WHERE idPais = 54 order by nombre";
            string constr = ConfigurationManager.ConnectionStrings["SicConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> Provincias = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            Provincias.Add(new ListItem
                            {
                                Value = sdr["idProvincia"].ToString(),
                                Text = sdr["nombre"].ToString()
                            });
                        }
                    }
                    con.Close();

                    return Provincias;
                }
            }
        }


        [WebMethod]
        public static List<ListItem> llenaDepartamentos(int idProvincia)
        {
            string query = "SELECT idDepartamento, nombre FROM Sys_Departamento WHERE idProvincia =" + idProvincia + " order by nombre";
            string constr = ConfigurationManager.ConnectionStrings["SicConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> Departamentos = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            Departamentos.Add(new ListItem
                            {
                                Value = sdr["idDepartamento"].ToString(),
                                Text = sdr["nombre"].ToString()
                            });
                        }
                    }
                    con.Close();

                    return Departamentos;
                }
            }
        }


        [WebMethod]
        public static List<ListItem> llenaLocalidades(int idDepartamento)
        {
            string query = "SELECT idLocalidad, nombre FROM Sys_Localidad WHERE idDepartamento =" + idDepartamento + " order by nombre";
            string constr = ConfigurationManager.ConnectionStrings["SicConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> Localidades = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            Localidades.Add(new ListItem
                            {
                                Value = sdr["idLocalidad"].ToString(),
                                Text = sdr["nombre"].ToString()
                            });
                        }
                    }
                    con.Close();

                    return Localidades;
                }
            }
        }

        [WebMethod]
        public static List<ListItem> llenaBarrios(int idLocalidad)
        {
            string query = "SELECT idBarrio, nombre FROM Sys_Barrio WHERE idLocalidad =" + idLocalidad + " order by nombre";
            string constr = ConfigurationManager.ConnectionStrings["SicConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> Barrios = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            Barrios.Add(new ListItem
                            {
                                Value = sdr["idBarrio"].ToString(),
                                Text = sdr["nombre"].ToString()
                            });
                        }
                    }
                    con.Close();

                    return Barrios;
                }
            }
        }


        protected void btnGuardarRem_Click(object sender, EventArgs e)
        {
            btnGuardar_Click(sender, e);
            if (txtNumeroDocumento.Text.Trim().Length > 0)
                Response.Redirect("~/RemediarRedes/Preclasificacion/Editar.aspx?dni=" + txtNumeroDocumento.Text.Trim());
            else
                Response.Redirect("~/RemediarRedes/Preclasificacion/Editar.aspx");

        }

        protected void btnGuardarClasif_Click(object sender, EventArgs e)
        {
            btnGuardar_Click(sender, e);
            if (txtNumeroDocumento.Text.Trim().Length > 0)
                Response.Redirect("~/Clasificacion/Buscar.aspx?dni=" + txtNumeroDocumento.Text.Trim());
            else
                Response.Redirect("~/Clasificacion/Buscar.aspx");
        }

        protected void btnGuardarCP_Click(object sender, EventArgs e)
        {
            btnGuardar_Click(sender, e);
            if (txtNumeroDocumento.Text.Trim().Length > 0)
                Response.Redirect("~/ConsultaAmbulatoria/BuscarEmbarazada.aspx?dni=" + txtNumeroDocumento.Text.Trim());
            else
                Response.Redirect("~/ConsultaAmbulatoria/BuscarEmbarazada.aspx");
        }

        protected void btnGuardarCM_Click(object sender, EventArgs e)
        {
            btnGuardar_Click(sender, e);
            if (txtNumeroDocumento.Text.Trim().Length > 0)
                Response.Redirect("~/ConsultaAmbulatoria/BuscarMenor.aspx?dni=" + txtNumeroDocumento.Text.Trim());
            else
                Response.Redirect("~/ConsultaAmbulatoria/BuscarMenor.aspx");
        }

        private int CalcularEdad()
        {
            DateTime fec = Convert.ToDateTime("01/01/1900");
            DateTime.TryParse(txtFechaNac.Text, out fec);
            if ((fec > DateTime.Now) && (txtFechaNac.Text == ""))
            {
                return -1;
            }
            else
            {
                int edad = DateTime.Now.Year - fec.Year;
                DateTime nacimientoEsteAnio = fec.AddYears(edad);
                if (DateTime.Now.CompareTo(nacimientoEsteAnio) < 0)
                {
                    edad--;
                }
                return edad;
            }
        }

        public void cargarPaciente(int id)
        {
            DalSic.SysPaciente pac = new DalSic.SysPaciente(id);

            string nombreUsuario = string.Empty;

            if (SSOHelper.FindUser(pac.IdUsuario) != null)
                lblDatosUltimaModificacion.Text = SSOHelper.FindUser(pac.IdUsuario).Fullname + " - " + pac.FechaUltimaActualizacion.ToString().ToUpper();
            else
                lblDatosUltimaModificacion.Text = "No hay datos de la última modificación!";

            txtNumeroDocumento.Text = pac.NumeroDocumento.ToString();
            int Doc = Convert.ToInt32(txtNumeroDocumento.Text);
            ddlEstadoP.SelectedValue = pac.IdEstado.ToString();
            //ddlMotivoNI.SelectedValue = pac.IdMotivoNI.ToString();
            hdfMotivo.Value = pac.IdMotivoNI.ToString();

            if (pac.IdMotivoNI == 2)
            {
                if (pac.NumeroExtranjero != "")
                {
                    lblExtranjero.Text = "Doc. Extranjero: ";
                    txtNumeroExtranjero.Visible = true;
                    txtNumeroExtranjero.Text = pac.NumeroExtranjero;
                }
            }

            txtApellido.Text = pac.Apellido;
            txtNombre.Text = pac.Nombre;
            ddlSexo.SelectedValue = pac.IdSexo.ToString();
            txtFechaNac.Text = pac.FechaNacimiento.ToShortDateString();
            hlkHClinica.NavigateUrl = "HistoriaClinica/NroHistoriaClinicaEdit.aspx?idPac=" + pac.IdPaciente;

            //NAcionalidad -> Pais
            ddlNacionalidad.SelectedValue = pac.IdPais.ToString();
            ddlNacionalidad_SelectedIndexChanged(null, null);
            //Provincia -> lugar de nacimiento
            ddlProvincia.SelectedValue = pac.IdProvincia.ToString();
            // OSociales.setOS(pac.IdObraSocial);
            hdfIdObraSocial.Value = pac.IdObraSocial.ToString();
            txtObraSocial.Value = pac.SysObraSocial.Nombre;

            txtTFijo.Text = pac.TelefonoFijo;
            hdfCodigoPaisTelFijo.Value = pac.TelefonoFijo.Split(' ')[0].ToString();

            txtTCelular.Text = pac.TelefonoCelular;
            hdfCodigoPaisCelular.Value = pac.TelefonoCelular.Split(' ')[0].ToString();

            txtEmail.Text = pac.Email;
            //observaciones
            txtContacto.Text = pac.InformacionContacto;
            
            //Información de domicilio
            //Inicializo los combos con los valores del registro seleccionado del paciente existente
            
            if (pac.IdProvinciaDomicilio != 0)
            {
                hdfProvinciaDomicilio.Value = pac.IdProvinciaDomicilio.ToString();
                SubSonic.Select pd = new SubSonic.Select();
                pd.From(SysProvincium.Schema);
                pd.Where(SysProvincium.Columns.IdPais).IsEqualTo(IdArgentina);
                ddlProvinciaDomicilio.DataSource = pd.ExecuteTypedList<SysProvincium>();
                ddlProvinciaDomicilio.DataBind();
                ddlProvinciaDomicilio.SelectedValue = pac.IdProvinciaDomicilio.ToString();
            }
            else
            {
                ddlProvinciaDomicilio.SelectedValue = "-1";
            }

            if (pac.IdDepartamento != 0)
            {
                hdfDepartamento.Value = pac.IdDepartamento.ToString();
                SubSonic.Select pd = new SubSonic.Select();
                pd.From(SysDepartamento.Schema);
                pd.Where(SysDepartamento.Columns.IdProvincia).IsEqualTo(pac.IdProvinciaDomicilio);
                ddlDepartamento.DataSource = pd.ExecuteTypedList<SysDepartamento>();
                ddlDepartamento.DataBind();
                ddlDepartamento.SelectedValue = pac.IdDepartamento.ToString();
            }
            else
            {
                ddlDepartamento.SelectedValue = "-1";
            }

            if (pac.IdLocalidad != 0)
            {
                hdfLocalidad.Value = pac.IdLocalidad.ToString();
                SubSonic.Select pd = new SubSonic.Select();
                pd.From(SysLocalidad.Schema);
                pd.Where(SysLocalidad.Columns.IdLocalidad).IsEqualTo(pac.IdLocalidad);
                ddlLocalidad.DataSource = pd.ExecuteTypedList<SysLocalidad>();
                ddlLocalidad.DataBind();
                ddlLocalidad.SelectedValue = pac.IdLocalidad.ToString();
            }
            else
            {
                ddlLocalidad.SelectedValue = "-1";
            }

            if (pac.IdBarrio != 0)
            {
                hdfBarrio.Value = pac.IdBarrio.ToString();
                SubSonic.Select pd = new SubSonic.Select();
                pd.From(SysBarrio.Schema);
                pd.Where(SysBarrio.Columns.IdBarrio).IsEqualTo(pac.IdBarrio);
                ddlBarrio.DataSource = pd.ExecuteTypedList<SysBarrio>();
                ddlBarrio.DataBind();
                ddlBarrio.SelectedValue = pac.IdBarrio.ToString();
            }
            else
            {
                ddlBarrio.SelectedValue = "-1";
            }


            txtCPostal.Text = pac.SysLocalidad.CodigoPostal.ToString();
            txtOBarrio.Text = pac.OtroBarrio.ToString();
            txtCalle.Text = pac.Calle;
            txtNumero.Text = Convert.ToString(pac.Numero);
            txtEdificio.Text = pac.Edificio;
            txtPiso.Text = pac.Piso;
            txtDepartamento.Text = pac.Departamento;
            txtManzana.Text = pac.Manzana;

            switch (pac.EsUrbano)
            {
                case false:
                    rbtUrbano.Checked = false;
                    hdfUrbano.Value = "false";
                    //lblRural.CssClass = "btn btn-info active";
                    break;
                case true:
                    rbtUrbano.Checked = true;
                    hdfUrbano.Value = "true";
                    //lblUrbano.CssClass = "btn btn-info active";
                    break;
            }

            txtLatitud.Text = pac.Latitud;
            txtLongitud.Text = pac.Longitud;
            txtReferencia.Text = pac.Referencia;
            txtCampo.Text = pac.Campo.ToString();
            txtCamino.Text = pac.Camino.ToString();
            txtLote.Text = pac.Lote.ToString();
            txtParcela.Text = pac.Parcela.ToString();

            //traigo en un label la obra social detectada en la base Padron
            pac.FechaUltimaActualizacion = DateTime.Now;

            //traigo los datos del primer pariente que encuentra
            if (pac.SysParentescoRecords.Count > 0)
            {
                SysParentesco par = pac.SysParentescoRecords[0];
                txtApellidoM.Text = par.Apellido;
                txtNombreM.Text = par.Nombre;
                txtNumeroM.Text = par.NumeroDocumento.ToString();
                if (par.FechaNacimiento.ToShortDateString() == "01/01/1900") txtFNacMadre.Text = "";
                else txtFNacMadre.Text = par.FechaNacimiento.ToShortDateString();
                ddlNacionalidadM.SelectedValue = par.IdPais.ToString();
                ddlLugarNacimientoM.SelectedValue = par.IdProvincia.ToString();
                lblIdParentescoM.Text = par.IdParentesco.ToString();
                par.FechaModificacion = DateTime.Now;
                //datos del padre
                if (pac.SysParentescoRecords.Count > 1)
                {
                    SysParentesco parP = pac.SysParentescoRecords[1];
                    txtApellidoPadre.Text = parP.Apellido;
                    txtNombrePadre.Text = parP.Nombre;
                    txtDUPadre.Text = parP.NumeroDocumento.ToString();
                    if (parP.FechaNacimiento.ToShortDateString() == "01/01/1900") txtFNacPadre.Text = "";
                    else txtFNacPadre.Text = parP.FechaNacimiento.ToShortDateString();
                    ddlNacionalidadP.SelectedValue = parP.IdPais.ToString();
                    ddlLugarNacimientoP.SelectedValue = parP.IdProvincia.ToString();
                    lblIdParentescoP.Text = parP.IdParentesco.ToString();
                    parP.FechaModificacion = DateTime.Now;
                }
            }
        }

        //protected void btnRenaper_Click(object sender, EventArgs e)
        //{
        //    WebProxy myProxy = new WebProxy();
        //    Uri newUri = new Uri("http://10.1.33.254:80");
        //    myProxy.Address = newUri;
        //    myProxy.Credentials = new NetworkCredential("nacer", "mder633");

        //    try
        //    {
        //        ////Posibles ObrasSociales según padrón.
        //        if (txtNumeroDocumento.Text.Length > 0)
        //        {
        //            //Acceso al webService de Renaper
        //            string userNameRenaper = "bcpintos";
        //            string passwordRenaper = "*123456";
        //            string s_urlWFC = ConfigurationManager.AppSettings["Renaper_WebService"].ToString();
        //            string s_url = s_urlWFC + "?nrodoc=" + txtNumeroDocumento.Text + "&usuario=" + userNameRenaper + "&clave=" + passwordRenaper;


        //            WebRequest requestPS = WebRequest.Create(s_url);
        //            requestPS.Proxy = myProxy;
        //            requestPS.Method = "GET";
        //            WebResponse wsPS = requestPS.GetResponse();
        //            Stream stPS = wsPS.GetResponseStream();
        //            StreamReader srPS = new StreamReader(stPS);
        //            var datosPersona = srPS.ReadToEnd();

        //            XDocument doc1;
        //            using (StringReader s = new StringReader(datosPersona))
        //            {
        //                doc1 = XDocument.Load(s);
        //            }

        //            DataSet dsresult = new DataSet();

        //            XmlDocument doc = new XmlDocument();
        //            doc.LoadXml(doc1.ToString());

        //            XmlElement exelement = doc.DocumentElement;

        //            if (exelement != null)
        //            {
        //                XmlNodeReader nodereader = new XmlNodeReader(exelement);
        //                dsresult.ReadXml(nodereader, XmlReadMode.Auto);
        //                //GrdPersona.DataSource = dsresult;
        //                //GrdPersona.DataBind();
        //            }

        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //lblErrorRenaper.Visible = true;
        //        //lblErrorRenaper.Text = "No se encuentran datos en Renaper!";
        //    }
        //}
        [WebMethod]
        public static List<Persona> consultaSintys(string dni)
        {
            try
            {
                WebProxy myProxy = new WebProxy();
                Uri newUri = new Uri("http://10.1.33.254:80");
                myProxy.Address = newUri;
                myProxy.Credentials = new NetworkCredential("nacer", "mder633");

                List<Persona> sintys = new List<Persona>();

                if (dni.Length > 0)
                {
                    string s_urlWFC = ConfigurationManager.AppSettings["Sintys_WebService"].ToString();
                    string s_url = s_urlWFC + "/GetPersona?dni=" + dni;

                    //Posibles datos según padrón sintys.
                    //Label2.Text = "Datos obtenidos del Sistema de Identificacion Nacional Tributario y Social (SINTyS) ";
                    WebRequest requestPS = WebRequest.Create(s_url);
                    WebResponse wsPS = requestPS.GetResponse();
                    JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
                    Stream stPS = wsPS.GetResponseStream();
                    StreamReader srPS = new StreamReader(stPS);
                    string sPS = srPS.ReadToEnd();
                    int inicio = sPS.IndexOf("[");
                    int fin = sPS.IndexOf("]") + 1;
                    string aux = sPS.Substring(inicio, fin - inicio);
                    sintys = jsonSerializer.Deserialize<List<Persona>>(aux);
                }

                return sintys;

            }
            catch (Exception ex)
            {

                return null;
            }
        }


        [WebMethod]
        public static List<Persona> consultaRenaper(string dni)
        {
            try
            {
                WebProxy myProxy = new WebProxy();
                Uri newUri = new Uri("http://10.1.33.254:80");
                myProxy.Address = newUri;
                myProxy.Credentials = new NetworkCredential("nacer", "mder633");

                List<Persona> renaper = new List<Persona>();
                //List<ListItem> listaItem = new List<ListItem>();

                if (dni.Length > 0)
                {
                    //Acceso al webService de Renaper
                    string userNameRenaper = "bcpintos";
                    string passwordRenaper = "*123456";
                    string s_urlWFC = ConfigurationManager.AppSettings["Renaper_WebService"].ToString();
                    string s_url = s_urlWFC + "?nrodoc=" + dni.ToString() + "&usuario=" + userNameRenaper + "&clave=" + passwordRenaper;

                    WebRequest requestPS = WebRequest.Create(s_url);
                    requestPS.Proxy = myProxy;
                    requestPS.Method = "GET";
                    WebResponse wsPS = requestPS.GetResponse();
                    Stream stPS = wsPS.GetResponseStream();
                    StreamReader srPS = new StreamReader(stPS);
                    var datosPersona = srPS.ReadToEnd();

                    XDocument doc1;
                    using (StringReader s = new StringReader(datosPersona))
                    {
                        doc1 = XDocument.Load(s);
                    }

                    DataSet dsresult = new DataSet();

                    XmlDocument doc = new XmlDocument();
                    doc.LoadXml(doc1.ToString());

                    XmlElement exelement = doc.DocumentElement;

                    if (exelement != null)
                    {
                        XmlNodeReader nodereader = new XmlNodeReader(exelement);
                        dsresult.ReadXml(nodereader, XmlReadMode.Auto);

                        foreach (DataRow data in dsresult.Tables[0].Rows)
                        {
                            Persona persona = new Persona();

                            persona.Apellido = data["apellido"].ToString();
                            persona.Nombre = data["nombre"].ToString();
                            persona.TipoDocumento = data["tipoDocumento"].ToString();
                            persona.Documento = int.Parse(data["nroDocumento"].ToString());
                            persona.FechaNacimiento = data["fechaNacimiento"].ToString();
                            persona.Sexo = data["sexo"].ToString();


                            renaper.Add(persona);
                        }
                    }
                }

                return renaper;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public class Persona
        {
            public string Apellido { get; set; }
            public string Nombre { get; set; }
            public string NombreCompleto { get; set; }
            public string TipoDocumento { get; set; }
            public int Documento { get; set; }

            public string FechaNacimiento { get; set; }
            public string Sexo { get; set; }
        }


        //protected void btnPadronPcial_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        ////Posibles ObrasSociales según padrón.
        //        if (txtNumeroDocumento.Text.Length > 0)
        //        {
        //            PacienteProvincial.Visible = true;
        //            bool h = PacienteProvincial.MostrarDatos(txtNumeroDocumento.Text);
        //            btnCopiarTodo.Visible = h;
        //            if (hayDatosMadre()) btnCopiarMadre.Visible = h;
        //            if (hayDatosPadre())
        //                btnCopiarPadre.Visible = h;
        //            btnCopiarDomicilio.Visible = h;
        //            btnCopiarDatosPrincipales.Visible = h;
        //            btnCopiarProgenitor.Visible = h;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Poner la logica de error                
        //        throw;
        //    }

        //}

        private bool hayDatosPadre()
        {
            string datos = PacienteProvincial.TraerDatosPadre();
            string[] oDatos = datos.Split(';');

            if ((oDatos[0].ToString() == "") && (oDatos[1].ToString() == "") && (oDatos[2].ToString() == "") && (oDatos[3].ToString() == ""))
                return false;
            else return true;
        }

        private bool hayDatosMadre()
        {

            string datos = PacienteProvincial.TraerDatosMadre();
            string[] oDatos = datos.Split(';');

            if ((oDatos[0].ToString() == "") && (oDatos[1].ToString() == "") && (oDatos[2].ToString() == "") && (oDatos[3].ToString() == ""))
                return false;
            else return true;
        }

        protected void btnCopiarTodo_Click(object sender, EventArgs e)
        {
            CopiarDatosPrincipales();
            CopiarDomicilio();
            CopiarMadre();
            CopiarPadre();
        }

        protected void btnCopiarDatosPrincipales_Click(object sender, EventArgs e)
        {
            CopiarDatosPrincipales();
        }

        private void CopiarDatosPrincipales()
        {
            string datos = PacienteProvincial.TraerDatosPrincipales();
            string[] oDatos = datos.Split(';');
            txtNumeroDocumento.Text = oDatos[0].ToString();
            txtApellido.Text = oDatos[1].ToString();
            txtNombre.Text = oDatos[2].ToString();

            ddlSexo.SelectedValue = oDatos[3].ToString();
            txtFechaNac.Text = oDatos[4].ToString();
            if (oDatos[5].ToString() != "0")
            {
                ddlNacionalidad.SelectedValue = oDatos[5].ToString(); CargarProvincia();
            }
            if (oDatos[6].ToString() != "0") ddlProvincia.SelectedValue = oDatos[6].ToString();

            //txtObraSocial.Value = oDatos[7].ToString();
            txtObraSocial.Value = oDatos[13].ToString();
            hdfIdObraSocial.Value = oDatos[7].ToString();

            txtTFijo.Text = oDatos[8].ToString();
            txtTCelular.Text = oDatos[9].ToString();
            txtEmail.Text = oDatos[10].ToString();
            txtContacto.Text = oDatos[11].ToString();
            //txtDefuncion.Text = oDatos[12].ToString();
        }
        protected void btnCopiarDomicilio_Click(object sender, EventArgs e)
        {
            CopiarDomicilio();
        }

        private void CopiarDomicilio()
        {
            string datos = PacienteProvincial.TraerDomicilio();
            string[] oDatos = datos.Split(';');

            if (oDatos[0].ToString() != "0")
            { ddlProvinciaDomicilio.SelectedValue = oDatos[0].ToString(); }
            if (oDatos[1].ToString() != "0")
            { CargarDepartamento(); ddlDepartamento.SelectedValue = oDatos[1].ToString(); }
            if ((oDatos[2].ToString() != "0") || (oDatos[2].ToString() != ""))
            {
              //  CargarLocalidad(); ddlLocalidad.SelectedValue = oDatos[2].ToString();
            }

            txtCPostal.Text = oDatos[3].ToString();
            if (oDatos[4].ToString() != "0")
            {
                //CargarBarrio();
                ddlBarrio.SelectedValue = oDatos[4].ToString();
            }

            txtOBarrio.Text = oDatos[5].ToString();
            txtCalle.Text = oDatos[6].ToString();
            if (oDatos[7].ToString() == "")
                txtNumero.Text = "0";
            else txtNumero.Text = oDatos[7].ToString();
            txtEdificio.Text = oDatos[8].ToString();
            txtPiso.Text = oDatos[9].ToString();
            txtDepartamento.Text = oDatos[10].ToString();
            txtManzana.Text = oDatos[11].ToString();
            txtReferencia.Text = oDatos[12].ToString();

            if (oDatos[13].ToString() == "Urbano")
                rbtUrbano.Checked = true;
            else
                rbtUrbano.Checked = false;

            txtLatitud.Text = oDatos[14].ToString();
            txtLongitud.Text = oDatos[15].ToString();
            txtCampo.Text = oDatos[16].ToString();
            txtCamino.Text = oDatos[17].ToString();
            txtLote.Text = oDatos[18].ToString();
            txtParcela.Text = oDatos[19].ToString();
        }

        protected void btnCopiarProgenitor_Click(object sender, EventArgs e)
        {
            CopiarMadre();
            CopiarPadre();
        }

        protected void btnCopiarMadre_Click(object sender, EventArgs e)
        {
            CopiarMadre();
        }

        private void CopiarMadre()
        {
            string datos = PacienteProvincial.TraerDatosMadre();
            string[] oDatos = datos.Split(';');

            txtNumeroM.Text = oDatos[0].ToString();
            txtApellidoM.Text = oDatos[1].ToString();
            txtNombreM.Text = oDatos[2].ToString();
            txtFNacMadre.Text = oDatos[3].ToString();
            if (oDatos[4].ToString() != "0") ddlNacionalidadM.SelectedValue = oDatos[4].ToString();
            if (oDatos[5].ToString() != "0") ddlLugarNacimientoM.SelectedValue = oDatos[5].ToString();
        }

        protected void btnCopiarPadre_Click(object sender, EventArgs e)
        {
            CopiarPadre();
        }

        private void CopiarPadre()
        {
            string datos = PacienteProvincial.TraerDatosPadre();
            string[] oDatos = datos.Split(';');

            txtDUPadre.Text = oDatos[0].ToString();
            txtApellidoPadre.Text = oDatos[1].ToString();
            txtNombrePadre.Text = oDatos[2].ToString();
            txtFNacPadre.Text = oDatos[3].ToString();
            if (oDatos[4].ToString() != "0") ddlNacionalidadP.SelectedValue = oDatos[4].ToString();
            if (oDatos[5].ToString() != "0") ddlLugarNacimientoP.SelectedValue = oDatos[5].ToString();
        }

        //Por el momento no se esta usando este procedimiento
        protected void imprimeComprobanteSumar()
        {
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

            Response.Redirect("PacienteList.aspx", false);
        }

        public string llenarObrasSociales()
        {
            SysObraSocialCollection obra = new SysObraSocialCollection();
            obra.Load();

            object[] cant = new object[obra.Count];
            int x = 0;

            MyJsonDictionary<String, String> result = null;

            foreach (SysObraSocial data in obra)
            {
                result = new MyJsonDictionary<String, String>();

                result["idObraSocial"] = data.IdObraSocial.ToString();
                result["nombre"] = data.Nombre;
                cant[x] = result;
                x++;
            }

            return JsonConvert.SerializeObject(cant);
        }

        protected void lnkPadronPcial_Click(object sender, EventArgs e)
        {
            try
            {
                ////Posibles ObrasSociales según padrón.
                if (txtNumeroDocumento.Text.Length > 0)
                {
                    PacienteProvincial.Visible = true;
                    bool h = PacienteProvincial.MostrarDatos(txtNumeroDocumento.Text);
                    btnCopiarTodo.Visible = h;
                    if (hayDatosMadre()) btnCopiarMadre.Visible = h;
                    if (hayDatosPadre())
                        btnCopiarPadre.Visible = h;
                    btnCopiarDomicilio.Visible = h;
                    btnCopiarDatosPrincipales.Visible = h;
                    btnCopiarProgenitor.Visible = h;
                }
            }
            catch (Exception ex)
            {
                // Poner la logica de error                
                throw;
            }
        }
    }
}