Content-Type: multipart/mixed; boundary="===============0706791385585286983=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: connman integration
Date: Wed, 03 Jun 2020 23:34:55 -0500
Message-ID: <e5cd5ffc-bf19-657d-5e99-bd12a1dd7f44@gmail.com>
In-Reply-To: <CAG17S_PvAatbLoaygU-fRsvCE+YDKHuDh9w9d8X54e7+Kv6Okg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0706791385585286983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 6/3/20 12:01 PM, KeithG wrote:

<snip>

> Scanning is supported with iwd. connmanctl scan is probably waiting for i=
wd
> to respond with the scanning=3D0 signal. If iwd doesn't send out this sig=
nal
> then this will hang.

This should be easy to check via dbus-monitor or the test/monitor-iwd =

script in iwd.git.

For example, here's one from my test box when I run 'iwctl station wlan0 =

scan'

denkenz(a)iwd-test ~/iwd $ test/monitor-iwd
{Station} [/net/connman/iwd/0/5] Scanning =3D True
{Station} [/net/connman/iwd/0/5] Scanning =3D False

So the scanning property is emitted correctly...

Regards,
-Denis
--===============0706791385585286983==--

