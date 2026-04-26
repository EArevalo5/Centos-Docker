
#Usar una imagen oficial de .NET para compilar y publicar
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS Build
WORKDIR /app

#Copiar archivos del proyecto
COPY . ./

#Restaurar dependencias
RUN dotnet restore --verbosity detailed

#Compilar y publicar en modo release
RUN dotnet publish -c Release -o /out --verbosity detailed

#Imagen ligera para ejecucion 
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS Runtime
WORKDIR /app

#Copiar la salida de la compilacion 

COPY --from=Build /out ./

#Configurar Variables de entorno 

ENV ASPNETCORE_ENVIRONMENT=Production

ENV ASPNETCORE_URLS=http://+:80

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Exponer el puerto 80 
EXPOSE 80:80

# Comando de inicio


ENTRYPOINT ["dotnet", "aplicacionFronend.dll"]


