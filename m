Content-Type: multipart/mixed; boundary="===============1036274094029674854=="
MIME-Version: 1.0
From: caljorden@hotmail.com
Subject: Issue with iwd 1.3 + systemd-resolved + iwd's built-in network
 configuration not adding DNS servers
Date: Mon, 16 Dec 2019 07:48:39 +0000
Message-ID: <20191216074839.2770.41114@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1036274094029674854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I have hit an issue with iwd 1.3 on Arch Linux (also reported in arch bug t=
racker https://bugs.archlinux.org/task/64855) where with a minimal iwd conf=
iguration using the built-in network configuration and systemd-resolved for=
 DNS, iwd 1.3 does not properly add the DNS servers to systemd-resolved.

I saw this first on my laptop, which I temporarily worked around by simply =
disabling the internal network configuration and manually running dhclient.=
  But, once I updated Arch on my workstation, and hit the same issue, I tho=
ught I should report it.  I opened the bug in Arch's bug system, not knowin=
g (and still not entirely sure) if the issue is specific to Arch Linux or n=
ot.

I found that by reverting the commit 930528e35, and removing one call to th=
e added function that had been added after this patch was applied, the prob=
lem went away.

I am not sure if this is some bad interaction between iwd and systemd-resol=
ved in Arch, or some wider issue.  I have hit this issue on my home network=
 using WPA2-PSK, as well as my work network (WPA2 Enterprise), so I do not =
think this is related to the network type of the connection.  My iwd/main.c=
onf file looks like this:

---------------
[General]
EnableNetworkConfiguration=3Dtrue

[Network]
NameResolvingService=3Dsystemd
---------------

Thank you,

Caleb Jorden
--===============1036274094029674854==--

