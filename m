Content-Type: multipart/mixed; boundary="===============0650434169723929060=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Wed, 26 Aug 2020 14:16:13 +0000
Message-ID: <c27e5303-48d9-04a4-4e73-cfea5470f357@gmail.com>
In-Reply-To: <20200826130010.GA3232@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0650434169723929060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On 8/26/20 8:00 AM, Herbert Xu wrote:
> On Wed, Aug 26, 2020 at 02:58:02PM +0200, Andrew Zaborowski wrote:
>>
>> Running iwd's and ell's unit tests I can see that at least the
>> following algorithms give EINVAL errors:
>> ecb(aes)
>> cbc(aes)
>> ctr(aes)
>>
>> The first one fails in recv() and only for some input lengths.  The
>> latter two fail in send().  The relevant ell code starts at
>> https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/cipher.c#n271
>>
>> The tests didn't get to the point where aead is used.
> =

> Yes ell needs to set MSG_MORE after sending the control message.
> Any sendmsg(2) without a MSG_MORE will be interpreted as the end
> of a request.

I'm just waking up now, so I might seem dense, but for my education, can yo=
u =

tell me why we need to set MSG_MORE when we issue just a single sendmsg fol=
lowed =

immediately by recv/recvmsg? ell/iwd operates on small buffers, so we don't =

really feed the kernel data in multiple send operations.  You can see this =
in =

the ell git tree link referenced in Andrew's reply.

According to https://www.kernel.org/doc/html/latest/crypto/userspace-if.htm=
l:

The send system call family allows the following flag to be specified:

     MSG_MORE: If this flag is set, the send system call acts like a cipher =

update function where more input data is expected with a subsequent invocat=
ion =

of the send system call.

So given what I said above, the documentation seems to indicate that MSG_MO=
RE =

flag should not be used in our case?

Regards,
-Denis

> =

> I'll work around this in the kernel though for the case where there
> is no actual data, with a WARN_ON_ONCE.
> =

> Thanks,
>=20

--===============0650434169723929060==--

