using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Vols
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //CreationDonnees();
            //Fonction qui récupère le pilote sur un vol
            var id = 141;
            var context = new BD();
            var vol = context.Vol.Where(v => v.idVol == id).FirstOrDefault();
            if (vol == null) { return; }
            var idPilote = vol.idPilote;
            var pilote = context.Pilote.Where(p => p.idPilote == idPilote).ToList();

            //Console.WriteLine(pilote[0].Nom + " " + pilote[0].Prenom);
            //Console.ReadLine();

            //Fonction qui récupère Pilotes ayant opéré pour compagnie (donné en paramètre)

            var compagnie = "Air France";
            var volsAF = context.Vol.Where(v => v.Avion.Compagnie == compagnie).ToList();
            foreach(Vol v in volsAF)
            {
                //Console.WriteLine(v.Pilote.Nom + " " + v.Pilote.Prenom);
            }

            //Fonction qui donne tous les vols avec nom pilote et modele de l'avion qui ont pour Depart l'argument

            var depart = "Lyon";
            var volsLyon = context.Vol.Where(v => v.LieuDepart == depart).ToList();
            foreach(Vol v in volsLyon)
            {
                Console.WriteLine("Le vol " + v.idVol + " ayant pour modele " + v.Avion.Modele +
                    " a été piloté par " + v.Pilote.Nom + " " + v.Pilote.Prenom);
            }
            Console.ReadLine();
            context.SaveChanges();
        }

        static void CreationDonnees()
        {
            var cnx = new SqlConnection();
            cnx.ConnectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=BD1;Integrated Security=True";
            cnx.Open();

            var cmd = new SqlCommand();
            cmd.Connection = cnx;
            cmd.CommandType = System.Data.CommandType.Text;
            Random random = new Random();
            /*
            String[] modeles = new string[5] { "A380", "BELUGAXL", "Boeing 747", "Boeing VC-25A", "A320" };
            String[] compagnies = new string[6] { "Air France", "Air Transat", "Ryanair", "EasyJet", "Emirates", "Air Mali" };

            foreach (int value in Enumerable.Range(1, 20))
            {
                int modele = random.Next(0, modeles.Length - 1);
                int compagnie = random.Next(0, compagnies.Length - 1);
                cmd.CommandText = @"INSERT INTO Avion (Modele,Compagnie)
                    values ('" + modeles[modele] + "','"+compagnies[compagnie]+"')";
                cmd.ExecuteNonQuery();
            }

            String[] noms = new string[5] { "A", "B", "C", "D", "E" };
            String[] prenoms = new string[6] { "Marc", "Henri", "Rayane", "Michel", "Justine", "Mike" };

            foreach (int value in Enumerable.Range(1, 5))
            {
                int nom = random.Next(0, noms.Length - 1);
                int prenom = random.Next(0, prenoms.Length - 1);
                DateTime start = new DateTime(1985, 1, 1);
                TimeSpan range = (DateTime.Now - start);
                DateTime dateNaissance = start.AddHours(random.Next((int)range.TotalHours));
                cmd.CommandText = @"INSERT INTO Pilote (Nom,Prenom,DateNaissance)
                    values ('" + noms[nom] + "','" + prenoms[prenom] + "','" + dateNaissance +"')";
                cmd.ExecuteNonQuery();
            }
            */
            String[] departs = new string[6] { "Lyon", "Paris", "Marseille", "Tokyo", "New York", "Alger" };
            foreach (int value in Enumerable.Range(1, 100))
            {
                DateTime start = new DateTime(1995, 1, 1);
                TimeSpan range = (DateTime.Now - start);
                DateTime dateDepart = start.AddHours(random.Next((int)range.TotalHours));
                range = (DateTime.Now - dateDepart);
                DateTime dateArrivee = dateDepart.AddHours(random.Next(1, 10));
                int avion = random.Next(1, 20);
                int pilote = random.Next(2, 6);
                int lieuDepart = random.Next(0, departs.Length - 1);
                int lieuArrivee = random.Next(0, departs.Length - 1);
                cmd.CommandText = @"INSERT INTO Vol (DateDepart,DateArrivee,idAvion,idPilote,LieuDepart,LieuArrivee)
                    values ('" + dateDepart + "','" + dateArrivee + "'," + avion + " , " +
                        pilote + ", '" + departs[lieuDepart] + "', '" + departs[lieuArrivee] + "')";
                //INSERT INTO Vol (DateDepart,DateArrivee,idAvion,idPilote,LieuDepart,LieuArrivee)
                // values ('1/1/1995', '2/1/1995', 2, 4, 'Lyon', 'Paris')
                cmd.ExecuteNonQuery();
            }
        }
    }
}
