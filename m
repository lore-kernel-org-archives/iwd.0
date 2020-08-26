Content-Type: multipart/mixed; boundary="===============2069939549684481212=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Wed, 26 Aug 2020 15:33:58 +0000
Message-ID: <4bb6d926-a249-8183-b3d9-05b8e1b7808a@gmail.com>
In-Reply-To: <20200826141907.GA5111@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2069939549684481212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On 8/26/20 9:19 AM, Herbert Xu wrote:
> On Wed, Aug 26, 2020 at 08:57:17AM -0500, Denis Kenzior wrote:
>>
>> I'm just waking up now, so I might seem dense, but for my education, can=
 you
>> tell me why we need to set MSG_MORE when we issue just a single sendmsg
>> followed immediately by recv/recvmsg? ell/iwd operates on small buffers,=
 so
>> we don't really feed the kernel data in multiple send operations.  You c=
an
>> see this in the ell git tree link referenced in Andrew's reply.
> =

> You obviously don't need MSG_MORE if you're doing a single sendmsg.
> =

> The problematic code is in l_cipher_set_iv.  It does a sendmsg(2)
> that expects to be followed by more sendmsg(2) calls before a
> recvmsg(2).  That's the one that needs a MSG_MORE.
> =


Gotcha.  I fixed the set_iv part now in ell:
https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D87c76bbc85fe28=
6925cbdb53d733fc9f9fd2ed12

Regards,
-Denis
--===============2069939549684481212==--

