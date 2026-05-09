FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "QuijanoLibraryNowAPI/QuijanoLibraryNowAPI.csproj"
RUN dotnet build "QuijanoLibraryNowAPI/QuijanoLibraryNowAPI.csproj" -c Release -o /app/out

FROM base AS final
WORKDIR "/src/QuijanoLibraryNowAPI"
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "QuijanoLibraryNowAPI.dll"]
