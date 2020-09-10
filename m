Content-Type: multipart/mixed; boundary="===============0482984584428400333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 13/17] p2p: Start a basic P2P Group after GO Negotiation
Date: Thu, 10 Sep 2020 09:39:35 -0500
Message-ID: <d0cb3932-129f-afd4-799e-63371bfbce45@gmail.com>
In-Reply-To: <20200908234933.301439-13-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0482984584428400333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

To follow up from the other discussion:

> +	/*
> +	 * Section 3.2.1: "The WPA2-Personal pass-phrase shall contain at
> +	 * least eight ASCII characters randomly selected with a uniform
> +	 * distribution from the following character set: upper case letters,
> +	 * lower case letters and numbers."
> +	 *
> +	 * However we don't currently respect the following text because
> +	 * our credentials will contain the passphrase and not the PSK.
> +	 * Section 3.2.1: "The Credentials for a P2P Group issued to a
> +	 * P2P Device shall: [...]
> +	 *  - Use a Network Key Type of 64 Hex characters."

So it looks to me like the spec wants you to deliver the credentials in Net=
work =

Key form, not a passphrase.  The exception is for 'Legacy Clients', which c=
an't =

connect anyway due to authorized_macs being restricted.  If we were to allo=
w =

that, how would we distinguish a legacy client ?

Also, this begs the question of whether we should generate per client keys.=
  I =

think that would actually be safer & more secure in the long run.  Thoughts?

Regards,
-Denis
--===============0482984584428400333==--

