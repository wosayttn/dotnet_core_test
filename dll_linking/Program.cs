using System;
using System.Runtime.InteropServices;

namespace reversepinvokefromthread
{
    class WrapperAPILib
    {
        [DllImport("foo.so")]
        static public extern void foo();
    }

    class Program
    {
        static void Main(string[] args)
        {
            WrapperAPILib.foo();
        }
    }
}
