Content-Type: multipart/mixed; boundary="===============2719943000276436106=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] doc: Add net.connman.iwd.NetworkConfiguration API doc
Date: Fri, 02 Jul 2021 09:49:10 -0500
Message-ID: <6109e088-87b0-7b3c-14fd-abe25faf539a@gmail.com>
In-Reply-To: <20210630190635.264095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2719943000276436106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/30/21 2:06 PM, Andrew Zaborowski wrote:
> ---
>   doc/network-configuration-api.txt | 52 +++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 doc/network-configuration-api.txt
> =

> diff --git a/doc/network-configuration-api.txt b/doc/network-configuratio=
n-api.txt
> new file mode 100644
> index 00000000..5c302a37
> --- /dev/null
> +++ b/doc/network-configuration-api.txt
> @@ -0,0 +1,52 @@
> +Network Configuration hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		net.connman.iwd
> +Interface	net.connman.iwd.NetworkConfiguration [Experimental]
> +Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/{ipv4,ipv6}

Encoding anything into the object path is a discouraged design pattern.  Yo=
u'd =

be better off instantiating multiple interfaces on the same object instead,=
 one =

for IPv4 and one for IPv6.  That way you could even evolve the IPv4/IPv6 =

interfaces separately.

Alternatively, you could have a single interface with multiple dictionaries=
...

> +Object path	/net/connman/iwd/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_f=
f}
> +
> +Properties	object Device [readonly]

Given the above, this property would then likely become redundant and could=
 be =

removed.

> +
> +			The object path of the station, access point or P2P
> +			device that this network configuration is active on.
> +
> +			In station mode, when network configuration is
> +			enabled there may be one or two objects using this
> +			interface and active on the same device: two if both
> +			IPv4 and IPv6 addresses have been configured.
> +
> +			In P2P mode, this interface always refers to IPv4
> +			network configuration.
> +
> +		string Method [readonly]
> +
> +			Indicates whether the local address was set
> +			statically (value "static") or obtained automatically
> +			such as through DHCP (value "auto").  Even when the
> +			address was obtained from the remote end some
> +			configuration bits, such as DNS addresses, may have
> +			been overridden locally.
> +
> +		string Address [readonly]
> +
> +			Holds the local IP address.
> +
> +		byte PrefixLength [readonly]
> +
> +			Holds the prefix-length of the local subnet.  For
> +			IPv4 this maps to the netmask.
> +
> +		string Gateway [readonly, optional]
> +
> +			Holds the gateway address for the IPv4 subnet if one
> +			exists.
> +
> +		array(string) DomainNameServers [readonly, optional]
> +
> +			Holds the list of domain name servers configured if
> +			any.

Do you need positional information here?  Does NM need to know in what orde=
r the =

name servers should be set between IPv6/IPv4?

> +
> +		string DomainNames [readonly, optional]

Why DomainNames (plural) when the type is a single string?

> +
> +			Holds the network's local domain names if any exist.
> =


Regards,
-Denis
--===============2719943000276436106==--

