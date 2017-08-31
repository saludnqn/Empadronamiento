using System; 
using System.Text; 
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration; 
using System.Xml; 
using System.Xml.Serialization;
using SubSonic; 
using SubSonic.Utilities;
namespace DalSic
{
	/// <summary>
	/// Strongly-typed collection for the PnNomencladorXPatologium class.
	/// </summary>
    [Serializable]
	public partial class PnNomencladorXPatologiumCollection : ActiveList<PnNomencladorXPatologium, PnNomencladorXPatologiumCollection>
	{	   
		public PnNomencladorXPatologiumCollection() {}
        
        /// <summary>
		/// Filters an existing collection based on the set criteria. This is an in-memory filter
		/// Thanks to developingchris for this!
        /// </summary>
        /// <returns>PnNomencladorXPatologiumCollection</returns>
		public PnNomencladorXPatologiumCollection Filter()
        {
            for (int i = this.Count - 1; i > -1; i--)
            {
                PnNomencladorXPatologium o = this[i];
                foreach (SubSonic.Where w in this.wheres)
                {
                    bool remove = false;
                    System.Reflection.PropertyInfo pi = o.GetType().GetProperty(w.ColumnName);
                    if (pi.CanRead)
                    {
                        object val = pi.GetValue(o, null);
                        switch (w.Comparison)
                        {
                            case SubSonic.Comparison.Equals:
                                if (!val.Equals(w.ParameterValue))
                                {
                                    remove = true;
                                }
                                break;
                        }
                    }
                    if (remove)
                    {
                        this.Remove(o);
                        break;
                    }
                }
            }
            return this;
        }
		
		
	}
	/// <summary>
	/// This is an ActiveRecord class which wraps the PN_NomencladorXPatologia table.
	/// </summary>
	[Serializable]
	public partial class PnNomencladorXPatologium : ActiveRecord<PnNomencladorXPatologium>, IActiveRecord
	{
		#region .ctors and Default Settings
		
		public PnNomencladorXPatologium()
		{
		  SetSQLProps();
		  InitSetDefaults();
		  MarkNew();
		}
		
		private void InitSetDefaults() { SetDefaults(); }
		
		public PnNomencladorXPatologium(bool useDatabaseDefaults)
		{
			SetSQLProps();
			if(useDatabaseDefaults)
				ForceDefaults();
			MarkNew();
		}
        
		public PnNomencladorXPatologium(object keyID)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByKey(keyID);
		}
		 
		public PnNomencladorXPatologium(string columnName, object columnValue)
		{
			SetSQLProps();
			InitSetDefaults();
			LoadByParam(columnName,columnValue);
		}
		
		protected static void SetSQLProps() { GetTableSchema(); }
		
		#endregion
		
		#region Schema and Query Accessor	
		public static Query CreateQuery() { return new Query(Schema); }
		public static TableSchema.Table Schema
		{
			get
			{
				if (BaseSchema == null)
					SetSQLProps();
				return BaseSchema;
			}
		}
		
		private static void GetTableSchema() 
		{
			if(!IsSchemaInitialized)
			{
				//Schema declaration
				TableSchema.Table schema = new TableSchema.Table("PN_NomencladorXPatologia", TableType.Table, DataService.GetInstance("sicProvider"));
				schema.Columns = new TableSchema.TableColumnCollection();
				schema.SchemaName = @"dbo";
				//columns
				
				TableSchema.TableColumn colvarIdNomencladorXPatologia = new TableSchema.TableColumn(schema);
				colvarIdNomencladorXPatologia.ColumnName = "idNomencladorXPatologia";
				colvarIdNomencladorXPatologia.DataType = DbType.Int32;
				colvarIdNomencladorXPatologia.MaxLength = 0;
				colvarIdNomencladorXPatologia.AutoIncrement = true;
				colvarIdNomencladorXPatologia.IsNullable = false;
				colvarIdNomencladorXPatologia.IsPrimaryKey = true;
				colvarIdNomencladorXPatologia.IsForeignKey = false;
				colvarIdNomencladorXPatologia.IsReadOnly = false;
				colvarIdNomencladorXPatologia.DefaultSetting = @"";
				colvarIdNomencladorXPatologia.ForeignKeyTableName = "";
				schema.Columns.Add(colvarIdNomencladorXPatologia);
				
				TableSchema.TableColumn colvarIdNomenclador = new TableSchema.TableColumn(schema);
				colvarIdNomenclador.ColumnName = "idNomenclador";
				colvarIdNomenclador.DataType = DbType.Int32;
				colvarIdNomenclador.MaxLength = 0;
				colvarIdNomenclador.AutoIncrement = false;
				colvarIdNomenclador.IsNullable = true;
				colvarIdNomenclador.IsPrimaryKey = false;
				colvarIdNomenclador.IsForeignKey = true;
				colvarIdNomenclador.IsReadOnly = false;
				colvarIdNomenclador.DefaultSetting = @"";
				
					colvarIdNomenclador.ForeignKeyTableName = "PN_nomenclador";
				schema.Columns.Add(colvarIdNomenclador);
				
				TableSchema.TableColumn colvarIdPatologia = new TableSchema.TableColumn(schema);
				colvarIdPatologia.ColumnName = "idPatologia";
				colvarIdPatologia.DataType = DbType.Int32;
				colvarIdPatologia.MaxLength = 0;
				colvarIdPatologia.AutoIncrement = false;
				colvarIdPatologia.IsNullable = true;
				colvarIdPatologia.IsPrimaryKey = false;
				colvarIdPatologia.IsForeignKey = true;
				colvarIdPatologia.IsReadOnly = false;
				colvarIdPatologia.DefaultSetting = @"";
				
					colvarIdPatologia.ForeignKeyTableName = "PN_patologias";
				schema.Columns.Add(colvarIdPatologia);
				
				BaseSchema = schema;
				//add this schema to the provider
				//so we can query it later
				DataService.Providers["sicProvider"].AddSchema("PN_NomencladorXPatologia",schema);
			}
		}
		#endregion
		
		#region Props
		  
		[XmlAttribute("IdNomencladorXPatologia")]
		[Bindable(true)]
		public int IdNomencladorXPatologia 
		{
			get { return GetColumnValue<int>(Columns.IdNomencladorXPatologia); }
			set { SetColumnValue(Columns.IdNomencladorXPatologia, value); }
		}
		  
		[XmlAttribute("IdNomenclador")]
		[Bindable(true)]
		public int? IdNomenclador 
		{
			get { return GetColumnValue<int?>(Columns.IdNomenclador); }
			set { SetColumnValue(Columns.IdNomenclador, value); }
		}
		  
		[XmlAttribute("IdPatologia")]
		[Bindable(true)]
		public int? IdPatologia 
		{
			get { return GetColumnValue<int?>(Columns.IdPatologia); }
			set { SetColumnValue(Columns.IdPatologia, value); }
		}
		
		#endregion
		
		
			
		
		#region ForeignKey Properties
		
		/// <summary>
		/// Returns a PnNomenclador ActiveRecord object related to this PnNomencladorXPatologium
		/// 
		/// </summary>
		public DalSic.PnNomenclador PnNomenclador
		{
			get { return DalSic.PnNomenclador.FetchByID(this.IdNomenclador); }
			set { SetColumnValue("idNomenclador", value.IdNomenclador); }
		}
		
		
		/// <summary>
		/// Returns a PnPatologia ActiveRecord object related to this PnNomencladorXPatologium
		/// 
		/// </summary>
		public DalSic.PnPatologia PnPatologia
		{
			get { return DalSic.PnPatologia.FetchByID(this.IdPatologia); }
			set { SetColumnValue("idPatologia", value.IdPatologias); }
		}
		
		
		#endregion
		
		
		
		//no ManyToMany tables defined (0)
		
        
        
		#region ObjectDataSource support
		
		
		/// <summary>
		/// Inserts a record, can be used with the Object Data Source
		/// </summary>
		public static void Insert(int? varIdNomenclador,int? varIdPatologia)
		{
			PnNomencladorXPatologium item = new PnNomencladorXPatologium();
			
			item.IdNomenclador = varIdNomenclador;
			
			item.IdPatologia = varIdPatologia;
			
		
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}
		
		/// <summary>
		/// Updates a record, can be used with the Object Data Source
		/// </summary>
		public static void Update(int varIdNomencladorXPatologia,int? varIdNomenclador,int? varIdPatologia)
		{
			PnNomencladorXPatologium item = new PnNomencladorXPatologium();
			
				item.IdNomencladorXPatologia = varIdNomencladorXPatologia;
			
				item.IdNomenclador = varIdNomenclador;
			
				item.IdPatologia = varIdPatologia;
			
			item.IsNew = false;
			if (System.Web.HttpContext.Current != null)
				item.Save(System.Web.HttpContext.Current.User.Identity.Name);
			else
				item.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
		}
		#endregion
        
        
        
        #region Typed Columns
        
        
        public static TableSchema.TableColumn IdNomencladorXPatologiaColumn
        {
            get { return Schema.Columns[0]; }
        }
        
        
        
        public static TableSchema.TableColumn IdNomencladorColumn
        {
            get { return Schema.Columns[1]; }
        }
        
        
        
        public static TableSchema.TableColumn IdPatologiaColumn
        {
            get { return Schema.Columns[2]; }
        }
        
        
        
        #endregion
		#region Columns Struct
		public struct Columns
		{
			 public static string IdNomencladorXPatologia = @"idNomencladorXPatologia";
			 public static string IdNomenclador = @"idNomenclador";
			 public static string IdPatologia = @"idPatologia";
						
		}
		#endregion
		
		#region Update PK Collections
		
        #endregion
    
        #region Deep Save
		
        #endregion
	}
}
