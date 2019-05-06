using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using MySql.Data.MySqlClient;
using System.Data;




public class SqlHandle
{
    private MySqlConnection conn = new MySqlConnection("Server=localhost;Database=m5;Uid=root;Pwd=''");
 
    public DataTable Select(string query)
    {
    
        DataTable table = new DataTable();
        conn.Open();
        MySqlDataAdapter read_adapter = new MySqlDataAdapter(query, conn);
        read_adapter.Fill(table);
        conn.Close();

        return table;
    }
 
}
