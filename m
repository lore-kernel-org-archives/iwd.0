Content-Type: multipart/mixed; boundary="===============7533970438979878294=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] wscutil: Add wsc_build_m8_encrypted_settings
Date: Thu, 09 Jan 2020 14:10:14 -0600
Message-ID: <ec9d0f7e-f3da-2a1f-26f5-536a2e5bc148@gmail.com>
In-Reply-To: <20200109194019.8228-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7533970438979878294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/9/20 1:40 PM, Andrew Zaborowski wrote:
> Note it internally calls wsc_build_credential instead of the user
> having to do this.  I can convert wsc_parse_m8_encrypted_settings to do
> the same thing.

Do you mean to have parse_m8_encrypted_settings to return struct =

wsc_credential directly?  I think that'd be nice for consistency, yes. =

Anyway, I cut this note out of the commit.  This really belongs...

> ---
>   src/wscutil.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   src/wscutil.h |  4 ++++
>   2 files changed, 46 insertions(+)

here after the '---'

Patch 1 & 2 applied, thanks.

Regards,
-Denis
--===============7533970438979878294==--

