Content-Type: multipart/mixed; boundary="===============2096937928731848567=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Fri, 08 Nov 2019 21:08:27 -0600
Message-ID: <87d071de-cd02-e61e-9e6f-2b368bbf8eaf@gmail.com>
In-Reply-To: <20191108220402.10282-4-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2096937928731848567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 11/8/19 4:04 PM, Tim Kourt wrote:
> ---
>   src/scan.c | 82 ++++++++++++++++++++++++++++--------------------------
>   1 file changed, 42 insertions(+), 40 deletions(-)
> =


<snip>

>   =

> +static void scan_build_attr_tx_no_cck_rates(struct l_genl_msg *msg,
> +							struct scan_context *sc)

Given that this appends 2 attributes, I think the naming is misleading.

Regards,
-Denis
--===============2096937928731848567==--

