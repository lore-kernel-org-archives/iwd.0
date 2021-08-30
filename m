Content-Type: multipart/mixed; boundary="===============0460438837303556874=="
MIME-Version: 1.0
From: Jesus Gonzalez <jesusmgh@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Mon, 30 Aug 2021 18:47:54 +0000
Message-ID: <20210830184754.2717.75524@ml01.vlan13.01.org>
In-Reply-To: <25c80bed-e1f6-6e18-2516-779f0750cbc7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0460438837303556874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I got time to upgrade again and start iwd with debug output enabled, and ap=
parently it doesn't find any suitable BSS for the AP. Looking through the c=
ode, it goes through the PSK path (correct), and doesn't mistake it for a W=
PA2 AP (also correct) , but it still returns an empty list as far as availa=
ble and connectable BSS goes. I deleted the log by mistake, but the relevan=
t messages, taken from the code base, were:

station.c: autoconnect: No suitable BSSes found
wiphy.c: Network is WPA3-Personal...

And that's it. The scan shows the AP perfectly fine with all the correct in=
formation (as PSK) with full signal strength, but trying to connect it retu=
rns an empty list of BSS it can actually connect to.

Regards,
Jesus
--===============0460438837303556874==--

