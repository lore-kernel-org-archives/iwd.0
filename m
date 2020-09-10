Content-Type: multipart/mixed; boundary="===============3586801134328050192=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: question on failed tests
Date: Wed, 09 Sep 2020 20:08:52 -0500
Message-ID: <decb9567-4e29-1ea5-a5a0-0038b213a930@gmail.com>
In-Reply-To: <CAG17S_OCB-S22fyvmmj2T59JX0_sYesvur_P7kOST=3kd2jAHg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3586801134328050192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

No top-posting please :)

On 9/9/20 7:48 PM, KeithG wrote:
> Denis,
> =

> I built the kernel and tried building it again. This time I get 2 errors =
on armv7:
>  =C2=A0 CC =C2=A0 =C2=A0 =C2=A0 unit/test-crypto.o
>  =C2=A0 CCLD =C2=A0 =C2=A0 unit/test-crypto
> ./build-aux/test-driver: line 107: =C2=A09846 Aborted =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (core dumped) " =

>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$@" > $log_file 2>&1
> FAIL: unit/test-crypto
> ...
>  =C2=A0 CC =C2=A0 =C2=A0 =C2=A0 unit/test-wsc.o
>  =C2=A0 CCLD =C2=A0 =C2=A0 unit/test-wsc
> ./build-aux/test-driver: line 107: 10643 Aborted =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (core dumped) " =

>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$@" > $log_file 2>&1
> FAIL: unit/test-wsc
> =


Can you provide unit/test-crypto.log and unit/test-wsc.log from these syste=
ms?

Also, can you run strace on both manually and provide logs from that?

> The intel and arm stuff differs and some of the keys are not present. I d=
o not =

> know if I should brute them in there. The config I used is attached. This=
 is on =

> a RaspberryPi4 running this kernel 5.4.61-2 armv7h

CONFIG_KEY_DH_OPERATIONS is required for WPS/P2P support.

CONFIG_PKCS8_PRIVATE_KEY_PARSER is required for EAP-TLS.

Regards,
-Denis
--===============3586801134328050192==--

