Content-Type: multipart/mixed; boundary="===============4539081794167686882=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 13:40:06 -0800
Message-ID: <edfc2d19d13d985a1f842eac6ddbba2cb9f5a968.camel@gmail.com>
In-Reply-To: CAA=hcWTJ7ro79eEUw+YP4AVi0cMViuVFc0Vj=KvjxQxEFiN3xg@mail.gmail.com

--===============4539081794167686882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-12-01 at 08:29 +1100, Jupiter wrote:
> Hi James,
> =

> Thanks for your kind response and debug instructions.
> =

> > Without any debug logs this gonna be difficult to see whats going
> > on.
> > If you could enable debug logging when starting IWD and capture
> > some
> > logs that would give us a better idea of whats going on.
> > =

> > https://iwd.wiki.kernel.org/debugging
> =

> Here is debugging:
> =

> # /usr/libexec/iwd -d 'station*' > iwd.log
> =

> $ sed -E "s/([0-9a-fA-F]{2}:?){6}/11:22:33:44:55:66/" iwd.log | sed -
> e
> "s/SSID:\ .*, f/SSID: xxx f/" | sed 's/Added new Network .*
> security/Added new Network "xxx" security/'
> # /usr/libexec/iwd -d 'station*'

So you'll want to actually try connecting with iwctl too. Autoconnect
will only work if you have previously connected successfully, i.e. a
network file exists in /var/lib/iwd.

Try capturing some debug logs once you've done 'station <iface> connect
<network>' in iwctl.

Alternatively you could put a file inside /var/lib/iwd which would let
autoconnect work (though you'll hit the same issue you previously saw
most likely):

/var/lib/iwd/JupiterIoT.psk

[Security]
Passphrase=3D<your passphrase>



Thanks,
James

--===============4539081794167686882==--

