﻿using System.Collections.Immutable;
using Microsoft.AspNetCore.Mvc;
using my_life_api.Models;

namespace my_life_api.Configurations
{
    public enum DefaultApiErrorsEnum
    {
        NotRegistered,
        EmptyBody,
        FieldIsRequired
    }
    public static class CustomApiConfigurations
    {
        public static readonly ImmutableList<DefaultApiErrorType> errorTypes = ImmutableList.Create(
            new DefaultApiErrorType(DefaultApiErrorsEnum.EmptyBody, "A non-empty request body is required."),
            new DefaultApiErrorType(DefaultApiErrorsEnum.FieldIsRequired, "field is required.")
        );
        public static void OverrideInvalidModels(ApiBehaviorOptions options)
        {
            options.InvalidModelStateResponseFactory = context =>
            {
                // Formata os erros
                IEnumerable<string> errors = context.ModelState
                    .Where(mse => mse.Value.Errors.Count > 0)
                    .SelectMany(mse => mse.Value
                        .Errors.Select(e => e.ErrorMessage)
                    );

                DefaultApiErrorType error = errorTypes
                    .FirstOrDefault(et =>
                        errors.Any(e => e.Contains(et.message))
                    ) ?? new DefaultApiErrorType(DefaultApiErrorsEnum.NotRegistered, "");

                switch (error.type)
                {
                    // Continua a execução do código validando o campo específico no local devido
                    case DefaultApiErrorsEnum.FieldIsRequired:
                        return null;

                    case DefaultApiErrorsEnum.EmptyBody:
                        return new CustomResult(400, "O corpo da requisição não foi enviado.");

                    default:
                        return new CustomResult(
                            400, 
                            "Ocorreu um erro de validação não registrado, verifique os dados enviados e tente novamente."
                        );
                }        
            };
        }
    }
}
