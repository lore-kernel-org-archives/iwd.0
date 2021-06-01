Content-Type: multipart/mixed; boundary="===============4337673798987468472=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] ip-pool: Track IPv4 addresses in use
Date: Tue, 01 Jun 2021 10:06:10 -0500
Message-ID: <7402bae9-f233-d2b9-f571-79ef2c59807f@gmail.com>
In-Reply-To: <20210528004737.2878442-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4337673798987468472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> Add the ip-pool submodule that tracks IPv4 addresses in use on the
> system for use when selecting the address for a new AP.  l_rtnl_address
> is used internally because if we're going to return l_rtnl_address
> objects it would be misleading if we didn't fill in all of their
> properties like flags etc.
> ---
>   Makefile.am   |   1 +
>   src/ip-pool.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ip-pool.h |  23 +++++++
>   3 files changed, 199 insertions(+)
>   create mode 100644 src/ip-pool.c
>   create mode 100644 src/ip-pool.h
> =


I s/l_rtnl_address_dup/l_rtnl_address_clone to match ell changes and..

Applied, thanks.

Regards,
-Denis

--===============4337673798987468472==--

