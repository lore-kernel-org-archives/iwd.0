Content-Type: multipart/mixed; boundary="===============1499626023147985433=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] p2p: fix out of scope read
Date: Fri, 30 Jul 2021 10:40:48 -0500
Message-ID: <198e5a5e-cf07-e418-145e-1b47bf35c408@gmail.com>
In-Reply-To: <20210730150727.199809-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1499626023147985433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/30/21 10:07 AM, James Prestwood wrote:
> The authorized macs pointer was being set to either the wsc_beacon
> or wsc_probe_response structures, which were initialized out of
> scope to where 'amacs' was being used. This resulted in an out of
> scope read, caught by address sanitizers.
> ---
>   src/p2p.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1499626023147985433==--

