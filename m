Content-Type: multipart/mixed; boundary="===============5180285543635317735=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/9] dpp: use frame data directly in unwrap for config
 response
Date: Mon, 20 Dec 2021 17:15:48 -0600
Message-ID: <472f6f31-a0d6-8b00-e3a2-44af63bbbd72@gmail.com>
In-Reply-To: 20211220214915.34093-1-prestwoj@gmail.com

--===============5180285543635317735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/20/21 15:49, James Prestwood wrote:
> Rather than hard coding ad0, use the actual frame data. There really
> isn't a reason this would differ (only status attribute) but just
> in case its better to use the frame data directly.
> ---
>   src/dpp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> =


Patches 1-3 applied, thanks.

Regards,
-Denis

--===============5180285543635317735==--

