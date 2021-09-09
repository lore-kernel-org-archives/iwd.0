Content-Type: multipart/mixed; boundary="===============8071429589385685448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] auto-t: change testSAE timeout_test to use
 prefix_offset
Date: Thu, 09 Sep 2021 14:47:37 -0500
Message-ID: <db1bbe34-e28b-5002-5a7f-5596033c4c02@gmail.com>
In-Reply-To: <20210908224744.102156-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8071429589385685448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 5:47 PM, James Prestwood wrote:
> This makes things more clear on what frames are being blocked
> since it passes over header information to get to the actual
> SAE payload.
> ---
>   autotests/testSAE/timeout_test.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeou=
t_test.py
> index 1792f1c0..263f4e28 100644
> --- a/autotests/testSAE/timeout_test.py
> +++ b/autotests/testSAE/timeout_test.py
> @@ -49,7 +49,8 @@ class Test(unittest.TestCase):
>           rule0 =3D hwsim.rules.create()
>           rule0.source =3D bss_radio.addresses[0]
>           rule0.drop =3D True
> -        rule0.prefix =3D 'b0'
> +        rule0.prefix =3D '01 00 00 00 13 00'
> +        rule0.prefix_offset =3D 26

So I wonder if we might end up matching arbitrary frames this way?  Perhaps=
 we =

should keep the subtype prefix and add the prefix/prefix_offset as an addit=
ional =

match?

Something like
rule0.prefix =3D 'b0'
rule0.match0 =3D '01 00 00 00 13 00'
rule0.match0_offset =3D 26

>           rule0.match_times =3D 1
>           rule0.drop_ack =3D True
>           rule0.enabled =3D True

Regards,
-Denis
--===============8071429589385685448==--

