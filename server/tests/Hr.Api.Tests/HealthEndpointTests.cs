using FluentAssertions;
using Microsoft.AspNetCore.Mvc.Testing;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;

namespace Hr.Api.Tests;

public class HealthEndpointTests
{
    [Fact]
    public async Task Health_Returns_Ok()
    {
        await using var app = new WebApplicationFactory<Program>();
        var client = app.CreateClient();
        var res = await client.GetAsync("/health");
        res.StatusCode.Should().Be(HttpStatusCode.OK);
        var json = await res.Content.ReadAsStringAsync();
        using var doc = JsonDocument.Parse(json);
        doc.RootElement.GetProperty("status").GetString().Should().Be("ok");
    }
}