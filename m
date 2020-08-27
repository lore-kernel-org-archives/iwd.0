Content-Type: multipart/mixed; boundary="===============3726956836564318444=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/11] eap: Re-send Identity Request on EAPoL-Start
Date: Thu, 27 Aug 2020 13:53:17 -0500
Message-ID: <0de9dd69-e91c-0b35-5a29-d41f3a0487a2@gmail.com>
In-Reply-To: <20200827181453.61823-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3726956836564318444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> It looks like clients sometimes miss our unsolicited Identity Request
> and need a resend.
> ---
>   src/eap.c   | 12 ++++++++++--
>   src/eapol.c | 12 ++++++++----
>   2 files changed, 18 insertions(+), 6 deletions(-)
> =


Applied.

By the way, there are several implementations (Apple AirPort for example) t=
hat =

do not start WSC until an EAPoL-Start is sent.  I don't recall that EAPoL-S=
tart =

behavior was specified in WSC 1.0.  I know that one of my routers that uses=
 WSC =

2.0 doesn't do this and sends a RequestIdentity right away.  So that might =

explain what you're seeing here.

Regards,
-Denis
--===============3726956836564318444==--

