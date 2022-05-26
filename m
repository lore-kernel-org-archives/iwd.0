Content-Type: multipart/mixed; boundary="===============2965331576556570297=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] eap-tls: Keep l_tls instance for reauthentication
Date: Thu, 26 May 2022 11:24:41 -0500
Message-ID: <0f936aa5-65a2-b42c-d7bb-33b3c9976837@gmail.com>
In-Reply-To: 20220526160153.64175-1-andrew.zaborowski@intel.com

--===============2965331576556570297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/26/22 11:01, Andrew Zaborowski wrote:
> After one of the eap-tls-common-based methods succeeds keep the TLS
> tunnel instance until the method is freed, rather than free it the
> moment the method succeeds.  This fixes repeated method runs where until
> now each next run would attempt to create a new TLS tunnel instance
> but would have no authentication data (CA certificate, client
> certificate, private key and private key passphrase) since those are
> were by the old l_tls object from the moment of the l_tls_set_auth_data()
> call.
> =

> Use l_tls_reset() to reset the TLS state after method success, followed
> by a new l_tls_start() when the reauthentication starts.
> ---
> Depends on the ell l_tls_reset patch.
> =

>   src/eap-tls-common.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2965331576556570297==--

