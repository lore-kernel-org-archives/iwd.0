Content-Type: multipart/mixed; boundary="===============9075431196573078798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] eap-tls-common.c: Fixed EAP-TLS connections when
 EAP-TLS-CACert option omitted
Date: Mon, 09 Mar 2020 22:29:00 -0500
Message-ID: <540632a7-2595-c31c-9bcf-a2b3f197f6b2@gmail.com>
In-Reply-To: <CAN37f0eHSrVL5KB3XdzGz_ScP9rr6w_d1mgAT6t8WMSNEpf0+g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9075431196573078798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Louis,

On 3/9/20 4:19 PM, Louis Whitburn wrote:
> iwd would fail to connect using EAP-TLS when no CA certificate was provid=
ed
> as it checked for successful loading of the CA certificate instead of the=
 client
> certificate when attempting to load the client certificate.
> =


Nice catch!

Patch has been applied after slight re-formatting of the commit description.

Regards,
-Denis
--===============9075431196573078798==--

