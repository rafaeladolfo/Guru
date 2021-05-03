using System;
using GuruApi.Model;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;

namespace GuruApi.Services
{
    public class StoriesService : IStoriesService
    {
        public StoriesService()
        {
        }

        public Stories GetStories()
        {
            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                WriteIndented = true
            };

            var jsonString = File.ReadAllText("stories.json");
            var jsonModel = JsonSerializer.Deserialize<Stories>(jsonString, options);
            return jsonModel;
        }
    }
}
