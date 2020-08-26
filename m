Content-Type: multipart/mixed; boundary="===============9212958154350450201=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Wed, 26 Aug 2020 15:42:39 +0000
Message-ID: <CAMj1kXEn507bEt+eT6q7MpCwNH=oAZsTkFRz0t=kPEV0QxFsOQ@mail.gmail.com>
In-Reply-To: <4bb6d926-a249-8183-b3d9-05b8e1b7808a@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9212958154350450201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Aug 2020 at 17:33, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Herbert,
>
> On 8/26/20 9:19 AM, Herbert Xu wrote:
> > On Wed, Aug 26, 2020 at 08:57:17AM -0500, Denis Kenzior wrote:
> >>
> >> I'm just waking up now, so I might seem dense, but for my education, c=
an you
> >> tell me why we need to set MSG_MORE when we issue just a single sendmsg
> >> followed immediately by recv/recvmsg? ell/iwd operates on small buffer=
s, so
> >> we don't really feed the kernel data in multiple send operations.  You=
 can
> >> see this in the ell git tree link referenced in Andrew's reply.
> >
> > You obviously don't need MSG_MORE if you're doing a single sendmsg.
> >
> > The problematic code is in l_cipher_set_iv.  It does a sendmsg(2)
> > that expects to be followed by more sendmsg(2) calls before a
> > recvmsg(2).  That's the one that needs a MSG_MORE.
> >
>
> Gotcha.  I fixed the set_iv part now in ell:
> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D87c76bbc85fe=
286925cbdb53d733fc9f9fd2ed12
>

Interestingly, that change alone (without the kernel side fix that
Herbert just provided) is not sufficient to make the self tests work
again.

I still get a failure in aes_siv_encrypt(), which does not occur with
the kernel side fix applied.
--===============9212958154350450201==--

