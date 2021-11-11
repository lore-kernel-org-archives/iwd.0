Content-Type: multipart/mixed; boundary="===============5066388056186147287=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 8/9] autotests: Test DHCPv6 client in testNetconfig
Date: Thu, 11 Nov 2021 06:27:48 +0100
Message-ID: <CAOq732+VA6+jV-LvVA9bmWhLZ914r_bfbfgAupRZpdFek69xfQ@mail.gmail.com>
In-Reply-To: e1bd9310-0aba-b205-9a52-a1d9f5d5f187@gmail.com

--===============5066388056186147287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 10 Nov 2021 at 16:37, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 11/8/21 5:28 AM, Andrew Zaborowski wrote:
> >   autotests/testNetconfig/connection_test.py | 34 ++++++++++++++++++++--
> >   autotests/testNetconfig/dhcpd-v6.conf      |  6 ++++
> >   autotests/testNetconfig/main.conf          |  3 ++
> >   3 files changed, 40 insertions(+), 3 deletions(-)
> >   create mode 100644 autotests/testNetconfig/dhcpd-v6.conf
> >
>
> I went ahead and applied this, but see below.  I also added a small fix
> afterwards to specify radvd pid file since radvd was refusing to start on=
 my
> setup (and the test was failing).

Thanks for fixing this.

>
> <snip>
>
> > @@ -39,6 +39,10 @@ class Test(unittest.TestCase):
> >           testutil.test_iface_operstate()
> >           testutil.test_ifaces_connected()
> >
> > +        time.sleep(2)
>
> Using time.sleep() isn't a great idea since the timing can be quite varia=
ble.
> Especially if qemu is running inside the VM (like the setup I have for ex=
ample).
>   In general, just forget that sleep() exists and listen for the right ev=
ents.

Right, it took me some effort to force myself to use it ;) but writing
the code to listen for rtnl events in the test didn't seem worthwhile.
I tested this in qemu without acceleration which is likely slower than
nested VMs but using acceleration.  And the time saving here would be
about 1s.

>
> > +        ret =3D os.system('ip addr show ' + device.name + ' | grep \'i=
net6 3ffe:501:ffff:100::\'')
> > +        self.assertEqual(os.waitstatus_to_exitcode(ret), 0)
> > +
>
> Note that os.waitstatus_to_exitcode is a python 3.9 feature.  I updated t=
he docs
> to reflect that.

Good catch, too.

Best regards
--===============5066388056186147287==--

