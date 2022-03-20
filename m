Content-Type: multipart/mixed; boundary="===============1497526819619073906=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] test-runner: increase RAM size
Date: Sat, 19 Mar 2022 19:26:39 -0700
Message-ID: <3487e5393b77fde3846406d5f704b17c74f7cf1c.camel@gmail.com>
In-Reply-To: d454c143-cc4d-a4bb-3bd8-72e97b8e466e@molgen.mpg.de

--===============1497526819619073906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, 2022-03-19 at 06:12 +0100, Paul Menzel wrote:
> Dear James,
> =

> =

> Am 18.03.22 um 23:36 schrieb James Prestwood:
> > This is explained in the comment, but until the issue can be
> > tracked down increase RAM.
> =

> Before it was distinguished if run under Valgrind or not. It=E2=80=99s
> running =

> out of memory regardless of that now?

I think you're referring to the --valgrind option? This runs valgrind
on IWD. The issue here is the entire kernel/system is running out of
memory which is not a leak from IWD itself but some other test process.

> =

> The comment says, the reason is unclear, but could you document the
> test =

> setup (QEMU, Linux version, compiler) of the last successful run, and
> the parameters of the first failure?

Yeah, I can explain this further in the commit. But basically any full
test run exibits this behavior. Usually about 20-25 tests and it OOM's.

I've tried digging into this a few times and come up with nothing. As
the tests execute the kernels available memory continues to go down.
This memory does get reclaimed for some time and will bounce around at
high usage. This does seem somewhat normal as far as I understand how
the kernel handles process memory.

In *most* cases its python getting an OOM exception when importing an
individual test, i.e. Line 1174:

module =3D importlib.import_module(os.path.splitext(s)[0])

Othertimes its non-fatal and some random python call (like
os.list_dir()) will OOM. And other times the kernel just throws a panic
and OOM's.

My guess with the import_module() case is that the test, and all its
import dependencies, is quite large to import in this fashion. This is
somewhat of a non-standard way of importing modules (rather than
'import <module>' at the top) but its needed for how test-runner
operates in a single python interpreter.

Thanks,
James

> =

> =

> Kind regard,
> =

> Paul
> =

> =

> PS: To be more specific in the commit message, you could use:
> =

> test-runner: Increase RAM size to 1 GB
> =

> > ---
> > =C2=A0 tools/test-runner | 13 ++++++++-----
> > =C2=A0 1 file changed, 8 insertions(+), 5 deletions(-)
> > =

> > diff --git a/tools/test-runner b/tools/test-runner
> > index b0ec87a2..534f08f2 100755
> > --- a/tools/test-runner
> > +++ b/tools/test-runner
> > @@ -1816,12 +1816,15 @@ class Main:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
smp =3D int(nproc / 2)
> > =C2=A0 =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0#
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# Increase RAM if valgrind is being used
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# TODO: Its unclear exactly what causes it (leak,
> > fragmentation,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# or ?), but after many test runs the kernel starts
> > running out
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# of memory. This is sometimes non-fatal, e.g. a
> > python call
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# fails, but other times the kernel fully panics.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0#
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if self.args.valgrind:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram =
=3D 512
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram =
=3D 384
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# For now increase the RAM which allows full test
> > runs to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# complete.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0#
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ram =3D 1024
> > =C2=A0 =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0print("Using %d cores, %d RAM for VM" % (smp, ra=
m))
> > =C2=A0 =



--===============1497526819619073906==--

