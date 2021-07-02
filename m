Content-Type: multipart/mixed; boundary="===============8672152232985375932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] netconfig: Reserve INET_ADDRSTRLEN chars for an IPv4
 string
Date: Fri, 02 Jul 2021 10:04:09 -0500
Message-ID: <9cc66a74-c5f7-2198-0d48-c3e317eb0f67@gmail.com>
In-Reply-To: <20210630190635.264095-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8672152232985375932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/30/21 2:06 PM, Andrew Zaborowski wrote:
> For consistency replace an INET6_ADDRSTRLEN instance with
> INET_ADDRSTRLEN in a strictly IPv4 context in
> netconfig_ipv4_select_and_install.
> ---
>   src/netconfig.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


FYI, Coverity (falsely) complains about this when l_rtnl_address_get_addres=
s is =

used with INET_ADDRSTRLEN, since it doesn't know about the family.

Maybe we should make an L_RTNL_* #define for this?

Regards,
-Denis
--===============8672152232985375932==--

