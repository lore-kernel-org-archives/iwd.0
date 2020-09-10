Content-Type: multipart/mixed; boundary="===============2378451467819095627=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: question on failed tests
Date: Wed, 09 Sep 2020 23:02:40 -0500
Message-ID: <a844f551-90dd-9675-bc70-d0ae9ba3c048@gmail.com>
In-Reply-To: <CAG17S_MekoU62j2LhNq_0wrn3Tnfa1vNPUYAkLPXHEB=nM0UQQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2378451467819095627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

> test-crypto.log:
> test-crypto: unit/test-crypto.c:397: aes_siv_test: Assertion =

> `aes_siv_encrypt(key, sizeof(key), plaintext, sizeof(plaintext), iov, 1, =

> outbuf)' failed.
> FAIL unit/test-crypto (exit status: 134)

Uh oh.  This is exactly the failures we were seeing on 5.8.4.  I wonder if =
your =

kernel is one of the stable ones?  Maybe it has received the same regressiv=
e =

behavior (via a backported fix) that kernel 5.8.4 did.

I would try applying the patch I linked to earlier from  Herbert and see if=
 it =

fixes things.

> test-wsc.log:
> test-wsc: unit/test-wsc.c:1993: verify_8021x: Assertion `len =3D=3D =

> data->expected_len' failed.
> FAIL unit/test-wsc (exit status: 134)
> =

> Can you give me some guidance on how to provide an strace?

denkenz(a)localhost ~/iwd-master $ strace unit/test-crypto

It might take a while and will produce a lots of output to stderr. Might be =

better if you can comment out everything except the bits related to the =

aes_siv_test...

Regards,
-Denis
--===============2378451467819095627==--

