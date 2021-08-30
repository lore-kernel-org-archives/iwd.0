Content-Type: multipart/mixed; boundary="===============5050949278455762313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Mon, 30 Aug 2021 14:01:18 -0500
Message-ID: <8fa81e4b-319b-d22a-bf80-b95794c8d72b@gmail.com>
In-Reply-To: <20210830184754.2717.75524@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5050949278455762313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesus,

> And that's it. The scan shows the AP perfectly fine with all the correct =
information (as PSK) with full signal strength, but trying to connect it re=
turns an empty list of BSS it can actually connect to.

All this means is that the network is not configured.  Since you're using N=
M, =

the iwd backend for NM wipes all its profiles from /var/lib/iwd when NM exi=
ts. =

So iwd has nothing to connect to.

Just use 'iwctl' to connect, get a log, and 'sudo rm =

/var/lib/iwd/<yourssid>.psk' afterwards.

See: https://iwd.wiki.kernel.org/gettingstarted

Regards,
-Denis
--===============5050949278455762313==--

