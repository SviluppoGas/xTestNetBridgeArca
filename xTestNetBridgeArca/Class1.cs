using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xTestNetBridgeArca
{
    public class Programma
    {

        public async Task<string> HelloWorldAsync()
        {
            await Task.Delay(1);
            return "Hello from async!";
        }

        public string HelloWorldAsync4VFP()
        {
            var retCall = HelloWorldAsync();
            retCall.Wait();
            return retCall.Result;
        }

    }
}
