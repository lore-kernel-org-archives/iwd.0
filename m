Content-Type: multipart/mixed; boundary="===============1112388903240209171=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test: add a simple signal agent script
Date: Wed, 10 Feb 2021 13:43:25 -0600
Message-ID: <8d02996a-e45a-12d9-6e47-d94e711812c8@gmail.com>
In-Reply-To: <20210210180759.834988-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1112388903240209171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/10/21 12:07 PM, James Prestwood wrote:
> Creates a signal agent and registers for a few levels.
> ---
>   test/signal-agent | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100755 test/signal-agent
> =

> diff --git a/test/signal-agent b/test/signal-agent
> new file mode 100755
> index 00000000..65f16cfd
> --- /dev/null
> +++ b/test/signal-agent
> @@ -0,0 +1,52 @@
> +#!/usr/bin/python3
> +
> +from gi.repository import GLib
> +
> +import dbus
> +import dbus.service
> +import dbus.mainloop.glib
> +import sys
> +import time
> +
> +class SignalAgent(dbus.service.Object):
> +    def __init__(self):
> +        self._bus =3D dbus.SystemBus()
> +        self._path =3D '/test/agent/' + str(int(round(time.time() * 1000=
)))
> +
> +        dbus.service.Object.__init__(self, self._bus, self._path)
> +
> +    @property
> +    def path(self):
> +        return self._path
> +
> +    @dbus.service.method('net.connman.iwd.SignalLevelAgent',
> +                         in_signature=3D'', out_signature=3D'')
> +    def Release(self):
> +        print("SignalAgent released")
> +
> +    @dbus.service.method('net.connman.iwd.SignalLevelAgent',
> +                         in_signature=3D'oy', out_signature=3D'')
> +    def Changed(self, path, level):
> +        self.handle_new_level(str(path), int(level))
> +
> +    def handle_new_level(self, path, level):
> +        print("New signal level %d" % level)
> +
> +if __name__ =3D=3D '__main__':
> +    if len(sys.argv) < 2:
> +        print("Usage: %s <device path>" % sys.argv[0])
> +        quit()

Can we optionally pass the ranges on the command line?

> +
> +    dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +
> +    bus =3D dbus.SystemBus()
> +    agent =3D SignalAgent()
> +
> +    station_if =3D dbus.Interface(bus.get_object('net.connman.iwd', sys.=
argv[1]),
> +                                            'net.connman.iwd.Station')
> +    station_if.RegisterSignalLevelAgent(agent.path,
> +                                        dbus.Array([-70, -75, -80], 'n'))

Maybe use the same ranges we use in iwctl by default?

> +
> +    mainloop =3D GLib.MainLoop()
> +    mainloop.run()
> +
> =


Regards,
-Denis
--===============1112388903240209171==--

