Content-Type: multipart/mixed; boundary="===============4391468921671307684=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 15/18] netconfig: Implement netconfig_get_dhcp_server_ipv4
Date: Mon, 13 Jul 2020 14:53:14 -0500
Message-ID: <530faeab-803f-5a26-90ab-a83fd9ab3d12@gmail.com>
In-Reply-To: <20200711010053.224223-15-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4391468921671307684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 7/10/20 8:00 PM, Andrew Zaborowski wrote:
> This uses l_dhcp_lease_get_server_id to get the IP of the server that
> offered us our current lease.  l_dhcp_lease_get_server_id returns the
> vaue of the L_DHCP_OPTION_SERVER_IDENTIFIER option, which is the address
> that any unicast DHCP frames are supposed to be sent to so it seems to
> be the best way to get the P2P group owner's IP address as a P2P-client.
> ---
>   src/netconfig.c | 14 ++++++++++++++
>   src/netconfig.h |  1 +
>   2 files changed, 15 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4391468921671307684==--

