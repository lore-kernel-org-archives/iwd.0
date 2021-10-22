Content-Type: multipart/mixed; boundary="===============0957571344621697911=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 04/12] netconfig: Track DNS address string lists
Date: Fri, 22 Oct 2021 12:17:25 -0500
Message-ID: <def42f5b-07ea-786a-6f04-71f116a5160f@gmail.com>
In-Reply-To: 20211021085041.294524-4-andrew.zaborowski@intel.com

--===============0957571344621697911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/21 3:50 AM, Andrew Zaborowski wrote:
> Cache the latest v4 and v6 DNS IP string lists in struct netconfig state
> to be able to more easily detect changes in those values in future
> commits.  For that split netconfig_set_dns's code into this function,
> which now only commit the values in netconfig->dns{4,6}_list to the
> resolver, and netconfig_dns_list_update() which figures out the active
> DNS IP address list and saves it in netconfig->dns{4,6} list.  This
> probably saves some cycles as the callers can now decide to only
> recalculate the dns_list which may have changed.
> =

> While there simplify netconfig_set_dns return type to void as the result
> was always 0 anyway and was never checked by callers.
> ---
>   src/netconfig.c | 101 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 60 insertions(+), 41 deletions(-)
> =


Patches 4-6 applied, thanks.

Regards,
-Denis

--===============0957571344621697911==--

