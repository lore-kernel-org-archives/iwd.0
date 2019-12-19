Content-Type: multipart/mixed; boundary="===============0245820227703997460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] peap: Ignore Crypto-Binding TLVs with invalid compound
 MACs
Date: Wed, 18 Dec 2019 23:47:41 -0600
Message-ID: <d02185b5-4df4-cd03-0fe8-64c480e83641@gmail.com>
In-Reply-To: <20191219004239.7132-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0245820227703997460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 12/18/19 6:42 PM, Tim Kourt wrote:
> Some server implementation don't seem to provide the valid compound MACs.
> In the meantime, iwd will ignore the invalid Crypto-Binding TLVs as their
> usage is optional.
> ---
>   src/eap-peap.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============0245820227703997460==--

