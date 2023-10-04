Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1A101FA
	for <iwd@lists.linux.dev>; Wed,  4 Oct 2023 13:13:24 +0000 (UTC)
Received: from smtpclient.apple (p5b3d2594.dip0.t-ipconnect.de [91.61.37.148])
	by mail.holtmann.org (Postfix) with ESMTPSA id 98AFACECD4;
	Wed,  4 Oct 2023 15:07:27 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] build: install iwd-decrypt-profile
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231003192456.4038590-1-prestwoj@gmail.com>
Date: Wed, 4 Oct 2023 15:07:17 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6D1FD48-E7AC-404B-936A-E4D5E3519FA2@holtmann.org>
References: <20231003192456.4038590-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi James,

> If profile encryption is enabled its not out of the question that
> somebody might need to decrypt it. This isn't a problem building
> from source but IWD as a package likely won't include the decrypt
> tool unless its specifically copied out. Add iwd-decrypt-profile
> to the list of installed programs like iwctl, iwmon, etc
>=20
> This also fixes a minor bug in Makefile.am which was building both
> iwd-profile-decrypt and probe-req if DAEMON was true. This should
> be TOOLS.
> ---
> Makefile.am | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 2e962153..ebabcf1c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -378,8 +378,9 @@ man_MANS +=3D wired/ead.8
> endif
> endif
>=20
> -if DAEMON
> -noinst_PROGRAMS +=3D tools/probe-req tools/iwd-decrypt-profile
> +if TOOLS
> +noinst_PROGRAMS +=3D tools/probe-req
> +bin_PROGRAMS +=3D tools/iwd-decrypt-profile
>=20
> tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu.h src/mpdu.c \
> src/ie.h src/ie.c \

I really prefer not installing that tool. If someone shoots themselves =
in the foot and need to recover, they can install it from the source. In =
addition, I do not want distributions cluster packages with random =
tools. That is going to get messy. If we ever think such a recover is =
needed, then it be better suited to be included in iwctl.

I moved both tools in DAEMON since once you disable iwd binary, none of =
them should be build either.

Regards

Marcel

