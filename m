Content-Type: multipart/mixed; boundary="===============3760170487281474045=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] eap-tls: Drop EAP-{TTLS,PEAP}-Client{Cert,Key}
Date: Mon, 25 Jan 2021 14:11:37 -0600
Message-ID: <8beb0378-aa53-475b-0a30-f5cf0298d6f6@gmail.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3760170487281474045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/25/21 11:56 AM, Andrew Zaborowski wrote:
> As requested move the client certificate and private key loading from
> eap-tls-common.c to eap-tls.c.  No man page change needed because those
> two settings weren't documented in it in the first place.
> ---
>   src/eap-tls-common.c | 239 ++++---------------------------------------
>   src/eap-tls-common.h |   9 ++
>   src/eap-tls.c        | 237 ++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 260 insertions(+), 225 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============3760170487281474045==--

