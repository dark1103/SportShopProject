using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SportShopProject.Startup))]
namespace SportShopProject
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
