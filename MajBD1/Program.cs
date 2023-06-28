using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MajBD1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Mode connecté
            //var cnx = new SqlConnection();
            //cnx.ConnectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=BD1;Integrated Security=true";
            //cnx.Open();

            //var cmd = new SqlCommand();
            //cmd.Connection = cnx;
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.CommandText = "Pilote_MAJ";
            //cmd.Parameters.Add(new SqlParameter("id", 2));
            //cmd.Parameters.Add(new SqlParameter("nouveauPrenom", "Martine"));
            //cmd.ExecuteNonQuery();

            // Mode déconnecté
            var cnx = new SqlConnection();
            cnx.ConnectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=BD1;Integrated Security=true";
            cnx.Open();

            var cmd = new SqlCommand();
            cmd.Connection = cnx;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from Pilote";

            var da = new SqlDataAdapter(cmd);
            var cb = new SqlCommandBuilder(da);
            var ds = new DataSet();
            da.Fill(ds); // Déconnexion
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (dr.Field<long>("idPilote")==2)
                {
                    dr["Prenom"]= "Justine";
                }
            }
            da.Update(ds); // reconnexion
        }
    }
}
