Content-Type: multipart/mixed; boundary="===============3362843406500261029=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/2] peap: Add support for Crypto-Binding in PEAPv0
Date: Thu, 12 Dec 2019 15:14:45 -0600
Message-ID: <d3be5c60-052c-b4b2-c492-a67e70287b28@gmail.com>
In-Reply-To: <20191212201016.18072-2-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3362843406500261029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 12/12/19 2:10 PM, Tim Kourt wrote:
> The Crypto Binding TLV is used to ensure that the EAP peer and the
> EAP server participated in both the inner and the outer EAP
> authentications of a PEAP authentication by cryptographically associating
> the phase 1 and phase 2 authentications.
> =

> The usage of Crypto-Binding in PEAPv0 is optional and is triggered by
> the reception of the Crypto-Binding TLV from the server.
> ---
>   src/eap-peap.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 169 insertions(+), 1 deletion(-)
> =


I changed the -ENOENTs to -EBADMSG/-EIO since those make a bit more =

sense in the context of the handler.

Applied, thanks.

Regards,
-Denis

--===============3362843406500261029==--

