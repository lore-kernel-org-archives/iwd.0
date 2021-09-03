Content-Type: multipart/mixed; boundary="===============2103704922909170648=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netconfig: Actually use the DNS override values
Date: Fri, 03 Sep 2021 14:50:22 -0500
Message-ID: <acb3d7cc-d625-4fc7-2341-28896aa538ef@gmail.com>
In-Reply-To: <20210903200640.254482-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2103704922909170648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/3/21 3:06 PM, Andrew Zaborowski wrote:
> In netconfig_load_settings apply the DNS overrides strings we've loaded
> instead of leaking them.
> =

> Fixes: ad228461abbf ("netconfig: Move loading settings to new method, ref=
actor")
> ---
>   src/netconfig.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Both applied, thanks.

Regards,
-Denis

--===============2103704922909170648==--

