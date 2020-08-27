Content-Type: multipart/mixed; boundary="===============1872296458435838526=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 02/11] eap: Re-send Identity Request on EAPoL-Start
Date: Thu, 27 Aug 2020 22:47:17 +0200
Message-ID: <CAOq732J7_bJ9Kb-DuJbe-eyGcDiuGm-JAKRzbz3KeEoPZrGK0g@mail.gmail.com>
In-Reply-To: <0de9dd69-e91c-0b35-5a29-d41f3a0487a2@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1872296458435838526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 20:55, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> > It looks like clients sometimes miss our unsolicited Identity Request
> > and need a resend.
> > ---
> >   src/eap.c   | 12 ++++++++++--
> >   src/eapol.c | 12 ++++++++----
> >   2 files changed, 18 insertions(+), 6 deletions(-)
> >
>
> Applied.
>
> By the way, there are several implementations (Apple AirPort for example)=
 that
> do not start WSC until an EAPoL-Start is sent.  I don't recall that EAPoL=
-Start
> behavior was specified in WSC 1.0.  I know that one of my routers that us=
es WSC
> 2.0 doesn't do this and sends a RequestIdentity right away.  So that might
> explain what you're seeing here.

So I intended to mention this separately but the spec recommends that
we send the EAP Identity request automatically if the enrollee is WSC
2.0 and it prohibits us doing this if it's WSC 1.0.  I think there's
probably no harm trying it until we see it throws off some device.

In my case an Android device replied to my initial Identity Request in
three attempts, but on one occasion it apparently missed the request,
sent the EAPoL-Start after a timeout and waited for a new Identity
Request.

Best regards
--===============1872296458435838526==--

