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
namespace DalSic{
    /// <summary>
    /// Strongly-typed collection for the ConCantidadTurnosPresente class.
    /// </summary>
    [Serializable]
    public partial class ConCantidadTurnosPresenteCollection : ReadOnlyList<ConCantidadTurnosPresente, ConCantidadTurnosPresenteCollection>
    {        
        public ConCantidadTurnosPresenteCollection() {}
    }
    /// <summary>
    /// This is  Read-only wrapper class for the CON_CantidadTurnosPresentes view.
    /// </summary>
    [Serializable]
    public partial class ConCantidadTurnosPresente : ReadOnlyRecord<ConCantidadTurnosPresente>, IReadOnlyRecord
    {
    
	    #region Default Settings
	    protected static void SetSQLProps() 
	    {
		    GetTableSchema();
	    }
	    #endregion
        #region Schema Accessor
	    public static TableSchema.Table Schema
        {
            get
            {
                if (BaseSchema == null)
                {
                    SetSQLProps();
                }
                return BaseSchema;
            }
        }
    	
        private static void GetTableSchema() 
        {
            if(!IsSchemaInitialized)
            {
                //Schema declaration
                TableSchema.Table schema = new TableSchema.Table("CON_CantidadTurnosPresentes", TableType.View, DataService.GetInstance("sicProvider"));
                schema.Columns = new TableSchema.TableColumnCollection();
                schema.SchemaName = @"dbo";
                //columns
                
                TableSchema.TableColumn colvarCantidad = new TableSchema.TableColumn(schema);
                colvarCantidad.ColumnName = "cantidad";
                colvarCantidad.DataType = DbType.Int32;
                colvarCantidad.MaxLength = 0;
                colvarCantidad.AutoIncrement = false;
                colvarCantidad.IsNullable = true;
                colvarCantidad.IsPrimaryKey = false;
                colvarCantidad.IsForeignKey = false;
                colvarCantidad.IsReadOnly = false;
                
                schema.Columns.Add(colvarCantidad);
                
                TableSchema.TableColumn colvarIdAgenda = new TableSchema.TableColumn(schema);
                colvarIdAgenda.ColumnName = "idAgenda";
                colvarIdAgenda.DataType = DbType.Int32;
                colvarIdAgenda.MaxLength = 0;
                colvarIdAgenda.AutoIncrement = false;
                colvarIdAgenda.IsNullable = false;
                colvarIdAgenda.IsPrimaryKey = false;
                colvarIdAgenda.IsForeignKey = false;
                colvarIdAgenda.IsReadOnly = false;
                
                schema.Columns.Add(colvarIdAgenda);
                
                
                BaseSchema = schema;
                //add this schema to the provider
                //so we can query it later
                DataService.Providers["sicProvider"].AddSchema("CON_CantidadTurnosPresentes",schema);
            }
        }
        #endregion
        
        #region Query Accessor
	    public static Query CreateQuery()
	    {
		    return new Query(Schema);
	    }
	    #endregion
	    
	    #region .ctors
	    public ConCantidadTurnosPresente()
	    {
            SetSQLProps();
            SetDefaults();
            MarkNew();
        }
        public ConCantidadTurnosPresente(bool useDatabaseDefaults)
	    {
		    SetSQLProps();
		    if(useDatabaseDefaults)
		    {
				ForceDefaults();
			}
			MarkNew();
	    }
	    
	    public ConCantidadTurnosPresente(object keyID)
	    {
		    SetSQLProps();
		    LoadByKey(keyID);
	    }
    	 
	    public ConCantidadTurnosPresente(string columnName, object columnValue)
        {
            SetSQLProps();
            LoadByParam(columnName,columnValue);
        }
        
	    #endregion
	    
	    #region Props
	    
          
        [XmlAttribute("Cantidad")]
        [Bindable(true)]
        public int? Cantidad 
	    {
		    get
		    {
			    return GetColumnValue<int?>("cantidad");
		    }
            set 
		    {
			    SetColumnValue("cantidad", value);
            }
        }
	      
        [XmlAttribute("IdAgenda")]
        [Bindable(true)]
        public int IdAgenda 
	    {
		    get
		    {
			    return GetColumnValue<int>("idAgenda");
		    }
            set 
		    {
			    SetColumnValue("idAgenda", value);
            }
        }
	    
	    #endregion
    
	    #region Columns Struct
	    public struct Columns
	    {
		    
		    
            public static string Cantidad = @"cantidad";
            
            public static string IdAgenda = @"idAgenda";
            
	    }
	    #endregion
	    
	    
	    #region IAbstractRecord Members
        public new CT GetColumnValue<CT>(string columnName) {
            return base.GetColumnValue<CT>(columnName);
        }
        public object GetColumnValue(string columnName) {
            return base.GetColumnValue<object>(columnName);
        }
        #endregion
	    
    }
}
