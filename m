Content-Type: multipart/mixed; boundary="===============1897810080130110647=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] ip-pool: Add subnet address selection logic
Date: Tue, 01 Jun 2021 10:13:29 -0500
Message-ID: <b0458196-d0c1-448e-7d50-c6445c2054b4@gmail.com>
In-Reply-To: <20210528004737.2878442-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1897810080130110647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> Add the ip_pool_select_addr4 function to select a random subnet of reques=
ted
> size from an address space defined by a string list (for use with the
> AP profile [IPv4].Address and the global [IPv4].APAddressPool settings),
> avoiding those subnets that conflict with subnets in use.  We take care
> to give a similar weight to all subnets contained in the specified
> ranges regardless of how many ranges contain each, basically so that
> overlapping ranges don't affect the probabilities (debatable.)
> ---
>   src/ip-pool.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ip-pool.h |   2 +
>   2 files changed, 208 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============1897810080130110647==--

