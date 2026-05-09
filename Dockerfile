FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "QuijanoLibraryNowAPI/QuijanoLibraryNowAPI.csproj"
RUN dotnet publish "QuijanoLibraryNowAPI/QuijanoLibraryNowAPI.csproj" -c Release -o /app/out

FROM base AS publish
RUN dotnet publish "QuijanoLibraryNowAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "QuijanoLibraryNowAPI.dll"]
