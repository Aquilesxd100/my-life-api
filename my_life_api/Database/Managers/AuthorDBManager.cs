﻿using System.Data;
using MySql.Data.MySqlClient;
using my_life_api.Models.Requests;
using my_life_api.Models;

namespace my_life_api.Database.Managers
{
    public class AuthorDBManager
    {
        public async Task<int> CreateAuthor(AuthorDTO author)
        {
            await DataBase.OpenConnectionIfClosed();

            string treatedUrlImage = author.urlImagem != null
                ? $"'{author.urlImagem}'"
                : "NULL";

            MySqlCommand myCommand = new MySqlCommand();
            myCommand.Connection = DataBase.connection;

            myCommand.CommandText =
                "Insert Into Authors" +
                    "(name, imageUrl, contentTypeId)" +
                    "Values" +
                        $"('{author.nome}', {treatedUrlImage}, {(int)author.idTipoConteudo});"
                + "Select Last_Insert_Id();";

            var result = await myCommand.ExecuteScalarAsync();
            int authorId = int.Parse(result.ToString());

            await DataBase.CloseConnection();

            return authorId;
        }

        public async Task UpdateAuthor(AuthorDTO author)
        {
            await DataBase.OpenConnectionIfClosed();

            string treatedUrlImage = author.urlImagem != null
                ? $"'{author.urlImagem}'"
                : "NULL";

            MySqlCommand myCommand = new MySqlCommand();
            myCommand.Connection = DataBase.connection;

            myCommand.CommandText =
                "Update Authors " +
                    "Set " +
                        $"name = '{author.nome}'," +
                        $"imageUrl = {treatedUrlImage}," +
                        $"contentTypeId = {(int)author.idTipoConteudo} " +
                $"Where id = {author.id};";

            await myCommand.ExecuteScalarAsync();

            await DataBase.CloseConnection();
        }

        public async Task<AuthorDTO?> GetAuthorById(int authorId)
        {
            await DataBase.OpenConnectionIfClosed();

            MySqlCommand myCommand = new MySqlCommand();
            myCommand.Connection = DataBase.connection;
            myCommand.CommandText = @" Select id, name, imageUrl, contentTypeId " +
                "From Authors " +
                $"Where id = {authorId};";

            AuthorDTO author = null;
            using var myReader = await myCommand.ExecuteReaderAsync();

            while (myReader.Read())
            {
                author = new AuthorDTO()
                {
                    id = myReader.GetInt32("id"),
                    nome = myReader.GetString("name"),
                    urlImagem = myReader.IsDBNull("imageUrl") ? null : myReader.GetString("imageUrl"),
                    idTipoConteudo = (ContentTypesEnum)myReader.GetInt32("contentTypeId"),
                };
            }

            await DataBase.CloseConnection();

            return author;
        }

        public async Task<IEnumerable<AuthorDTO>> GetAuthorsByContentTypeId(int contentTypeId)
        {
            await DataBase.OpenConnectionIfClosed();

            MySqlCommand myCommand = new MySqlCommand();
            myCommand.Connection = DataBase.connection;
            myCommand.CommandText = @" Select id, name, imageUrl, contentTypeId " +
                "From Authors " +
                $"Where contentTypeId = {contentTypeId};";

            List<AuthorDTO> authors = new List<AuthorDTO>();
            using var myReader = await myCommand.ExecuteReaderAsync();

            while (myReader.Read())
            {
                AuthorDTO authorToAdd = new AuthorDTO()
                {
                    id = myReader.GetInt32("id"),
                    nome = myReader.GetString("name"),
                    urlImagem = myReader.IsDBNull("imageUrl") ? null : myReader.GetString("imageUrl"),
                    idTipoConteudo = (ContentTypesEnum)contentTypeId,
                };
                authors.Add(authorToAdd);
            }

            await DataBase.CloseConnection();

            return authors;
        }
    }
}
